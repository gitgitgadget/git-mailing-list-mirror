From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Tue, 10 Feb 2009 23:23:42 +0200
Message-ID: <878woet28x.fsf@jondo.cante.net>
References: <20090205204436.GA6072@diku.dk>
	<20090209220750.GA27232@m62s10.vlinux.de>
	<20090209222236.GA4166@coredump.intra.peff.net>
	<20090209223044.GB27232@m62s10.vlinux.de>
	<2c6b72b30902101042o64a1a490ge18af497faa747c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Baumann <waste.manager@gmx.de>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Tue Feb 10 22:25:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX06Y-0002vi-RS
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 22:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755347AbZBJVXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 16:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754585AbZBJVXv
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 16:23:51 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:39332 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562AbZBJVXu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 16:23:50 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 4991FC81EA;
	Tue, 10 Feb 2009 23:23:48 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A00308F3CD7; Tue, 10 Feb 2009 23:23:47 +0200
Received: from jondo.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 42466158A63;
	Tue, 10 Feb 2009 23:23:42 +0200 (EET)
In-Reply-To: <2c6b72b30902101042o64a1a490ge18af497faa747c5@mail.gmail.com>
	(Jonas Fonseca's message of "Tue, 10 Feb 2009 19:42:32 +0100")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109315>

Jonas Fonseca <fonseca@diku.dk> writes:

> On Mon, Feb 9, 2009 at 23:30, Peter Baumann <waste.manager@gmx.de> wrote:
>
>> On Mon, Feb 09, 2009 at 05:22:36PM -0500, Jeff King wrote:
>>> Don't the up and down arrows switch the commit (updating the diff pane
>>> as appropriate), and PgUp/PgDown scroll the diff window (I don't know
>>> the actual function names, but you should be able to even rebind these
>>> in your tigrc if you want).
>>
>> Damn. I'm so used to the vi keybindings pressing j/k to move down/up
>> that I didn't check the cursor keys.
>
> Well, initially tig worked similar to what you expected and a program
> like slrn, where up/down (or j/k) moves between articles (commits) and
> you have to press enter to actually show/load the commit in the diff
> view. This mode might be more natural, and Jari has argued that it
> would make tig (and it's many forks) more bearable to on Cygwin
> running on an old PC.

It also helps when you want to see only particular commit; you scroll to
correct location as ask display by pressing RET. If aut-update is in
effect, the other commits in between tie up the cursor movement,
especially if the history is long: tap, tap, tap .... and you'd have to
wait for all all screen to update line by line.

Idea: The auto-update feature could be even turned on/off with a
command-key . But an comand line option would do for me, as long as the
behaviot is configurable. It is slow under Cygwin, especially on
networked case, where Cygwin resides on remote disk, not the local one.

Jari

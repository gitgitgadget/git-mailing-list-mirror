From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH] Documentation/git-remote.txt: remove description for
 useless -n option
Date: Mon, 09 Jun 2008 02:43:42 +0200
Message-ID: <484C7CBE.4070700@free.fr>
References: <484B2DD3.8050307@free.fr> <1212927772-10006-1-git-send-email-dkr+ml.git@free.fr> <7v63sjk6yo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 02:44:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5VUk-0004H1-Um
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 02:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756467AbYFIAn3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jun 2008 20:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755710AbYFIAn3
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 20:43:29 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:55347 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754637AbYFIAn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 20:43:28 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id B768B12B6BC;
	Mon,  9 Jun 2008 02:43:27 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id BA3A412B6B1;
	Mon,  9 Jun 2008 02:43:26 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <7v63sjk6yo.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84351>

Junio C Hamano a =E9crit :
>> From: Olivier Marin <dkr@freesurf.fr>
>>
>> This option comes from the original git-remote.perl script and is no=
t
>> used nor needed in the current builtin.
>=20
> Is this something we would want to document as a new feature, or just=
 a
> regression that makes the existing feature unusable when disconnected=
 from
> the network that needs to be fixed in the code?

OK, I restored the original behaviour for "git remote show", patch will=
 follow.

But for "git remote prune" I don't no what to do. The perl script behav=
iour was
to delete all refs for the remote when called with -n. It seems really =
dangerous
to me, especially if I have no connection to restore them. The current =
builtin
doesn't honor the flag and with my patch it just does nothing.

So, do you prefere that I remove the documentation for git remote prune=
 -n or
restore the old behaviour that was probably never used (but maybe I'm w=
rong)?

Olivier.

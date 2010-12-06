From: Yann Dirson <dirson@bertin.fr>
Subject: Re: What's cooking in git.git (Dec 2010, #01; Sat, 4)
Date: Mon, 06 Dec 2010 12:31:36 +0100
Organization: Bertin Technologies
Message-ID: <20101206123136.2acab63a@chalon.bertin.fr>
References: <7v62v8ufyl.fsf@alter.siamese.dyndns.org>
 <20101206082948.1403cc5a@chalon.bertin.fr>
 <buopqtfmi85.fsf@dhlpc061.dev.necel.com>
 <20101206092122.21c19011@chalon.bertin.fr>
 <AANLkTimPC3-x1XFJ+t9uiFFXV6fg812ugF5vz9p=4GWB@mail.gmail.com>
 <20101206094806.10ae1ff2@chalon.bertin.fr>
 <AANLkTinJu0KzXZ2Rjbs2+XH7T=Gq5MOajxo51DHtqoGZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, git list <git@vger.kernel.org>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Dec 06 12:42:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPZSC-0008DM-7r
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 12:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162Ab0LFLly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 06:41:54 -0500
Received: from blois.bertin.fr ([195.68.26.9]:45213 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751610Ab0LFLlx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 06:41:53 -0500
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 7CB5C5437A
	for <git@vger.kernel.org>; Mon,  6 Dec 2010 12:41:52 +0100 (CET)
Received: from YPORT1 (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id 46B8B5437B
	for <git@vger.kernel.org>; Mon,  6 Dec 2010 12:41:52 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0LD000HVQ8HRFW40@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Mon, 06 Dec 2010 12:41:52 +0100 (CET)
In-reply-to: <AANLkTinJu0KzXZ2Rjbs2+XH7T=Gq5MOajxo51DHtqoGZ@mail.gmail.com>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8200-6.0.0.1038-17812.000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162993>

On Mon, 06 Dec 2010 18:13:06 +0900
Miles Bader <miles@gnu.org> wrote:

> On Mon, Dec 6, 2010 at 5:48 PM, Yann Dirson <dirson@bertin.fr> wrote:
> it's is normal and good that option names are sometimes revisited and
> improved -- nothing is perfect on the first try.  By keeping the old
> option around as a deprecated alias, we avoid compatibility issues.

... except Junio advocates *not* deprecating this one, since it is here
since ages.

> That doesn't mean there aren't _any_ issues, but they tend to be
> pretty minor  (such as the "space used by the deprecation option" that
> you complain about).
> 
> Maybe if you renamed every option simultaneously, there would be
> confusion, but seriously, it's only one option.  It's not going to be
> a problem.

I'm not sure we want to use "it's only one option" as an excuse.  It
can easily become a bad habit.

> There is no "usability" problem.

Completion of "git diff --<TAB>" in stable branch gives 44 choices here.
One of the most frequent criticisms about git I hear among coworkers is
that there are so many commands and options.  Will be funny to explain
them that "we just added another one, for no technical reason".

-- 
Yann Dirson - Bertin Technologies

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Bizarre missing changes (git bug?)
Date: Wed, 30 Jul 2008 01:36:11 -0700 (PDT)
Message-ID: <m3iqunu5u3.fsf@localhost.localdomain>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com>
	<200807260512.40088.zippel@linux-m68k.org>
	<alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org>
	<Pine.LNX.4.64.0807270049290.6791@localhost.localdomain>
	<alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org>
	<Pine.LNX.4.64.0807272101470.6791@localhost.localdomain>
	<alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org>
	<Pine.LNX.4.64.0807280141140.6791@localhost.localdomain>
	<alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org>
	<Pine.LNX.4.64.0807281241180.6791@localhost.localdomain>
	<46a038f90807282015m7ce3da10h71dfee221c960332@mail.gmail.com>
	<Pine.LNX.4.64.0807291433430.6791@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Roman Zippel <zippel@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 10:37:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO7BN-00037g-Ig
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 10:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439AbYG3IgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 04:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752478AbYG3IgQ
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 04:36:16 -0400
Received: from ik-out-1112.google.com ([66.249.90.177]:2286 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395AbYG3IgP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 04:36:15 -0400
Received: by ik-out-1112.google.com with SMTP id c28so315532ika.5
        for <git@vger.kernel.org>; Wed, 30 Jul 2008 01:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=lRoBj/KwWF1JRVu54KDswKgTZ7YnCc+E1Z2KkMrJssM=;
        b=s84NLef5U3SqcRKCYceruNIhujHG2qpEGthmJMnwsxc+J5DpPFML4/7AdlNIptkYno
         RD7WdtkNrysQtXaILQtlZiy/i3ocnRbelEPIiM5frtBcchrO+I1/xvZ89gjOQ1LkFNox
         n+6KeygCUrzTU2PpESOQXVjUWUNd0rumtcxq0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=om9QeAUgvVGu6I1JE/oVhD/veCSf4JEul3AGT4wYzdv64NN6nR1dOBFeBS5XFiYJWU
         2nHdaTMXMMXUAM0C11rnl2FdJgX5WFlyqJRwK2dfjYxbwTUM1J2TsneoiCR8skOdR88p
         lRiS6PCTuRs+PiORjh0Qk5cU5cFCUMSeSU4rk=
Received: by 10.210.51.18 with SMTP id y18mr8834737eby.160.1217406974023;
        Wed, 30 Jul 2008 01:36:14 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.207.231])
        by mx.google.com with ESMTPS id z40sm1588481ikz.7.2008.07.30.01.36.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Jul 2008 01:36:11 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6U8a7O1016699;
	Wed, 30 Jul 2008 10:36:08 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6U8a5nh016696;
	Wed, 30 Jul 2008 10:36:05 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <Pine.LNX.4.64.0807291433430.6791@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90758>

Roman Zippel <zippel@linux-m68k.org> writes:

> I don't quite understand what you're trying to say.
> To avoid further confusion it maybe helps to specify a few of the terms:
> 
> - full history graph: produced by "git-log --full-history --parents"
> - compact history graph: the full history graph without without any 
>   repeated merges, this is what my example script produces.
> - full simplified history: output of "git-log --full-history"
> - short simplified history: standard output of "git-log"
[...]

> Keep in mind that e.g. git-web is using the full simplified history, so 
> what I'm offering also has the potential to improve git-web performance...

The fact that gitweb is using --full-history for a 'history' view
is a historical reason, backwards compatibility with the view that
was shown before gitweb used "git rev-list [flags] -- <path>", see
commit cdd4037d

    gitweb: optimize per-file history generation
    
    The rev-list command that is recent enough can filter commits
    based on paths they touch, so use it instead of generating the
    full list and limiting it by passing it with diff-tree --stdin.
    
    [jc: The patch originally came from Luben Tuikov but the it was
     corrupt, but it was short enough to be applied by hand.  I
     added the --full-history to make the output compatible with the
     original while doing so.]
    
    Signed-off-by: Junio C Hamano <junkio@cox.net>

Removing '--parents' was put later, to remove unnecessary merges
from a view (there was long discussion on git mailing list about
--full-history with and without --parents), in 208b2dff

    gitweb: We do longer need the --parents flag in rev-list.
    
    We only want to know the direct parents of a given commit object,
    these parents are available in the --header output of rev-list.  If
    --parents is supplied with --full-history the output includes merge
    commits that aren't relevant.
    
    Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
    Signed-off-by: Junio C Hamano <junkio@cox.net>

Besides gitweb currently does not generate graphical history view,
so '--parents' are unnecessary.

But if it was done from the scratch, gitweb should definitely
use simplified history, instead of what you call "full simplified
history", perhaps with an option to use '--full-history' (there
is infractructure in gitweb for adding extra options).


(Nitpick: it is 'gitweb', not 'git-web'.)
-- 
Jakub Narebski
Poland
ShadeHawk on #git

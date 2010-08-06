From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: Use shell to launch textconv filter in "blame"
Date: Fri, 06 Aug 2010 18:56:33 +0100
Message-ID: <87eieby69a.fsf@fox.patthoyts.tk>
References: <vpqlj8l2xd5.fsf@bauges.imag.fr>
	<1281002722-3042-1-git-send-email-Matthieu.Moy@imag.fr>
	<87aap0sljs.fsf@fox.patthoyts.tk> <vpqaap0cees.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Aug 06 19:57:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhRAC-0001Ey-T3
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 19:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759354Ab0HFR4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 13:56:54 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:52975 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757282Ab0HFR4x (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Aug 2010 13:56:53 -0400
Received: from [172.23.170.142] (helo=anti-virus02-09)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1OhR9y-0004dI-U8; Fri, 06 Aug 2010 18:56:47 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out5.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1OhR9n-0007rI-Eq; Fri, 06 Aug 2010 18:56:35 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id CC029200E0; Fri,  6 Aug 2010 18:56:34 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <vpqaap0cees.fsf@bauges.imag.fr> (Matthieu Moy's message of "Fri,
	06 Aug 2010 10:51:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152799>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
[snip]
>
>I'm not very fluent in Tcl, but I don't think this runs the command
>through a shell (pstree agrees with me). That will work in most cases,
>so that may be acceptable, but if you want to have full compatibility
>with what "git blame" does (by using a shell) and allow e.g.
>
>textconv = LANG=C some-command
>
>or
>
>textconv = cd ../; do-whatever
>
>which are already managed by "git blame" and are OK with my version,
>it's not going to do it.

OK compatibility with 'git blame' is a valid reason to do it your
way. Tcl's exec (or open| is equivalent) doesn't go via shell. I'll
check this on windows and apply it. Thanks.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD

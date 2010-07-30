From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: use textconv filter for diff and blame
Date: Fri, 30 Jul 2010 11:30:01 +0100
Message-ID: <878w4tz2hi.fsf@fox.patthoyts.tk>
References: <1280319830-20483-1-git-send-email-Matthieu.Moy@imag.fr>
	<871valstsi.fsf@fox.patthoyts.tk> <vpq8w4tpie2.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Clemens Buchacher <drizzd@aon.at>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 30 12:31:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oemro-0003SV-Dt
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 12:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758244Ab0G3Kah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 06:30:37 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:53971 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756390Ab0G3Kae (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jul 2010 06:30:34 -0400
Received: from [172.23.170.137] (helo=anti-virus01-08)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1OemrD-00017y-Cc; Fri, 30 Jul 2010 11:30:27 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out1.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1Oemqo-0007pA-HD; Fri, 30 Jul 2010 11:30:02 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id EF4F021EC5; Fri, 30 Jul 2010 11:30:01 +0100 (BST)
X-Url: http://www.patthoyts.tk/
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
In-Reply-To: <vpq8w4tpie2.fsf@bauges.imag.fr> (Matthieu Moy's message of "Fri\, 30 Jul 2010 08\:56\:37 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152238>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>Pat Thoyts <patthoyts@users.sourceforge.net> writes:
>
>> This looks generally fine but can you suggest some test that I can use
>> to ensure it is actually doing something. I tried committing some test
>> files containing cyrillic characters but I see no difference between
>> using an unpatched git-gui and your patched version with git 1.7.2
>
>textconv has not much to do with encoding. It's a way to tell git the
>name of a command that converts a file into plain text. Typical usages
>would be to use odt2txt, catdoc/antiword, or meta-information
>extraction (like exiftags).
>
>Have a look here:
>
>  https://git.wiki.kernel.org/index.php/Textconv
>

OK thanks. This works very nicely once configured. I've applied it and
pushed this plus some outstanding git-gui patches from msysgit to the
git-gui repository at git://repo.or.cz/git-gui.git

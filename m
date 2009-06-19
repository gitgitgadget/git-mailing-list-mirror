From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: Windows 7 and git-gui/gitk language
Date: 19 Jun 2009 21:19:48 +0100
Message-ID: <877hz80ye3.fsf@users.sourceforge.net>
References: <alpine.DEB.2.00.0906181200460.23400@ds9.cixit.se>
	<87fxdw0zin.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Jun 19 22:20:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHkZH-0002cC-CF
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 22:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbZFSUTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2009 16:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbZFSUTy
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 16:19:54 -0400
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:40116 "EHLO
	smtp-out2.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750728AbZFSUTx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jun 2009 16:19:53 -0400
Received: from [172.23.170.143] (helo=anti-virus02-10)
	by smtp-out2.blueyonder.co.uk with smtp (Exim 4.52)
	id 1MHkZ1-0000wv-G3; Fri, 19 Jun 2009 21:19:55 +0100
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out4.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1MHkZ0-0006h7-Uw; Fri, 19 Jun 2009 21:19:54 +0100
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 773E351842; Fri, 19 Jun 2009 21:19:49 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <87fxdw0zin.fsf@users.sourceforge.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121907>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

>If you fire up wish on its own (it is installed with msys Git) and
>enter 'package require msgcat; msgcat::mclocale' in the console window
>it should be showing something other than 'en' if your Windows
>installation is non-English. There might be a bug for the Tcl people
>here (comp.lang.tcl or the sourceforge bug tracker).
>

To follow-up on myself - the msgcat locale is set on Windows by
reading a value out of the registry. This seems to have changed on
Windows 7 now so the locale always gets defaulted to 'C'. I'll raise a
bug with the tcl project and get a fix done.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD

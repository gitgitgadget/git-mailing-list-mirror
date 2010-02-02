From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: use themed tk widgets with Tk 8.5
Date: Tue, 02 Feb 2010 21:09:09 +0000
Message-ID: <874olzmjka.fsf@users.sourceforge.net>
References: <878wbln0oa.fsf@users.sourceforge.net>
	<4B67E183.3010800@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Feb 02 22:09:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcPzr-0003YR-IT
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 22:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756400Ab0BBVJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 16:09:14 -0500
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:44896 "EHLO
	smtp-out2.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756270Ab0BBVJN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2010 16:09:13 -0500
Received: from [172.23.170.137] (helo=anti-virus01-08)
	by smtp-out2.blueyonder.co.uk with smtp (Exim 4.52)
	id 1NcPzj-00048A-HX; Tue, 02 Feb 2010 21:09:11 +0000
Received: from [77.99.239.132] (helo=badger.patthoyts.tk)
	by asmtp-out2.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1NcPzi-0007sX-Q3; Tue, 02 Feb 2010 21:09:10 +0000
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 3E37A13D389; Tue,  2 Feb 2010 21:09:10 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <4B67E183.3010800@viscovery.net> (Johannes Sixt's message of
	"Tue, 02 Feb 2010 09:25:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.90 (usg-unix-v)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138756>

Johannes Sixt <j.sixt@viscovery.net> writes:

>Pat Thoyts schrieb:
>> This patch enables the use of themed Tk widgets with Tk 8.5 and above.
>
>With this patch, the sizes of the file lists are not restored correctly
>anymore. The upper list (unstage files) always appears in the "native"
>size. A fix for this would be appreciated.
>
The ttk::panedwindow has different sash handling to the non themed
version. I'll try and get onto this soon.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD

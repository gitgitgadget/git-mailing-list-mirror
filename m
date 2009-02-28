From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] gitk: make use of themed widgets where available
Date: 28 Feb 2009 09:24:40 +0000
Message-ID: <87ab86ewx3.fsf@users.sourceforge.net>
References: <87ljrre7nr.fsf@users.sourceforge.net>
	<18856.42302.321781.759870@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Feb 28 10:27:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdLTT-0004V1-KE
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 10:27:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225AbZB1JYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 04:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752962AbZB1JYq
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 04:24:46 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:39012 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752273AbZB1JYp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Feb 2009 04:24:45 -0500
Received: from [172.23.170.139] (helo=anti-virus01-10)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1LdLR4-0006ck-JW; Sat, 28 Feb 2009 09:24:42 +0000
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out2.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1LdLR4-0002ZL-0A; Sat, 28 Feb 2009 09:24:42 +0000
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 6386951836; Sat, 28 Feb 2009 09:24:41 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <18856.42302.321781.759870@cargo.ozlabs.ibm.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111763>

Paul Mackerras <paulus@samba.org> writes:

>Pat Thoyts writes:
>
>>     This patch improves the appearence of gitk on Windows XP and Vista
>>     by making use of the themed widgets that are provided in Tk 8.5
>>     and above. For good Vista support 8.6 will be needed.
>
>Wow.  It'll take me a while to digest this.  Before I start diving
>into it, does gitk still work on Tk 8.4 with this patch?
>
>Paul.

Yes. It uses the variable 'use_ttk' to turn on the use of the themed
widgets and if this is unavailable (or an option could be provided to
turn it off explicitly) then only standard Tk widgets are used.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD

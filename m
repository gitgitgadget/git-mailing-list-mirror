From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 1/2] Work around leftover temporary save file.
Date: 15 Sep 2009 16:44:18 +0100
Message-ID: <87pr9sb4bx.fsf@users.sourceforge.net>
References: <1252437756-81986-1-git-send-email-snaury@gmail.com>
	<87ab0wcsyp.fsf@users.sourceforge.net>
	<81b0412b0909150601j74d40181pc2308f4f63b4817e@mail.gmail.com>
	<e2480c70909150714n3b7d6018rcb5bcb42d1d78218@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Alexey Borzenkov <snaury@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 17:44:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnaCv-00069T-UA
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 17:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbZIOPob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 11:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbZIOPoa
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 11:44:30 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:46199 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750911AbZIOPo3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2009 11:44:29 -0400
X-Greylist: delayed 13246 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Sep 2009 11:44:29 EDT
Received: from [172.23.170.146] (helo=anti-virus03-09)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1MnaCc-0006Bp-Ka; Tue, 15 Sep 2009 16:44:22 +0100
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out4.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1MnaCb-0003d7-En; Tue, 15 Sep 2009 16:44:22 +0100
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 72A9B51843; Tue, 15 Sep 2009 16:44:19 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <e2480c70909150714n3b7d6018rcb5bcb42d1d78218@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128573>

Alexey Borzenkov <snaury@gmail.com> writes:

>
>Then deleting would fail, because on Windows opened files cannot be
>deleted (unless they are opened in a special way that permits it).
>

The delete occurs before we attempt to open the file which is why it
succeeds when such file is present.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD

From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] gitk: Handle msysGit version during version   comparisons
Date: 19 May 2009 11:38:08 +0100
Message-ID: <877i0ds7hr.fsf@users.sourceforge.net>
References: <87hbzirso6.fsf@users.sourceforge.net>
	<alpine.DEB.1.00.0905191043320.26154@pacific.mpi-cbg.de>
	<4A127306.6040904@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 19 12:38:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6MiI-0004dV-Ho
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 12:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbZESKiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 06:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753250AbZESKiQ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 06:38:16 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:34240 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751382AbZESKiP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2009 06:38:15 -0400
Received: from [172.23.170.146] (helo=anti-virus03-09)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1M6Mi5-0002AJ-Sg; Tue, 19 May 2009 11:38:14 +0100
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out5.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1M6Mi3-0007WI-Ib; Tue, 19 May 2009 11:38:11 +0100
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 99F575183F; Tue, 19 May 2009 11:38:10 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <4A127306.6040904@drmicha.warpmail.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119514>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>Johannes Schindelin venit, vidit, dixit 19.05.2009 10:43:
>> Hi,
>> 
>> On Mon, 18 May 2009, Pat Thoyts wrote:
>> 
>>>
>>>   msysGit generates version strings with text appended which cannot
>>>   be used with vcompare. Limit git_version to the first three digits
>>>   which are the real git version.
>>>
>>> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
>> 
>> Is that indent intentional?
>> 
>> Ciao,
>> Dscho
>
>It is clearly indentional :)
>
>[During my git beginnings, the standard output format of git log made me
>believe I should format commit message bodies like that, too.]

It was intentional and the above followup is why. Evidently I should
not do so in the future.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD

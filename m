From: Arup Rakshit <aruprakshit@rocketmail.com>
Subject: Re: git pull not ignoring the file which has been sent to the temporary ignore list
Date: Sat, 24 Jan 2015 10:20:46 +0630
Organization: CognitiveClouds
Message-ID: <1557175.bcUxN10iZq@linux-wzza.site>
References: <3278910.5D06XWKxyS@linux-wzza.site> <CAGZ79kbk=DFcMSVtnWHw7Vn-xm4q4x5T_9qiPrqt5oN1DMhFSw@mail.gmail.com> <xmqq8ugtqjxg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 24 05:52:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEsi6-0007hG-7J
	for gcvg-git-2@plane.gmane.org; Sat, 24 Jan 2015 05:52:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311AbbAXEwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 23:52:30 -0500
Received: from nm10-vm4.bullet.mail.sg3.yahoo.com ([106.10.148.227]:57374 "EHLO
	nm10-vm4.bullet.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751663AbbAXEw2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jan 2015 23:52:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1422075146; bh=RHAK2+AHjIzh1gAUbjrTnysqZ6597xk8XQ8AY9cFDwQ=; h=From:To:Subject:Date:In-Reply-To:References:From:Subject; b=aQgtv7lGIL6Z1aKcpNLXuhjgPONXh+loDwnYkwLyI30BMRAklKkL+z3LtigMUOHe9GzXpbqRizusKzmKxDmgX+95zKM2AmulySCriijp59yQnQqxfW5SI/VoU/tcNyn4jZp2dAri10BRROmy7zE1CibxXV04uakqVdO8g2tzdzAFukLG+GFqbR4JLg0Nlya65QP3usKI/wWy+Yl5Kkg2Mar95VHtrILt11pUreWc+UnqvMUbBFsfVtXz44M39tLA6irJCsP9VL59LGy0HfPOFddDOMKfDuamDX4b6t2J4LLVmXdpNAZXc6swtrj4rHPNsj8xeIkIdJXrVJOTxxdpMw==
Received: from [106.10.166.60] by nm10.bullet.mail.sg3.yahoo.com with NNFMP; 24 Jan 2015 04:52:26 -0000
Received: from [106.10.167.143] by tm17.bullet.mail.sg3.yahoo.com with NNFMP; 24 Jan 2015 04:52:26 -0000
Received: from [127.0.0.1] by smtp116.mail.sg3.yahoo.com with NNFMP; 24 Jan 2015 04:52:26 -0000
X-Yahoo-Newman-Id: 572127.9559.bm@smtp116.mail.sg3.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: HOwT__EVM1lSuXBzyyY0MvWcGhDcNtGbYgLVJjJisUL0TL.
 eMzN85oT25LvkYr1Ip_r8crNHaasGY3hTGX0hWy3K9oAd.IJGPxnYJ84W6pZ
 PdU8cI_jOrBfiy2Y.2kVQG9spCpqszLHLy80YlR40Z3QXz5EdtXLzBBOFOwM
 YzSedTfvtWbqmZsqJKnXlU3LraBpFNKSzHcFJRJriBXLiHM0IJMRO0lnbrhr
 A6CViLiOLoraL4_tyhHbhxsJ5IoO5TSvDzJAgQNCxCIXXFL3bzCeraR2N6HZ
 VPeoUMMzN.P1D8CnX5QqyVM1IUmr4M5gKD33AQgrG7TxKneyJnFEbfshVesq
 h247kCd1uaO1aoXfBMavpTBzLq9QxmOdwgNs6z1rt3g.nn.NUmtjxixQ5WOp
 k.HJZWRd7GPsT5Ti0ujUSpr_neMjFpEgURXEcPUW7.dYbx5BDrl.se.T5Kcs
 h1X9MFiCxrsB66dRS.X6Ij8K0Pbl5rhnbrgzWd5AtvX1X1BUMlZvjFf6oJJA
 aJ1qU.SfQNnjPLesYRkD73knWVRoq8kH8XqKcP5Bz8CwQDZBg_A.RQKWAJB9
 0akzHUbQvDBPhaV6CM2KkHpv2SlCd5QXC5SHBCka2XLY80XlR6lCKaCDijcw
 GHt5REgXbaMb8AiZz.pkMF2bGAJPyMhyCgeCe6u.GNaX4urgTEuI0GkKpD16
 pOXfNKWqTapsnV4SipNRkecUTqXswArLm9hy1QEWqwKsVcoSobllfB3p79ly
 9oZ_y1rMy1pqQHwdF0QWnplHfk_3Hp8s-
X-Yahoo-SMTP: _NAuC72swBDpdridK5c7mltfXc1K.nFhPY5jXEZ4Gfdya8Gn_0nN
User-Agent: KMail/4.11.5 (Linux/3.11.10-25-default; KDE/4.11.5; i686; ; )
In-Reply-To: <xmqq8ugtqjxg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262989>

On Friday, January 23, 2015 01:14:03 PM you wrote:
> Stefan Beller <sbeller@google.com> writes:
> 
> >> Ok. How should I then ignore any local changes to the .gitignore
> >> file ? And while taking pull, git should skip this file ?
> >
> > Look at .git/info/exclude
> 
> Good answer for ".gitignore".  In general, you do not "ignore local
> changes" to tracked paths.

There are some configuration files, like `database.yml`, where we generally put our local DB credentials and we don't want to share such things. That's why we always put related settings inside the .gitignore file. But  while I will change it, git will not track the changes of the file, but .gitignore. That's why I used the first thread command. But when the time the came to take a `git pull`, I got to know about the mess. What should be the ideal decision in this case ?

> > I found https://help.github.com/articles/ignoring-files/ as Googles
> > first hit, which advises to use
> >     git update-index --assume-unchanged path/to/file.txt
> > Not sure if that is most helpful advice there.

Yes, I followed the same.

> The piece of advice in the last paragraph on that page is wrong (and
> it has been wrong from the day it was written).
> 
> The gitignore(5) documentation used to have a similar incorrect
> piece of advice but we finally corrected it recently.
> 
> Cf. http://thread.gmane.org/gmane.comp.version-control.git/260954/focus=261118

-- 
================
Regards,
Arup Rakshit
================
Debugging is twice as hard as writing the code in the first place. Therefore, if you write the code as cleverly as possible, you are, by definition, not smart enough to debug it.

--Brian Kernighan

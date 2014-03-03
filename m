From: "saikrishna.sripada" <saikrishna.sripada@students.iiit.ac.in>
Subject: Help needed: Tests failed While replacing char array with strbuf in
 bulk-checkin.c
Date: Tue, 04 Mar 2014 02:41:14 +0530
Message-ID: <d7af2c2bcb07168ecddedf76ca776cd0@students.iiit.ac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 22:18:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKaG2-0008L4-Im
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 22:18:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676AbaCCVSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 16:18:39 -0500
Received: from students.iiit.ac.in ([196.12.53.7]:47920 "EHLO
	students.iiit.ac.in" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590AbaCCVSh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 16:18:37 -0500
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Mar 2014 16:18:37 EST
Received: from students.iiit.ac.in (students.iiit.ac.in [127.0.0.1])
	(Authenticated sender: saikrishna.sripada)
	by students.iiit.ac.in (Postfix) with ESMTPA id 565222E15CC
	for <git@vger.kernel.org>; Tue,  4 Mar 2014 02:41:14 +0530 (IST)
X-Sender: saikrishna.sripada@students.iiit.ac.in (9AbpNPKdPIeK1BwmxthxIJ5kjCuSezCD7iruBckelAdXex+5o721dRCafbtXEmvYVdi2eYroY61MMR4QaRaJs7KzYA9qYe7hZRWinuM9VaomhC/jP64S56ufHWdj+ydol5noG87IcNgbK7ctjhevzoxeBWF7Y7ypf/hSKcJUVZNIEf57nkfBC3g2BqsA5ANw7nvkPAb66aQyjva6O8TOgWjsJEiMGjEbWT3K51S4+FP8fcCNkBefgjDPzrTQRr7j909JWuVLJW3x8Wbtf5ndUDch52bd5N6ZTsx+zZc0LDSsbOa7bxBaM544pjLWIMYv2PN+Q3FXX9DNVn5dXH1iJFNo4upwBtKoEtWnHDf09iTp/tWbDELZwbzdcFW1rzL/2NNfl/D7n4NtD+Zuqh53OHngMn/I5o+rTcLXJlM0MPFlNDhKLzMadKCw3+LEm6VnWfCbBKBbHsyctwxjXD6+BF2X5ORMJMRVPp7Ad8zWQ/IPfH09bajDCQ1CCD41+v5T7T5NimraVMMnWB3eVLKtLQhHubV6UyP+EMbBr1scWd0OL7kddNZcBTvVKO3926M3qZ0Rv+OhwavcJK+Fzb+aK1piv2RFdOk10PBBapePKopgVeH773hz3jKk9MeyJwBXgcLWZf3Aq8/LOjFZ5aaHwYtiG1hwXB3X0QCMC+QCMoL/Go/lNN8OQeRgrX1qYX+HYrXhYLnf3O+fiFbxQEaz4VEjk2PPyQe2p6YZvshFYI5eKv
 aohvHEDvVYP7NX/AFK2aE484dO+CUylOOQLhtulEtQdcbTNVwEWx8YfXZHo7ngVymfmyjWGCnj+7xQazKuVcLSrDts1weojsGP 
User-Agent: RoundCube WebMail
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243272>

Hi ,
I am trying do complete the microproject 4, inorder to apply to GSOC.
I have made the below changes:

https://gist.github.com/anhsirksai/9334565

Post my changes compilation is succes in the source directory.
But when I ran the tests[make in t/ directory] my tests are failing 
saying

"
  free(): invalid pointer: 0x3630376532353636 ***
======= Backtrace: =========
/lib/x86_64-linux-gnu/libc.so.6(+0x7eb96)[0x2b5f3b540b96]
/home/saikrishna/Desktop/libcloud-0.14.1/sai/git/git[0x4fb829]
/home/saikrishna/Desktop/libcloud-0.14.1/sai/git/git[0x47d425]
/home/saikrishna/Desktop/libcloud-0.14.1/sai/git/git[0x4064ad]
/home/saikrishna/Desktop/libcloud-0.14.1/sai/git/git[0x405a04]
/home/saikrishna/Desktop/libcloud-0.14.1/sai/git/git[0x404cbd]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xed)[0x2b5f3b4e376d]
/home/saikrishna/Desktop/libcloud-0.14.1/sai/git/git[0x405109]
"

Can some one please help me with the memory allacation and 
strbuf_release()

Thanks,
--sai krishna

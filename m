From: Jeroen Michiel <jmichiel@yahoo.com>
Subject: Repository corrupt after push
Date: Tue, 9 Feb 2010 02:21:00 -0800 (PST)
Message-ID: <306369.29911.qm@web65510.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 11:21:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NenDy-0007ma-0u
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 11:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410Ab0BIKVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 05:21:31 -0500
Received: from n3b.bullet.mail.ac4.yahoo.com ([76.13.13.73]:29382 "HELO
	n3b.bullet.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751604Ab0BIKVa convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 9 Feb 2010 05:21:30 -0500
Received: from [76.13.13.26] by n3.bullet.mail.ac4.yahoo.com with NNFMP; 09 Feb 2010 10:21:00 -0000
Received: from [76.13.10.181] by t3.bullet.mail.ac4.yahoo.com with NNFMP; 09 Feb 2010 10:21:00 -0000
Received: from [127.0.0.1] by omp122.mail.ac4.yahoo.com with NNFMP; 09 Feb 2010 10:21:00 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 551785.70234.bm@omp122.mail.ac4.yahoo.com
Received: (qmail 30482 invoked by uid 60001); 9 Feb 2010 10:21:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1265710860; bh=p8WPWif1LwagAzmHrxKI+QIycXPuXRZGBLxriZyi21M=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=hbpMTDW34SnI5CB5eQd9otu4jX2AzBdNwkUs17cydE6l3u5ygw7WWuGqdqOD3FCBz1cyKZ8S6yDyeC4yDCRGWaavVkMgdFuDBTRk8aG3DPS47mrJ9IA4Ucj0j47OUBVnr7Elmyf8MKUBG9/ausx6k2GXgknRDVhLZ74y+XbuYcs=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=lPg45rMUaT2efnXwPMwfNzAEs0YZ6Z8zzUgjGMkUA8i4qyx+3YboZwI2ymnzTICzzkyTGlciXSLqj5u75fzKQZi+qfZMjoCgnwF3+6MDpcAWZ2dQ7723CvjIGHePkEc5/CN+5+qG0JPs05ydHpHW23rpjhdSFtcsvvigFlVQ/5c=;
X-YMail-OSG: qnmXbOEVM1k.1Ul.ZlRpa2UQg7nb0PaxKyWw5rD9SXcLNyG3WYq7Wog5qz5L0x70byeovG4L9wYwji47Fvd3k5Pi0vQclmyfPgjLUizTtlqWpF4GvQU.Urp6SKnsVpj1I9zLx1W53CAW4uEmWqqdksgp2YR0ZNHxthV3FDsrXjqbYoMv9piEcuTmo.ER9_7SkfI_ZNx.xE2o822l8kTkTt2pM1DmpGVNzZF0PhIgQLtzX0OsPelBJDxthKvvjt442nvlwIKSZCu.fRYyGxOJKMjWDsmD.HKQW8Jgn5ynZHJqgPImu9Y_Cb8Wkg--
Received: from [194.78.31.114] by web65510.mail.ac4.yahoo.com via HTTP; Tue, 09 Feb 2010 02:21:00 PST
X-Mailer: YahooMailRC/272.8 YahooMailWebService/0.8.100.260964
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139381>

Hi,

I'm trying to run a git server on my synology Diskstation DS108j with gitosis.
I can clone the gitosis-admin.git reposotory, but if I edit the gitosis.conf file, commit and then try to push to the server, the repository on the server ends up being corrupt. My client PC is running Windows (tried on XP and 7) git Git Extensions. I tried with Git Extensions, Git GUI and Git Bash, but it all ends up being corrupt.
What can be causing this?

Any hints and help appreciated!
Jeroen


      

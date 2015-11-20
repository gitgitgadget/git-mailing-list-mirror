From: Arup Rakshit <aruprakshit@rocketmail.com>
Subject: I can't pull/fetch from origin, but can push my story branch
Date: Fri, 20 Nov 2015 14:48:16 +0000 (UTC)
Message-ID: <202625969.6769734.1448030896264.JavaMail.yahoo@mail.yahoo.com>
References: <202625969.6769734.1448030896264.JavaMail.yahoo.ref@mail.yahoo.com>
Reply-To: Arup Rakshit <aruprakshit@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 20 15:57:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zzn70-0000Q6-Ud
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 15:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162995AbbKTO4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 09:56:19 -0500
Received: from nm41-vm3.bullet.mail.ne1.yahoo.com ([98.138.120.219]:45966 "EHLO
	nm41-vm3.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751385AbbKTO4Q (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Nov 2015 09:56:16 -0500
X-Greylist: delayed 311 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Nov 2015 09:56:16 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1448031064; bh=YDiKrv0+B/me2YvntQ1bLWduo/BlkOtXWbblDwmpdG0=; h=Date:From:Reply-To:To:Subject:References:From:Subject; b=hZgAqc0FJ1GY3Wd1hrtlr0ihEaIuEe8ZqeHDaJMInzpP1CeOEREHIHD0MbCc+QB03egre5RFSK7cuvaoAv47yRIb1LpRqtchZBTRWe+WdkTR6Amfy5DM/Bx0CspGGk0ckNgv3L1dmRmBXEi6bjVV8d0QkvySm6QMebT1fZwq89zRsv6xK7lxQRu/89qhUF5pBzmaIl2zhhLEd0YWzTMOLs9TdM7n4xaBXPgqr3jkijov6l6iYDLXi/WRpYLUq0mjQl/RKYkhBzYBkXimD5e9IPgzYJZjRuvGNe4n9vmTRvktSeuR6yYB/gOmxcy3hGrZxZwIs6K35rjAoWiujzpCUg==
Received: from [127.0.0.1] by nm41.bullet.mail.ne1.yahoo.com with NNFMP; 20 Nov 2015 14:51:04 -0000
Received: from [98.138.226.178] by nm41.bullet.mail.ne1.yahoo.com with NNFMP; 20 Nov 2015 14:48:17 -0000
Received: from [106.10.166.124] by tm13.bullet.mail.ne1.yahoo.com with NNFMP; 20 Nov 2015 14:48:17 -0000
Received: from [106.10.150.25] by tm13.bullet.mail.sg3.yahoo.com with NNFMP; 20 Nov 2015 14:48:16 -0000
Received: from [127.0.0.1] by omp1026.mail.sg3.yahoo.com with NNFMP; 20 Nov 2015 14:48:16 -0000
X-Yahoo-Newman-Property: ymail-4
X-Yahoo-Newman-Id: 968633.29567.bm@omp1026.mail.sg3.yahoo.com
X-YMail-OSG: 6k6rDXEVM1n2410uee7yL2F_wHYHd0CDfSS58zgRENa1ovBt4EynAh3nhRRrYWf
 mLmRgwBHR65wh8yidVMNb2Kj8.qaf1op7D6s7h6b8A4iTcqdzINh4Gu3MZ5NmDD.MKKl_1dx2kji
 WomLL6ARAonzfJxaavMZXvYkq0dAAqCg81Uho9JsfPk3Rm8wnVrmPOPCTLas8zjJfVJ.D7SGvV3e
 JIbMy4E0RtdIRQtK9j6ZKb8O_QN0PjEqTzIOOJiMyjs4f6PZs24fdv7FOwbyH_C_6rVjYHGk1Hwl
 RwlMldlOOiSPDXnbA0R1p0kyiCe94j716sWRJ91cErbbIbmSPJDbBgqENIsQmF7TnNDfKfXNfy48
 f5GR_EBS3A0.cJZKsV9xc8iD1H2bxGq8SqvqaV7J.ogp2GRVipMLag6PAiimf1ihCGz5oj1hgsqc
 NPWesoH7htCxKfoL3JHMzjF0oE9wpCYUWQffWu1N0C6EwdIZIibEVgDi.j8efDPN0T8c.CF_ZgN4
 5apA1Kfvn1.zwCny5GUV_9MCUuIWk6y.0ARbeoJc-
Received: by 106.10.197.98; Fri, 20 Nov 2015 14:48:16 +0000 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281524>

Hi,

I forked a repo and then working on features using feature branch. Once done, I am pushing my branch and creating PR. This all was working till night. Suddenly this morning, I am not able to fetch/pull, but can push my feature. The below is what I am getting:

[arup@critique (master)]$ git fetch origin
[arup@critique (master)]$
[arup@critique (master)]$ git pull origin master
ssh: Could not resolve hostname ssh.github.com: Name or service not known
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
[arup@critique (master)]$
[arup@critique (master)]$ git remote -v
origin  git@github.com:aruprakshit/critique.git (fetch)
origin  git@github.com:aruprakshit/critique.git (push)
upstream        git@github.com:DFTi/critique.git (fetch)
upstream        git@github.com:DFTi/critique.git (push)
[arup@critique (master)]$

Any idea what configuration got change over night ? I have no idea how to fix it? Please help me.
 Regards,
Arup Rakshit

From: Martin Lichtin <lichtin@yahoo.com>
Subject: Git does not understand absolute Win'dos' path
Date: Wed, 14 Nov 2012 01:12:09 -0800 (PST)
Message-ID: <1352884329.28981.YahooMailNeo@web162504.mail.bf1.yahoo.com>
Reply-To: Martin Lichtin <lichtin@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 14 10:12:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYZ1J-0003Bj-1c
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 10:12:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144Ab2KNJMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 04:12:13 -0500
Received: from nm30-vm0.bullet.mail.bf1.yahoo.com ([98.139.213.126]:23184 "EHLO
	nm30-vm0.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753514Ab2KNJML (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Nov 2012 04:12:11 -0500
Received: from [98.139.215.142] by nm30.bullet.mail.bf1.yahoo.com with NNFMP; 14 Nov 2012 09:12:10 -0000
Received: from [98.139.212.221] by tm13.bullet.mail.bf1.yahoo.com with NNFMP; 14 Nov 2012 09:12:10 -0000
Received: from [127.0.0.1] by omp1030.mail.bf1.yahoo.com with NNFMP; 14 Nov 2012 09:12:10 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 59827.53482.bm@omp1030.mail.bf1.yahoo.com
Received: (qmail 52092 invoked by uid 60001); 14 Nov 2012 09:12:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1352884329; bh=sDW6+I7zSKXu5vJ+lr+oFD2xYQwPrbOSxLF4HXcybSU=; h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type; b=rHMgV5abGLLsj5c1lXN5li2w4sVTpkeGSfEQmCn5Xilq6PChwKC5QeLcV/tiAxWkHcqS4OYj0lZB2i6hAJZkK8DYys7Clo6s6JzUBxDjlUzSkWS/VrjGtIQVPnIsUnEYO5c/Y4oQCd2ImGnz1lQ7VGuy/LWRpIRB0qydPVKDgTA=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type;
  b=S1D6dCmA+kPQC2CZDXiXuGTndUHpvJjWSPgnxM4UE2Az2cYfIJ0dH5xenmJHwDBZcOWw94CF+AwBJQQUzSA1MGhl2EssI3Po16/dnuSJJ+DJFx+lTVAN+YCx1IJq6Sz+hZ1sOYU6EdfiUYDhLCywaAwYKfGskfuMD2vtVePJkb8=;
X-YMail-OSG: 2bSN1h4VM1nxxz8wX91zKqIRSAxjMdjbSOUeDb2jw2Os4YU
 KyF6YK9jYM2DiFfBmcJSdThevw_vs8eNabyJ05kB4AAiIH_uOqfvijWpvggi
 xVzCTjIIWpj4cXkFdG4.BG8SyinxhqQQnYqGQITjtrX2WkQiSRkEAUYByv3R
 30c2B6_scXlA29ynjLIaaOyTxJOngamzXNVyFMBQSgbubYKC6AMBQWty7R2N
 ioU1ldlKkFUYUPkwvbwMtTZc7hE6S9Bs8yM1lRZ02pT3MmKhO7KsQqVO1IEd
 jcYT1sT4qhoFWbmeQpv4s_PePi.1QJYLZcqRSsDcfM9dqHurc5e9tp.wZ1Fk
 UUlBT217AZEHkMaKsaN_kASaebWOfc58PhMvnK9.6nXg.2Bbpccg2ui9qRxf
 FZ0z5qApGmT_IRywh9WTJgzggZSoGf1tAGFlakMJSgdDP6AQetP26Mb_WFy7
 OlsBFy68VyRjm3KaRaFX0XxgQ46aX0eOd1I_N3tC4
Received: from [193.73.134.253] by web162504.mail.bf1.yahoo.com via HTTP; Wed, 14 Nov 2012 01:12:09 PST
X-Rocket-MIMEInfo: 001.001,SGkKCk1hdmVuJ3MgcmVsZWFzZSBwbHVnaW4gcHJlcGFyZXMgYSBjYWxsIEdpdCBsaWtlIGluIHRoaXMgZXhhbXBsZToKCmNtZC5leGUgL1ggL0MgImdpdCBjb21taXQgLS12ZXJib3NlIC1GIEM6XGN5Z3dpblx0bXBcbWF2ZW4tc2NtLTkxNTc3MTAyMC5jb21taXQgcG9tLnhtbCIKCkdpdCBkb2Vzbid0IHNlZW0gdG8gdW5kZXJzdGFuZCB0aGUgLUYgYXJndW1lbnQgYW5kIHRyZWF0cyBpdCBsaWtlIGEgcmVsYXRpdmUgcGF0aCAocmVsYXRpdmUgdG8gdGhlIHJlcG9zaXRvcnkgcm9vdCk6CgokIGNtZC5leGUgL1gBMAEBAQE-
X-Mailer: YahooMailWebService/0.8.123.460
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209705>

Hi

Maven's release plugin prepares a call Git like in this example:

cmd.exe /X /C "git commit --verbose -F C:\cygwin\tmp\maven-scm-915771020.commit pom.xml"

Git doesn't seem to understand the -F argument and treats it like a relative path (relative to the repository root):

$ cmd.exe /X /C "git commit --verbose -F C:\cygwin\tmp\commit pom.xml"
fatal: could not read log file 'mytestdir/C:\cygwin\tmp\commit': No such file or directory

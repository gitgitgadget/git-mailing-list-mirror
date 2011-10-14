From: T <blackswanmabak@yahoo.com>
Subject: fatal: Not a git repository
Date: Thu, 13 Oct 2011 18:57:23 -0700 (PDT)
Message-ID: <1318557443.92591.YahooMailNeo@web114209.mail.gq1.yahoo.com>
Reply-To: T <blackswanmabak@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 14 03:57:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REX1m-00005A-ST
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 03:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755641Ab1JNB5Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Oct 2011 21:57:25 -0400
Received: from nm18.bullet.mail.sp2.yahoo.com ([98.139.91.88]:27752 "HELO
	nm18.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754940Ab1JNB5Y convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 21:57:24 -0400
Received: from [98.139.91.63] by nm18.bullet.mail.sp2.yahoo.com with NNFMP; 14 Oct 2011 01:57:24 -0000
Received: from [98.139.91.56] by tm3.bullet.mail.sp2.yahoo.com with NNFMP; 14 Oct 2011 01:57:24 -0000
Received: from [127.0.0.1] by omp1056.mail.sp2.yahoo.com with NNFMP; 14 Oct 2011 01:57:24 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 347881.33948.bm@omp1056.mail.sp2.yahoo.com
Received: (qmail 92606 invoked by uid 60001); 14 Oct 2011 01:57:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1318557443; bh=Z1tdKVZID/mwv6nYeMqvE+Ipk+TYthZvpRbJbc4bxmY=; h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=EpShW5h8KtzGyLTmtxAMK4tJvSRUCMKYkwYZ7qqkRDLTGdzNoGc0Hv1y+loTjMMalLyNwY9epDqtCZagu4I/xjj4LtSfPEveAit1DJQzlm2hHUfAPNVdhMtjCc11SyDE51Izthbt5i+85h+lB7hqgRFnfr9fwNAen23m1f9f6s8=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=snlCaW1yYiIXHo2dJCMFmvr2ODhRZVtasNwEXVwS/n/RHcdjjJUp4g3QBTpRqll7cKs5Lz0gpXDd6hG51waOzW2Mkf7MC/Z4c5DNrBoj/Kp7IxNY4Z5glg4OHKaAdkCOvGltmlQGwTHBmXRg0BaOFF4bpTo9HVsoWBmHIttGWB0=;
X-YMail-OSG: Xcx_HfsVM1lHsEOgqqtglNWNV0SkibThgoFqu0.jEf0qBwW
 80H16eVnkICRzDVxC4JURxNEmeMU3oZ5UDbPA_XhFtipIKwg3Bxo.4cfMawK
 WxG2BxzlNSAar8lnC3HhHCxN45CmuC6S9bsaJR45_w73iCMHp5yOTF1i7MDG
 QJ1nDbnoFLbWMSrCRh2oj9GOhoBbjLJk_z1xfWwINeTB7soEAMFkBiAV1YbS
 T.N9l1SscjQXRkb2eU7_wbZcpUPTlFF.Uo_sEtztPU_mnNp4dS00rEQIt7Bt
 4Ua2pVAn7lhmlT.8b3Ksx0ZtNd1QcILuZ8oobrE8sVRkgS3oQPcp6QLd2qt4
 mQx8j.XPDVlWnRYwFHB4js1S4NwIs9_EgptOllnhKkwgNsw--
Received: from [68.251.44.54] by web114209.mail.gq1.yahoo.com via HTTP; Thu, 13 Oct 2011 18:57:23 PDT
X-Mailer: YahooMailWebService/0.8.114.317681
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183533>

I am on RedHat Linux Server 5.7, installed git and all worked great.

Performed a "git add ." and sat back and watched it chew up GB fo data =
and create the .git repository, which I was going to study.=A0 But then=
 I decided to delete the .git repository before the commit, and redo th=
e work after I added additional files to the filesystem.

The git application no longer works.=A0 I have done a complete deletion=
 of all files that I know of and a complete reinstallation and yet ever=
y time that I attempt to get git to reread the directory and recreate t=
he repository or ANY repository on the system even while root the error=
 message is:



[root@localhost wizdom]# git add .
fatal: Not a git repository (or any of the parent directories): .git




Any idea on how to fix this problem so that I can get on with using git=
?

Wizdom is a dir of management information systems related files, 29.4GB=
 in size, containing 264380 files, for systems administration and when =
git had complete the add command it had create a dir /home/Object/wizdo=
n/.git that was 26.1GB in size and with 212774 files in 256 sub-folders=
=2E


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[root@localhost ~]# mkdir /tmp/git_source
[root@localhost ~]# cp /home/Object/Desktop/100511/git/git-1.7.7.tar.gz=
 /tmp/git_source/.
[root@localhost ~]# openssl dgst -sha1 /tmp/git_source/git-1.7.7.tar.gz
SHA1(/tmp/git_source/git-1.7.7.tar.gz)=3D bbf85bd767ca6b7e9caa1489bb4ba=
7ec64e0ab35
[root@localhost ~]# cd /tmp/git_source/
[root@localhost git_source]# tar -xzf git-1.7.7.tar.gz
[root@localhost git_source]# ls
git-1.7.7=A0 git-1.7.7.tar.gz
[root@localhost git_source]# ./configure
[root@localhost git-1.7.7]# make
[root@localhost git-1.7.7]# make install
[root@localhost git-1.7.7]# updatedb
[root@localhost git-1.7.7]# which git
/usr/local/bin/git
[root@localhost ~]# ls -al /usr/local/bin/gi*
-rwxr-xr-x 109 root root 5113079 Oct 13 13:14 /usr/local/bin/git
-rwxr-xr-x=A0=A0 2 root root=A0 120939 Oct 13 13:14 /usr/local/bin/git-=
cvsserver
-rwxr-xr-x=A0=A0 1 root root=A0 324172 Oct 13 13:14 /usr/local/bin/gitk
-rwxr-xr-x 109 root root 5113079 Oct 13 13:14 /usr/local/bin/git-receiv=
e-pack
-rwxr-xr-x=A0=A0 2 root root 2144914 Oct 13 13:14 /usr/local/bin/git-sh=
ell
-rwxr-xr-x 109 root root 5113079 Oct 13 13:14 /usr/local/bin/git-upload=
-archive
-rwxr-xr-x=A0=A0 2 root root 2195752 Oct 13 13:14 /usr/local/bin/git-up=
load-pack



Just to see what it would do, or what it does, I ran git against my sys=
tems administration collection called wizdom on a Dell T-410 with one s=
ocket in use.


[root@localhost git-1.7.7]# git --version
git version 1.7.7
[root@localhost wizdom]# git init
Initialized empty Git repository in /home/Object/Desktop/wizdom/.git/
[root@localhost wizdom]# git add .
[root@localhost wizdom]#



And in another window while "git add ." ran, I execute the top command =
to see what the processor had to say:

[root@localhost ~]# top
top - 16:12:43 up 1 day, 21:19,=A0 4 users,=A0 load average: 1.35, 0.73=
, 0.32
Tasks: 232 total,=A0=A0 2 running, 230 sleeping,=A0=A0 0 stopped,=A0=A0=
 0 zombie
Cpu0=A0 :=A0 0.0%us,=A0 0.0%sy,=A0 0.0%ni,100.0%id,=A0 0.0%wa,=A0 0.0%h=
i,=A0 0.0%si,=A0 0.0%st
Cpu1=A0 :=A0 0.0%us,=A0 0.0%sy,=A0 0.0%ni,100.0%id,=A0 0.0%wa,=A0 0.0%h=
i,=A0 0.0%si,=A0 0.0%st
Cpu2=A0 :=A0 0.7%us,=A0 0.0%sy,=A0 0.0%ni, 99.3%id,=A0 0.0%wa,=A0 0.0%h=
i,=A0 0.0%si,=A0 0.0%st
Cpu3=A0 :=A0 0.0%us,=A0 2.0%sy,=A0 0.0%ni, 46.7%id, 50.7%wa,=A0 0.3%hi,=
=A0 0.3%si,=A0 0.0%st
Cpu4=A0 :=A0 0.0%us,=A0 1.0%sy,=A0 0.0%ni, 99.0%id,=A0 0.0%wa,=A0 0.0%h=
i,=A0 0.0%si,=A0 0.0%st
Cpu5=A0 :=A0 0.0%us,=A0 0.0%sy,=A0 0.0%ni,100.0%id,=A0 0.0%wa,=A0 0.0%h=
i,=A0 0.0%si,=A0 0.0%st
Cpu6=A0 :=A0 0.0%us,=A0 0.0%sy,=A0 0.0%ni,100.0%id,=A0 0.0%wa,=A0 0.0%h=
i,=A0 0.0%si,=A0 0.0%st
Cpu7=A0 : 93.7%us,=A0 2.7%sy,=A0 0.0%ni,=A0 3.3%id,=A0 0.3%wa,=A0 0.0%h=
i,=A0 0.0%si,=A0 0.0%st
Mem:=A0=A0 5968036k total,=A0 5932372k used,=A0=A0=A0 35664k free,=A0=A0=
 191688k buffers
Swap:=A0 8159224k total,=A0=A0=A0=A0=A0=A0=A0 0k used,=A0 8159224k free=
,=A0 4938104k cached

=A0 PID USER=A0=A0=A0=A0=A0 PR=A0 NI=A0 VIRT=A0 RES=A0 SHR S %CPU %MEM=A0=
=A0=A0 TIME+=A0 COMMAND
16250 root=A0=A0=A0=A0=A0 25=A0=A0 0 17344 1428=A0 792 D 96.2=A0 0.0=A0=
=A0 1:09.41 git-fast-import
16233 root=A0=A0=A0=A0=A0 18=A0=A0 0 44348=A0 29m 1036 S=A0 1.3=A0 0.5=A0=
=A0 0:53.89 git
=2E..



Thanks!

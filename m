From: Olivier LE ROY <olivier_le_roy@yahoo.com>
Subject: Re: Handling empty directories in Git
Date: Tue, 8 Apr 2014 10:47:29 -0700 (PDT)
Message-ID: <1396979249.39960.YahooMailNeo@web120805.mail.ne1.yahoo.com>
References: <1396968442.95061.YahooMailNeo@web120806.mail.ne1.yahoo.com> <3FBDE5D3-1DC6-420C-866B-036D0CB17BA2@kellerfarm.com>
Reply-To: Olivier LE ROY <olivier_le_roy@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 19:48:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXa81-000513-Eh
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 19:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756982AbaDHRrb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Apr 2014 13:47:31 -0400
Received: from nm23-vm3.bullet.mail.ne1.yahoo.com ([98.138.91.153]:44233 "EHLO
	nm23-vm3.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754579AbaDHRra convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 8 Apr 2014 13:47:30 -0400
Received: from [98.138.101.130] by nm23.bullet.mail.ne1.yahoo.com with NNFMP; 08 Apr 2014 17:47:29 -0000
Received: from [98.138.89.198] by tm18.bullet.mail.ne1.yahoo.com with NNFMP; 08 Apr 2014 17:47:29 -0000
Received: from [127.0.0.1] by omp1056.mail.ne1.yahoo.com with NNFMP; 08 Apr 2014 17:47:29 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 635051.67537.bm@omp1056.mail.ne1.yahoo.com
Received: (qmail 71509 invoked by uid 60001); 8 Apr 2014 17:47:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1396979249; bh=ohNgJVDk2CGEoXBm4j0ZIKZxo9m3dsQyl5r6/McFf+g=; h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=csoubfPLIZZ4QBJud9OwSqYKnSmqn73ClnWVZ+46WgxALDyqd6Rm7a5lz7Ij1RF2ryj85quvGZj9hBFt2gmjBuwVfSVhyTG2l+2OcKArt0JqJJVFmfBJDeoXioeLEAcfWO1am1MSbWlDynOqsuXv2Gq21xt+2lBWfE1cJw7hd4A=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=zt2EQZnTwR48DsTUBPvzbyU7dIs9spnYvQzdnDXRD8/yYhaNL60l1cW9uD0CyY+XdPclaquZ1BVWPaN1Hs00SB1Aq1SN8NXnmHFiKduwZaN+ePL5nEgWhcVpyQgEdaXP7Fnzh0EHEkG3g6yLY5cGlz3FD4db6HyGAPWd3AN5Yig=;
X-YMail-OSG: Q0VLNYcVM1lrwzbCsCPnEUOkIyuRnizxS7hDaGKeC1pKC72
 QGX2jQmqre8bfDDAaqjfIvhv3lsj.w4E11LZEfzQnfj4klWwXI2SYcxMc1AT
 CGUD.LCBNzKqDAKnZQIRV09V6alWeFmbIZ_MvQoOO4.9Hq7u5GBucP.9uHlk
 Tqrk457PAW75_q0ZgzFEP7zXZgorbYBUdF.gI9ErTkxr4MkaMJ7Biu8tIHlB
 7zPG1DC68fHg22NHTdCRFCyGRPuqVbT55nzU5fffXWsT66QYjD36ux_5.fdF
 mkh2CYeN1YRbiOX4GqdKQhe6Z7AGuETT.eDkwFv6UKvDPKWtG1_lCnpptLyA
 bjHiP0W4zixQty6tG69gzRFQfmiZSt7Bom_Ryvb41zyMSsEkJhLq76M8kd2i
 iAXtGa3HRRjCh9TLlt2w0ExoAONy6jHr.ewK.tL8KWax7YnuWMghh8J2KO9N
 TFgXvc.HM9y5rW3kKDk8_QliKbpf8Vd6jP8iMXFFYYOXr_G_I7C7aecpi9Xs
 ya.m1zzxK6G8nAgsREAfUN0E9HpAAS9xIJuGFvQhi3YLnBSWEvxQhk.JwDg-
 -
Received: from [92.163.125.246] by web120805.mail.ne1.yahoo.com via HTTP; Tue, 08 Apr 2014 10:47:29 PDT
X-Rocket-MIMEInfo: 002.001,CgpIZWxsbyBBbmRyZXcsCgp5ZXMgdGhhdCBpcyBwb3NzaWJsZSB0byBoYXZlIHNjcmlwdHMgY3JlYXRlIHRoZSBtaXNzaW5nIGRpcmVjdG9yaWVzLgoKVGhlIHJlYXNvbiBJIGFza2VkIHRoaXMgaXMgcGVvcGxlIGF0IG15IHdvcmsgd2FudCB0byBhdm9pZCB0aGUgaGFzc2xlIG9mIGhhdmluZyB0byBjcmVhdGUgYSBzY3JpcHQgZm9yIHRoYXQuIFRoZXkgd2FudCB0byBjaGVja291dCBzZWFtbGVzc2x5IGFzIHRoZXkgdXNlZCB0byBkbyB3aXRoIHN1YnZlcnNpb24uCgpJIGd1ZXNzIGl0IGlzIHNpbWlsYXIgYXMBMAEBAQE-
X-Mailer: YahooMailWebService/0.8.182.648
In-Reply-To: <3FBDE5D3-1DC6-420C-866B-036D0CB17BA2@kellerfarm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245938>



Hello Andrew,

yes that is possible to have scripts create the missing directories.

The reason I asked this is people at my work want to avoid the hassle o=
f having to create a script for that. They want to checkout seamlessly =
as they used to do with subversion.

I guess it is similar as programming in Java and programming in plain o=
ld C.


Olivier LE ROY=20

________________________________
De=A0: Andrew Keller <andrew@kellerfarm.com>
=C0=A0: Olivier LE ROY <olivier_le_roy@yahoo.com>=20
Cc=A0: "git@vger.kernel.org" <git@vger.kernel.org>=20
Envoy=E9 le : Mardi 8 avril 2014 17h02
Objet=A0: Re: Handling empty directories in Git


On Apr 8, 2014, at 10:47 AM, Olivier LE ROY <olivier_le_roy@yahoo.com> =
wrote:


> Hello,=20
>=20
> I have a project under SVN with contains empty directories.
>=20
> I would like to move this project on a Git server, still handling emp=
ty directories.
>=20
> The solution: put a .gitignore file in each empty directory to have t=
hem recognized by the Git database cannot work, because some scripts in=
 my projects test the actual emptiness of the directories.
>=20
> Is there any expert able to tell me: this cannot be done in Git, or t=
his can be done by the following trick, or why there is no valuable rea=
son to maintain empty directories under version control?

Git is designed to track files.=A0 The existence of folders is secondar=
y to the notion that files have a relative path inside the repository, =
which is perceived by the user as folders.

Why can't your scripts create the folders on demand?=A0 Or, could your =
scripts interpret a missing folder as an empty folder?

Thanks,
Andrew Keller

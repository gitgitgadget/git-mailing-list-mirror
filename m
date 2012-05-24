From: Timothy Normand Miller <theosib@att.net>
Subject: =?windows-1252?Q?Git_hangs_at_=93Writing_objects=3A_11=25=94?=
Date: Thu, 24 May 2012 17:40:41 -0400
Message-ID: <EF4D4C5F-2D6B-46F2-B5A4-9DB1BA55BB6B@att.net>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 24 23:47:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXfs7-0002QW-Ga
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 23:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965567Ab2EXVq7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 May 2012 17:46:59 -0400
Received: from nm17-vm0.access.bullet.mail.mud.yahoo.com ([66.94.236.21]:29805
	"HELO nm17-vm0.access.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965151Ab2EXVq6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 17:46:58 -0400
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 May 2012 17:46:57 EDT
Received: from [66.94.237.126] by nm17.access.bullet.mail.mud.yahoo.com with NNFMP; 24 May 2012 21:40:42 -0000
Received: from [98.139.221.57] by tm1.access.bullet.mail.mud.yahoo.com with NNFMP; 24 May 2012 21:40:42 -0000
Received: from [127.0.0.1] by smtp110.sbc.mail.bf1.yahoo.com with NNFMP; 24 May 2012 21:40:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1337895642; bh=pHQ4TaPFez68VCDqpBKs+aeApsRnhztj46X7+LWyzp8=; h=X-Yahoo-Newman-Id:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:Received:From:Content-Type:Content-Transfer-Encoding:Subject:Date:Message-Id:To:Mime-Version:X-Mailer; b=TJUWDfWzLAe+svPPBu+rHI0+bMP4amwRc3G1jUcXdtjybSEOlO69rRMjIFtDdaKbcoegvacPxNmShvm+F3zer0KGEzx27UeC4LfJk4zJ4jIOw6yoN6Tw5tgU7oBuhpVGAJt1kqDa4Oj4Ers7ohG0/AAeBKIgonr3inphEgA3gyY=
X-Yahoo-Newman-Id: 619655.97246.bm@smtp110.sbc.mail.bf1.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: tX0HP3AVM1m7YTMUkiv_SeUkG_WZw18m9AEcri8yTXsCdha
 fKHZP5sle7WrNWbxU_9qkU1rtT_3wA6VJ6c52KK0.tdNpkcs475Gow3e7y_F
 Ujj0DwvNjvIjlcgJsBF1OgXS0W.XAVKC_HeK2o0imP2Dez3Z9eQWchLynYXr
 4ZDGS2r.jNCmXnwVDFGsdVcn_HjQoDUbtwyoXvmS7whZaLtqQgXOgpM6F1ht
 OU68LK.IJm6ZOPKaKvSxtuU8U8hsvhvy3f9cCehgeKjXFaLNwvx_Hx6TewZF
 w1h.EPoNITAlXk.8WyWUc6stwG.EBKesjq_NX_WvYdrH9Si2SLhNsNkgUjE4
 x4yxUtQLJhNr4VNSeIbuGHwvvf_Y63aNwaiunEgNPw9vlJr4AMOavQux2Rpw
 DwM7xlmlYW5vEBGTumuy7tSB23polaJ2mon_R3FOfK2YeT.hGgsfACpczqPz
 RwcbPOzCGXOFuzPDx1pNXZ6nfL_Yh2buPaPQlAGP2hj1HUeggS6Ux5VrQXSi
 HNgDQRJr1DdkEBaaitsufsBb0GxlnCpDzASRrG.epGgX59ri5bBWN1FbMPez
 6D12hUjCZ.1RHYDWXUWaLCfwAnzBYJwmfYf.X2kKWEA--
X-Yahoo-SMTP: fnCipqKswBBOUfpM7XF4CajMkMYSy.KS.UTLsA--
Received: from [192.168.1.107] (theosib@76.232.38.36 with plain)
        by smtp110.sbc.mail.bf1.yahoo.com with SMTP; 24 May 2012 14:40:42 -0700 PDT
X-Mailer: Apple Mail (2.1278)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198436>

Hi, everyone,

I've run into a problem that I cannot debug.  I've talked with people a=
t length on IRC, I've made ample use of Google.  I'm getting nowhere.  =
I'm not even getting any attention on stackexchange (where usually, que=
stions are answered with surprising alacrity). =20

This is not the common scenario of Windows and git-daemon that I have s=
een answered elsewhere. This is Linux to Linux, using ssh. On both the =
client and server, git version is 1.7.8.6.

I've tried doing the following:

	=95 Create a local empty repo and push to that -- works fine
	=95 Pull from local repo to local repo -- works fine
	=95 Clone the remote repo to the local machine -- works fine
	=95 git fsck and git gc on both server and client repos
	=95 Push to pre-existing remote repo -- hangs writing objects at 11%
	=95 Create empty remote repo and push to that -- hangs writing objects=
 at 2%

There's an env variable I can set to make git produce debug messages. N=
othing useful there.

Can anyone here help me figure out what's going wrong?


The post to stackexchange is at:  http://stackoverflow.com/questions/10=
740601/cannot-push-to-remote-git-repo-over-ssh-stuck-at-writing-objects=
-11


Thanks in advance for any advice you can give!

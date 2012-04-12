From: =?utf-8?B?UGFwIEzDtHJpbmM=?= <paplorinc@yahoo.com>
Subject: Re: Parallel refactoring and git merge nightmare
Date: Wed, 11 Apr 2012 22:23:57 -0700 (PDT)
Message-ID: <1334208237.82681.YahooMailNeo@web160606.mail.bf1.yahoo.com>
References: <1334160803.74554.YahooMailNeo@web160603.mail.bf1.yahoo.com> <CAJDDKr6v6uPLoAQ96fP7JM5F0_WHqfbaD=QKyfrWPWd2St7tKQ@mail.gmail.com>
Reply-To: =?utf-8?B?UGFwIEzDtHJpbmM=?= <paplorinc@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 07:29:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SICbR-0005xW-Ku
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 07:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756485Ab2DLF3s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Apr 2012 01:29:48 -0400
Received: from nm3.bullet.mail.bf1.yahoo.com ([98.139.212.162]:44667 "HELO
	nm3.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756190Ab2DLF3r convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 01:29:47 -0400
X-Greylist: delayed 349 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Apr 2012 01:29:47 EDT
Received: from [98.139.212.145] by nm3.bullet.mail.bf1.yahoo.com with NNFMP; 12 Apr 2012 05:23:57 -0000
Received: from [98.139.212.220] by tm2.bullet.mail.bf1.yahoo.com with NNFMP; 12 Apr 2012 05:23:57 -0000
Received: from [127.0.0.1] by omp1029.mail.bf1.yahoo.com with NNFMP; 12 Apr 2012 05:23:57 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 814661.64005.bm@omp1029.mail.bf1.yahoo.com
Received: (qmail 39577 invoked by uid 60001); 12 Apr 2012 05:23:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1334208237; bh=7VvsJyP4UKfhvrMQ+8ILnNLPGBDjczfcEzdtOXNC8F0=; h=X-YMail-OSG:Received:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=eX/XOdWtztBuP8Oj4oahcZgWwqA6saAe+LGXYLLVE1dUMuen0vHrekLXJG4dYqZVbuiy/pIJxWFGmqyqC44MVY+SyZ7T16rOo6mlZoQRcM7Okcg6TItnkVkorP/0QephPXW6Ww4UmCmIIXfJET8UDT7jtepUFxX7MExDowsm/zM=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=iFoPEaIXEbkJO5TpBulamHfyeFA3MdCS8Sa46w3Q4VILN5yEEDnj6ejmegfBY1xWYvorSgea5Ojs686GnOKJhu0iyzly5lSv2LKXboMGYKLlOUgIDtI7iZ4YtPOxAp/eJJTIxDkzsJHghfiVSVIvd31C+pE95z3JMSBpSbZCLPo=;
X-YMail-OSG: u0PdWusVM1n9.2dQqeGBrMS0mnl15Fg7aBV_8gTEWr1_2xa
 fwMVJygIcyl5YeGffnBTlV3BmCY.7XdX0cgqIMQmO9TRMhz.ThDzHhLUmZhf
 ta34mdnaOaS6jHgrXrgd68krbpz.tL_Q2zbcy0tYH2HOo3ODiiWw7ESWkZHd
 8dmeg6JoQ6XaKm_o2ewWpieFoVBUK7lBEBwKA7nur.V1BB8JqS.pwa7AlLUq
 oQmfvMyIBMI5ZogM8KDcHtvsBuqihjBCbWrrWpmccK25h1dggTt20o_mhv3F
 TCBPoFcSDuIkV29WnIUBZpYhTVUHNFKEkkF2w9rdEQqR25Eh2vTxhPrSttUe
 7OaXCegKTZhjDLnGTLEhgafzYZQ3D96XYZchWesHPqA9vp7Fi2fexHXqnP.B
 91M1u3bWzPVlJQ0n5_vcxloYG4YIRd_8tN2vlUv1aaPJ6xXFgjGetDqEgYqR
 CejhYKpjyEDtsHnsccJKKowhteSF5TwLxkVhaLXnV.X6Wh1ZjoJhyP1KwNLC
 L2NoBa.5Fx85TG1f_0FT045KNlRo1tqvHkeJJP1LBAaaoiHipd7UNCZrdOfG
 Xqzcbc51d290xSDtsO3dlcH0WQZaXU.EO6GnZpHCviz08lGfSt94wnaW2sCt
 _bFdhnsJIYSQcfzyIKdevpaoDjEMYUGn5UjBaow1jf6Auhu4Vohr7qC3puGp
 6hVejTnzec6w0Pyk7FPuR1jVQEoiiJFqmR_VPOXt.EsLXRQbLWjFKeP8D2sv
 hind8gaOek81weaGMVeLvep3_UwNAU16d_WaamT2lQERk6zhKgVVgfZd0pZK
 zcEvr0EFgX_SfTPq_ZNt4pH00Xox2vbI 
Received: from [89.137.110.183] by web160606.mail.bf1.yahoo.com via HTTP; Wed, 11 Apr 2012 22:23:57 PDT
X-Mailer: YahooMailWebService/0.8.117.340979
In-Reply-To: <CAJDDKr6v6uPLoAQ96fP7JM5F0_WHqfbaD=QKyfrWPWd2St7tKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195292>

>> Hello! :)
>>
>> We are working in parallel on the refactoring of a
>> small project. The team uses SVN and I decided to give GIT a chance =
to
>> demonstrate it's merging capabilities I've read so much good about :=
).
>>
>> However
>> =C2=A0- I must be doing something VERY wrong - every time I try to m=
erge from
>> =C2=A0the remote svn (git svn fetch and git merge remotebranch) into=
 my
>> branch, I get hundreds of conflicts, mostly because of moved folders=
=2E
>
>Google is your friend
>
>https://wiki.kuali.org/display/KULRICE/git-svn+how+to
>
>http://flavio.castelli.name/howto_use_git_with_svn
>
>http://viget.com/extend/effectively-using-git-with-subversion
>
>http://java.dzone.com/articles/how-start-using-git-svn-based
>--=20
>David

I have no idea why you guys think I'm an idiot.
I have read every link I could find (most of the Pro Git book and watch=
ed several hours of git video tutorials). The problem is not with GIT-S=
VN, it's with the GIT merge, more specifically with a simultaneous modi=
fy and move, which conflicts probably because it is detected as a modif=
y and delete.
Could someone please be a little more friendly, I need advice on how to=
 solve hundreds of git merge conflicts (eg. parallel move and modify, w=
hich should have been merged automatically).

Thanks,
L=C5=91rinc

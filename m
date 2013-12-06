From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: problems with git --git-dir on windows 7
Date: Fri, 6 Dec 2013 08:07:27 +0700
Message-ID: <CACsJy8DBYOwTOapOdLf=hTTWQB1U5U74FKSbUmqwXBAG++C=kg@mail.gmail.com>
References: <EF40980AA2C4C4449E2D87B419007B7F18E0FACA@SPMWB01L.luinternal.fortis.bank>
 <EF40980AA2C4C4449E2D87B419007B7F18E0FACB@SPMWB01L.luinternal.fortis.bank>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: Git Mailing List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: SCHILZ MANFRED <manfred.schilz@bgl.lu>
X-From: msysgit+bncBC2ZN5PHQUMBB3WGQSKQKGQEC5XQYDQ@googlegroups.com Fri Dec 06 02:08:02 2013
Return-path: <msysgit+bncBC2ZN5PHQUMBB3WGQSKQKGQEC5XQYDQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f186.google.com ([209.85.220.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC2ZN5PHQUMBB3WGQSKQKGQEC5XQYDQ@googlegroups.com>)
	id 1Vojtf-0005v6-PG
	for gcvm-msysgit@m.gmane.org; Fri, 06 Dec 2013 02:08:00 +0100
Received: by mail-vc0-f186.google.com with SMTP id ld13sf4881vcb.13
        for <gcvm-msysgit@m.gmane.org>; Thu, 05 Dec 2013 17:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=vpTxpGB845IEMGcydy5ufLc1R0wpOpXfoCdm8Lx+TxU=;
        b=ibCRSxBWflhoU9VRR8eb+6x70pRr/BwAdTpatilgZrMAPvBfBoxQLNGku7iWpFnxJk
         oEEAmkfjOzdb0MVEt4vOiJlBk/gjfmTgBwarJ/THZNsMA0Dgbw1qtJ+Sya+X5C427xCH
         FLYmTOMdtJ3xPadRAS8Y8jA770/uJ4DMM0+HPYAC2ig3DT/rAkKkLowVh4/PMp15+toy
         g0aa/yR0/HZBWxaCHQW/gd0NnNGeu1iW7B5VQdPymh874HF/DIeWVjnuGN0KdQPxTYx3
         guPsSOdJYHO0vlQJH2+A1Pus7nUytxAUWWoo1mfas1GxOv4BaEZGL3Rt/bC5Z03/lSvD
         CeEQ==
X-Received: by 10.50.73.4 with SMTP id h4mr1042igv.13.1386292078867;
        Thu, 05 Dec 2013 17:07:58 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.83.68 with SMTP id o4ls148376igy.12.canary; Thu, 05 Dec
 2013 17:07:58 -0800 (PST)
X-Received: by 10.66.231.132 with SMTP id tg4mr336015pac.31.1386292077969;
        Thu, 05 Dec 2013 17:07:57 -0800 (PST)
Received: from mail-qc0-x22b.google.com (mail-qc0-x22b.google.com [2607:f8b0:400d:c01::22b])
        by gmr-mx.google.com with ESMTPS id t9si916970qcn.2.2013.12.05.17.07.57
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 17:07:57 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400d:c01::22b as permitted sender) client-ip=2607:f8b0:400d:c01::22b;
Received: by mail-qc0-x22b.google.com with SMTP id c9so5405qcz.16
        for <msysgit@googlegroups.com>; Thu, 05 Dec 2013 17:07:57 -0800 (PST)
X-Received: by 10.224.61.1 with SMTP id r1mr109931143qah.97.1386292077728;
 Thu, 05 Dec 2013 17:07:57 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Thu, 5 Dec 2013 17:07:27 -0800 (PST)
In-Reply-To: <EF40980AA2C4C4449E2D87B419007B7F18E0FACB@SPMWB01L.luinternal.fortis.bank>
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400d:c01::22b
 as permitted sender) smtp.mail=pclouds@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238920>

On Wed, Dec 4, 2013 at 11:11 PM, SCHILZ MANFRED <manfred.schilz@bgl.lu> wro=
te:
> Hello,
> We are using git on windows7(git-version 1.8.1; see below) and we get the=
 following problem in using the command 'git --git-dir=3D'
>
>
> C:\UserTemp\git\appli3>git  --git-dir=3DC:\UserTemp\git\appli3 tag
> fatal: Not a git repository: 'C:\UserTemp\git\appli3'
>
>
> but the repository is well defined,as we can run the following command:
>
> C:\UserTemp\git\appli3>git log -1 --oneline
> 37cdbe0 Merge branch 'master' of L:/_ApplicationData/FBLU_IT-FLIT/se-Deve=
lopSupp

I have no clue. The --git-dir calls
is_git_directory("C:\\UserTemp\\git\\appli3") while the "git log"
calls is_git_directory("."). The former fails and the latter suceeds..
Copying msysgit@ maybe they know something. Btw what if you try

git --git-dir=3D. tag

?

>
> When running the equivalent command on Linux, we don't have any problems:
> On Linux:
>>git --git-dir=3D"/tmp/GITPOC/appli3" tag
> V1.0
> V1.1
> V2.0
> V3.0
>
> Could you help me please ?
>
> Best regards
>
> Manfred Schilz
>
> -------------------------------------------------------------------------=
--------------
> C:\UserTemp\git\appli3>git --version
> git version 1.8.1.msysgit.1
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Internet communications are not secure and therefore BGL BNP Paribas does=
 not accept legal responsibility for the contents of this message. The info=
rmation contained in this e-mail is confidential and may be legally privile=
ged. It is intended solely for the addressee. If you are not the intended r=
ecipient, any disclosure, copying, distribution or any action taken or omit=
ted to be taken in reliance on it, is prohibited and may be unlawful. Nothi=
ng in the message is capable or intended to create any legally binding obli=
gations on either party and it is not intended to provide legal advice.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Duy

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.

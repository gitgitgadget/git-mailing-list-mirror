From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: git svn clone not work. It's stop with no error message.
Date: Mon, 17 Feb 2014 19:23:07 +0800
Message-ID: <CALUzUxp=h-5mK-=YjvFRzyGGLp_-HxT661-P2yaqT9_6jPGnwA@mail.gmail.com>
References: <1392623113974-7603785.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Git Mailing List <git@vger.kernel.org>, youngseonkim <1.youngsun.kim@gmail.com>
To: "msysgit@googlegroups.com" <msysgit@googlegroups.com>
X-From: msysgit+bncBCEMFWO7QMPRBMHCQ6MAKGQEFD2NKGY@googlegroups.com Mon Feb 17 12:23:40 2014
Return-path: <msysgit+bncBCEMFWO7QMPRBMHCQ6MAKGQEFD2NKGY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f187.google.com ([209.85.212.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCEMFWO7QMPRBMHCQ6MAKGQEFD2NKGY@googlegroups.com>)
	id 1WFMIL-0005Aw-Qz
	for gcvm-msysgit@m.gmane.org; Mon, 17 Feb 2014 12:23:29 +0100
Received: by mail-wi0-f187.google.com with SMTP id hn9sf277250wib.24
        for <gcvm-msysgit@m.gmane.org>; Mon, 17 Feb 2014 03:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=F1SNM+QJS1F6zB18vWqYtQIwD6v7lx80RMDqVN7cnWQ=;
        b=Bw+DLBKchI1RjaJpk58KtOTAV3Sap9c6BHAtZah/iKoB3fk3n+z9a1Jtk4DUa0YZPV
         3/cBTR6WHTC8yVahTTC2cbrFMtpM0YYPDfwe8IQrmcihmZKW7MilSkZESqycIt8qD83h
         gk1eu4ZDQoQxXU589twdZrjKAk8UcAvy+rYkQg68JEwF5SG1OeiXi8zPaDOSAqocCC03
         7MshEzRIbcAKKhfjzTEr4rXs+9aBiXiTeZNOG/5jpGznh8hSD/Q2I4vtSaXOMOafs9F5
         tr/+PRS/sl1WYD6HxL+N19uHyWfjCJbwt21poEsMmUFUKpzDdwSl6g5bCG0mQrHOsyuD
         STGQ==
X-Received: by 10.180.78.39 with SMTP id y7mr70711wiw.21.1392636209356;
        Mon, 17 Feb 2014 03:23:29 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.90.166 with SMTP id bx6ls274697wib.19.gmail; Mon, 17 Feb
 2014 03:23:28 -0800 (PST)
X-Received: by 10.180.106.5 with SMTP id gq5mr6998223wib.2.1392636208234;
        Mon, 17 Feb 2014 03:23:28 -0800 (PST)
Received: from mail-lb0-x234.google.com (mail-lb0-x234.google.com [2a00:1450:4010:c04::234])
        by gmr-mx.google.com with ESMTPS id sw6si443703bkb.0.2014.02.17.03.23.28
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 17 Feb 2014 03:23:28 -0800 (PST)
Received-SPF: pass (google.com: domain of rctay89@gmail.com designates 2a00:1450:4010:c04::234 as permitted sender) client-ip=2a00:1450:4010:c04::234;
Received: by mail-lb0-x234.google.com with SMTP id n15so11265961lbi.11
        for <msysgit@googlegroups.com>; Mon, 17 Feb 2014 03:23:28 -0800 (PST)
X-Received: by 10.152.27.133 with SMTP id t5mr333540lag.66.1392636208012; Mon,
 17 Feb 2014 03:23:28 -0800 (PST)
Received: by 10.114.64.15 with HTTP; Mon, 17 Feb 2014 03:23:07 -0800 (PST)
In-Reply-To: <1392623113974-7603785.post@n2.nabble.com>
X-Original-Sender: rctay89@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of rctay89@gmail.com designates 2a00:1450:4010:c04::234
 as permitted sender) smtp.mail=rctay89@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242253>

Posting to msysgit since this was on Windows.

--=20
Cheers,
Ray Chuan

On Mon, Feb 17, 2014 at 3:45 PM, youngseonkim <1.youngsun.kim@gmail.com> wr=
ote:
> Hi, I really wonder about this happen.
> I want svn=E2=86=92git migrate, and I use this command.
>
> git svn clone https://my.svn.repo/url --stdlayout
>
> When I test a small svn repository and 'real working repository 1' with s=
ame
> this command, it's complete successfully.
> But it's not work in a 'real working repository 2', it just stop suddenly=
.
>
> CMD console not shown any error message, last message are like this.
>
> r1 =3D 67f4093b82b7b764171b01f1566eca57f6c29ac2
>
> I don't know about why this process stop.. 'real repository 2' configured
> same with 'real repository 1'.
> 'Real working repository 2' are very large but I don't know accurate size=
..
> I working on Windows server 2008, 16GB RAM memory, 16 cores cpu, upper th=
en
> 100GB hard disk space.
>
> I'm sorry. I'm not speak English well. But I really want someone help me.=
.
> Anybody have some idea about this happen?
>
>
>
> --
> View this message in context: http://git.661346.n2.nabble.com/git-svn-clo=
ne-not-work-It-s-stop-with-no-error-message-tp7603785.html
> Sent from the git mailing list archive at Nabble.com.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

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

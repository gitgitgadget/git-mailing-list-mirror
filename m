From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git checkout doesn't work?
Date: Fri, 11 Jan 2013 19:52:52 +0700
Message-ID: <CACsJy8B8Cf95uqh4vgzHayhtajSUdtD3QXk6-wMGeAVkW94JpA@mail.gmail.com>
References: <CAJ52sWkhQDhaZxjp4vxdwSX8HGYMqaXW=gZ-d6atUDKSjHg=yw@mail.gmail.com>
 <CAJ52sWkf+ZkLUdLw1ornVt5E2af3w1YSqhkOajTWxvTPKvkAJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: quoted-printable
Cc: git <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Ishayahu Lastov <meoc-it@mail.ru>
X-From: msysgit+bncBC2ZN5PHQUMBBQUWYCDQKGQEQXGONRY@googlegroups.com Fri Jan 11 13:53:41 2013
Return-path: <msysgit+bncBC2ZN5PHQUMBBQUWYCDQKGQEQXGONRY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f190.google.com ([209.85.214.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC2ZN5PHQUMBBQUWYCDQKGQEQXGONRY@googlegroups.com>)
	id 1Tte79-0001qf-Ih
	for gcvm-msysgit@m.gmane.org; Fri, 11 Jan 2013 13:53:39 +0100
Received: by mail-ob0-f190.google.com with SMTP id ta14sf847237obb.17
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jan 2013 04:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=+LWBomiZ9hHbhhULf5v0un4O3QktgLd3phx30YL9EcM=;
        b=Xi031mOUAsCF9+AJFvhlhVnsTZ1NAwdKY27X5DJtf//HDr1aLMumIhCVmeGsJkbsyf
         FFjQ1xc/7zvwHcMltgcbsyDhYG4SyCwPzNkXDxBoAyKy2UgpWaFBYnggJyGzYwPaCdcw
         UuPCaS8B77DB0JWZFjFGhkT4OON87chBNL+tzGaGN7j/pGCDUCEPOwB9HNm803oqnhHh
         58kPo2l7wv6vkDB2iNAeTg6ejrop92Jm87UAlMv63N0lKAXD+vnrU0tpbmDbZ0yzBHP0
         Y88a7rxZtkyk1GtrAvuFoGDzfr 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=+LWBomiZ9hHbhhULf5v0un4O3QktgLd3phx30YL9EcM=;
        b=jR9wtJzmt5IaZWXyQTV2bgmMbdXQoBaF/SMBSUo+0M1+0I//YYn5kv4kIItX65wSta
         lu8I1ficpgIvTdh8v6uyQXkEbv3m1MMNNuPuuyYjrFiImF2Efap5gSmedWivQz1Ke98R
         xZ6iC3ftOqGSGRv2VtbixlYz6g+ub8r0+WeiL4wJU1y6u+diTvM8ac3JRl8u1BxlJWOO
         yomel2wDTfycxgLGxubOarv9Z73nq67mTsGxRIOQqu8ICrzVeAbxXzu1qfDvBj2LPEho
         xuckjF8xWdi4Xv6iFP0GvXW7jqKqSRGRt 
X-Received: by 10.50.34.231 with SMTP id c7mr65429igj.8.1357908803000;
        Fri, 11 Jan 2013 04:53:23 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.212.39 with SMTP id nh7ls295699igc.8.gmail; Fri, 11 Jan
 2013 04:53:22 -0800 (PST)
X-Received: by 10.42.80.140 with SMTP id v12mr57138763ick.5.1357908802347;
        Fri, 11 Jan 2013 04:53:22 -0800 (PST)
X-Received: by 10.42.80.140 with SMTP id v12mr57138762ick.5.1357908802336;
        Fri, 11 Jan 2013 04:53:22 -0800 (PST)
Received: from mail-ob0-f182.google.com (mail-ob0-f182.google.com [209.85.214.182])
        by gmr-mx.google.com with ESMTPS id x4si1172418igm.0.2013.01.11.04.53.22
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 04:53:22 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 209.85.214.182 as permitted sender) client-ip=209.85.214.182;
Received: by mail-ob0-f182.google.com with SMTP id 16so1686553obc.13
        for <msysgit@googlegroups.com>; Fri, 11 Jan 2013 04:53:22 -0800 (PST)
Received: by 10.182.188.69 with SMTP id fy5mr62775obc.74.1357908802193; Fri,
 11 Jan 2013 04:53:22 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Fri, 11 Jan 2013 04:52:52 -0800 (PST)
In-Reply-To: <CAJ52sWkf+ZkLUdLw1ornVt5E2af3w1YSqhkOajTWxvTPKvkAJg@mail.gmail.com>
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of pclouds@gmail.com designates 209.85.214.182 as
 permitted sender) smtp.mail=pclouds@gmail.com;       dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213215>

On Fri, Jan 11, 2013 at 1:46 PM, Ishayahu Lastov <meoc-it@mail.ru> wrote:
> This is my session on Win7 x64:
> Microsoft Windows [Version 6.1.7601]
> (c) =EB=CF=D2=D0=CF=D2=C1=C3=C9=D1 =ED=C1=CA=CB=D2=CF=D3=CF=C6=D4 (Micros=
oft Corp.), 2009. =F7=D3=C5 =D0=D2=C1=D7=C1 =DA=C1=DD=C9=DD=C5=CE=D9.
>
> C:\Dropbox\Dropbox\Wesnoth\Apocryphs>cd Apokryphs.Orks
>
> C:\Dropbox\Dropbox\Wesnoth\Apocryphs\Apokryphs.Orks>git status
> # On branch master
> # Your branch is behind 'origin/master' by 3 commits, and can be fast-for=
warded.
>
> #
> # Changes not staged for commit:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working direct=
ory)
> #
> #       modified:   scenarios/01_NothernVillage.cfg
> #
> no changes added to commit (use "git add" and/or "git commit -a")
>
> C:\Dropbox\Dropbox\Wesnoth\Apocryphs\Apokryphs.Orks>cd scenarios
>
> C:\Dropbox\Dropbox\Wesnoth\Apocryphs\Apokryphs.Orks\scenarios>git status
> # On branch master
> # Your branch is behind 'origin/master' by 3 commits, and can be fast-for=
warded.
>
> #
> # Changes not staged for commit:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working direct=
ory)
> #
> #       modified:   01_NothernVillage.cfg
> #
> no changes added to commit (use "git add" and/or "git commit -a")
>
> C:\Dropbox\Dropbox\Wesnoth\Apocryphs\Apokryphs.Orks\scenarios>git checkou=
t -- 01
> _NothernVillage.cfg
>
> C:\Dropbox\Dropbox\Wesnoth\Apocryphs\Apokryphs.Orks\scenarios>git status
> # On branch master
> # Your branch is behind 'origin/master' by 3 commits, and can be fast-for=
warded.
>
> #
> # Changes not staged for commit:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working direct=
ory)
> #
> #       modified:   01_NothernVillage.cfg
> #
> no changes added to commit (use "git add" and/or "git commit -a")
>
> C:\Dropbox\Dropbox\Wesnoth\Apocryphs\Apokryphs.Orks\scenarios>
>
> As I understand after last "git checkout" in "git status" I should see
> that I gave no changes. It looks like an bug, isn't it?

Yeah, perhaps it's file attributes. What does this say?

git diff --summary --stat
--=20
Duy

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

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Regression in e02ca72: git svn rebase is broken on Windows
Date: Tue, 10 Sep 2013 20:02:14 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1309101958480.1191@s15462909.onlinehome-server.info>
References: <17231378818848@web5m.yandex.ru> <alpine.DEB.1.00.1309101812450.1191@s15462909.onlinehome-server.info> <93421378835002@web20j.yandex.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, msysgit@googlegroups.com
To: Tvangeste <i.4m.l33t@yandex.ru>
X-From: msysgit+bncBCZPH74Q5YNRBKN5XWIQKGQEYNG2FZI@googlegroups.com Tue Sep 10 20:02:20 2013
Return-path: <msysgit+bncBCZPH74Q5YNRBKN5XWIQKGQEYNG2FZI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ye0-f190.google.com ([209.85.213.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBKN5XWIQKGQEYNG2FZI@googlegroups.com>)
	id 1VJSGY-0005Oy-N7
	for gcvm-msysgit@m.gmane.org; Tue, 10 Sep 2013 20:02:18 +0200
Received: by mail-ye0-f190.google.com with SMTP id r3sf1884299yen.7
        for <gcvm-msysgit@m.gmane.org>; Tue, 10 Sep 2013 11:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=cQhsA2eR42F89x1ImU/lY+n1XERR2FqfcT9rHys2AWQ=;
        b=bwPlPhS0eA0hAhTfWWxLA/B1GSFnkAs6lWxaoeDmy+R2ZXvS7u70YhieeJOuoZJ4MF
         4VsGn7KXlquapP9ZxzBVXDo/DxIx1ggapEYapYcEovPMssbH9a/0q/4r13Xq3OSVI1If
         kI9dBFzpsfRxBwBCFlgAIZUvhqbAzDhZapImDTwlPOXGs8jf33TaJGApqqUBdjtBNtXD
         fWuR6VCYKgMMMNTaFlThtk7CdS7VUJLvqyjYEJ9hS5wGQjDsfwhDHTF4EHHYxKHRqOu5
         WEAi91L967JFB9w2zJVVQv9VJLVJJPuvXgghgpq4iLtN0ZcOedMaY6cQKbQBAbO++8e4
         0x+w==
X-Received: by 10.49.128.129 with SMTP id no1mr85179qeb.23.1378836137748;
        Tue, 10 Sep 2013 11:02:17 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.85.200 with SMTP id j8ls2204649qez.6.gmail; Tue, 10 Sep
 2013 11:02:17 -0700 (PDT)
X-Received: by 10.58.255.74 with SMTP id ao10mr665814ved.38.1378836137142;
        Tue, 10 Sep 2013 11:02:17 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.20])
        by gmr-mx.google.com with ESMTPS id da4si913405vdb.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=AES128-SHA bits=128/128);
        Tue, 10 Sep 2013 11:02:17 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.20 as permitted sender) client-ip=212.227.17.20;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0M7pDs-1WEhcd0EVM-00vM6w
 for <msysgit@googlegroups.com>; Tue, 10 Sep 2013 20:02:15 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <93421378835002@web20j.yandex.ru>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:7sKQbPbYIXkZJoU4ptDemeqQVYLSEJgkU2gj8KrVUS1ru57zpz6
 ZdbqMUIKlBEfnwLKCmfbMnXQsk9GGGFcx46SKdo/WH5iiw/+QYASFuQTM00xs0HO9oZAOgH
 pkbJ0FKnqIO01hBnCV6om4s9HuAAKvsb2IvkRjYV7kCSY2bCGyEsjQ/KdC9aG8VqAXeXvWx
 Ktx4uqXHWIi6DoLBa0BTQ==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.20 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234466>

Hi Tvangeste,

On Tue, 10 Sep 2013, Tvangeste wrote:

> 10.09.2013, 18:13, "Johannes Schindelin" <Johannes.Schindelin@gmx.de>:
> > Have you tried with Git for Windows yet?
> 
> What's Git for Windows? If you mean msysgit,

Actually, they are two different things: Git for Windows is what the name
says, and it comes with an installer. msysGit is the development
environment to *build* Git for Windows.

> then I say no, because the latest msysgit version is from June 02, and
> the change under discussion was made later on, on June 25th. So, this
> regression is not in msysgit release (yet).

Given the explanation what msysGit is, you might suspect that I'd like you
to try to fix this in the msysGit context: After installing

	https://code.google.com/p/msysgit/downloads/list?q=net+installer

you will have a full build environment, including the build of our latest
master. You can then "cd /git/" and "git checkout pt/tentative-1.8.4 &&
make install" to make sure that the version we are very close to releasing
as the new Git for Windows version does not break your workflow.

Ciao,
Johannes

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.

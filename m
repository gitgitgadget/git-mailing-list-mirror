From: Orgad and Raizel Shaneh <orgads@gmail.com>
Subject: Re: relative objects/info/alternates doesn't work on remote
 SMB repo
Date: Thu, 30 Aug 2012 16:34:09 +0300
Message-ID: <CAGHpTBLbPvkEGqh5PGbtNS0MKY5YutaQpx3D_Fv5oSWeR52K9A@mail.gmail.com>
References: <CAGHpTBKNurqd0xcz9A9bC8MQU8yHfef0ozJ2Khr9uQvwHoyP2g@mail.gmail.com>
	<CACsJy8BSpX7UxAEhZTqNnazAtSMp7oZtyxiBdnVoCXefWpTDEw@mail.gmail.com>
	<CAGHpTB+TbrQLw7E+RpP8y0euYrLNOC6-sic-4x3pbxcAborFLQ@mail.gmail.com>
	<CACsJy8B3=33FE-SbOD6Su4v_DbyuYsxfh-DxAzbJbJa5B2pyLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: msysgit+bncCILqpr-rHxDS1_2BBRoEytGoFg@googlegroups.com Thu Aug 30 15:34:15 2012
Return-path: <msysgit+bncCILqpr-rHxDS1_2BBRoEytGoFg@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f186.google.com ([209.85.213.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCILqpr-rHxDS1_2BBRoEytGoFg@googlegroups.com>)
	id 1T74sv-0005tT-HI
	for gcvm-msysgit@m.gmane.org; Thu, 30 Aug 2012 15:34:13 +0200
Received: by yenl8 with SMTP id l8sf1524775yen.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 30 Aug 2012 06:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=Cww92VSUNoeC6ktB6cooGwxxG/6mfKLsMzsIzLb07wM=;
        b=pWjgrjyOZtGK1jBJiSEhe1PKy3D83ifek7dhbq/dE0p8wSUTr09CS8ard6X5rg+cuB
         LZNoKXWoo+sXBLWpM/mEr2fCnSil1UXTWzVOegXnt5BSycJs/QaNxpCu2Fmto35ljpu8
         q0GKBZpsQyXWGl1+wWDV0dGYkTl6Y4erw+VE87IkXEUyBn/ZBs66dl3lIWoIvimTBkNN
         Lt8y7VXG7JcSrsIhEJsmMnd+Z2I6PbnW1mNFIQo5z1z6X1zKBzEplPiFV/02Mpesim9k
         6ZQzFj6r9fpttoiptPkZuioRzHR7snTvlEmHO15X8gOWjpge2euwz4ApfrlnQ+80Kv7d
         dzQw==
Received: by 10.236.190.100 with SMTP id d64mr496892yhn.17.1346333650720;
        Thu, 30 Aug 2012 06:34:10 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.236.154.232 with SMTP id h68ls3519016yhk.2.gmail; Thu, 30 Aug
 2012 06:34:09 -0700 (PDT)
Received: by 10.236.138.232 with SMTP id a68mr3685582yhj.28.1346333649446;
        Thu, 30 Aug 2012 06:34:09 -0700 (PDT)
Received: by 10.236.138.232 with SMTP id a68mr3685581yhj.28.1346333649432;
        Thu, 30 Aug 2012 06:34:09 -0700 (PDT)
Received: from mail-qc0-f173.google.com (mail-qc0-f173.google.com [209.85.216.173])
        by gmr-mx.google.com with ESMTPS id k34si407844qcz.1.2012.08.30.06.34.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 30 Aug 2012 06:34:09 -0700 (PDT)
Received-SPF: pass (google.com: domain of orgads@gmail.com designates 209.85.216.173 as permitted sender) client-ip=209.85.216.173;
Received: by qcab12 with SMTP id b12so1585611qca.32
        for <msysgit@googlegroups.com>; Thu, 30 Aug 2012 06:34:09 -0700 (PDT)
Received: by 10.229.135.11 with SMTP id l11mr2863685qct.116.1346333649149;
 Thu, 30 Aug 2012 06:34:09 -0700 (PDT)
Received: by 10.49.131.8 with HTTP; Thu, 30 Aug 2012 06:34:09 -0700 (PDT)
In-Reply-To: <CACsJy8B3=33FE-SbOD6Su4v_DbyuYsxfh-DxAzbJbJa5B2pyLg@mail.gmail.com>
X-Original-Sender: orgads@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of orgads@gmail.com designates 209.85.216.173 as permitted sender)
 smtp.mail=orgads@gmail.com; dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204539>

On Thu, Aug 30, 2012 at 4:22 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Thu, Aug 30, 2012 at 8:12 PM, Orgad and Raizel Shaneh
> <orgads@gmail.com> wrote:
>>> Could be path normalization. What does "git rev-parse --git-dir" say?
>>> Try to run it at top working directory and a subdirectory as well.
>>>
>>> If you set GIT_OBJECT_DIRECTORY environment variable to
>>> //server/share/foo/repo/.git/objects, does it work?
>>
>> git rev-parse --git-dir in a subdirectory has //server
>
> Hmm where is your git repository? That does not look like a git
> repository's path.
>

Let me try to explain again.
I have /d/share/bare, which is a bare repository, and /d/share/repo
which is a clone with a relative path to bare/.git/objects in its
.git/objects/info/alternates

D:\share is configured as a SMB shared folder. It is accessed using
//server/share.
I do not clone from this directory, but work directly in it using 'cd
//server/share', then performing git operations.

>> setting GIT_OBJECT_DIRECTORY prints "fatal: bad object HEAD" on git status.
>
> I guessed you put your repo in .../repo/.git, but I was probably
> wrong. Try setting again, pointing GIT_OBJECT_DIRECTORY to the
> "objects" directory inside your repository. I just want to make see if
> it's because git miscalculates this path. If setting the env variable
> works, then it probably does.
> --
> Duy

Same result. fatal: bad object HEAD. Tried even using a full (local)
path to the objects dir.

- Orgad

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

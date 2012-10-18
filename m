From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Git for Windows and line endings
Date: Fri, 19 Oct 2012 00:40:11 +0200
Message-ID: <CABPQNSZE7TP0G-uW1b1nbsNgpxYCEiD5KefS62GB5gZbWyZXDQ@mail.gmail.com>
References: <CADKp0pyy=Nnv29LyhzAOX4B5wJNYnZ0h5d7zxNRyZxV2OGUSjg@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Chris B <chris.blaszczynski@gmail.com>
X-From: msysgit+bncBDR53PPJ7YHRB5EKQKCAKGQERSGFPGA@googlegroups.com Fri Oct 19 00:41:04 2012
Return-path: <msysgit+bncBDR53PPJ7YHRB5EKQKCAKGQERSGFPGA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ia0-f186.google.com ([209.85.210.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRB5EKQKCAKGQERSGFPGA@googlegroups.com>)
	id 1TOylw-0008Vh-Ej
	for gcvm-msysgit@m.gmane.org; Fri, 19 Oct 2012 00:41:00 +0200
Received: by mail-ia0-f186.google.com with SMTP id k10sf7280886iag.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 18 Oct 2012 15:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=hZP/zffZu0oPOhcUdnuxXqXPAgKVYjlQBrjpevUTbo4=;
        b=qEWHmF+BJNb/alJSfDAVfhMoedHC3+CK4wK93Z+zWT0M6jttIPhL1iko5cWEdmTUmy
         0lK89Un4TLQJQMzB4p9eDfTmmBuVC8r32cHG44zU1rDG34WX6pd42VtRDTYZgIxIJAxL
         nAVvRhPp0kTb8BvB+/vOPwxiKkf7qVgLbg5hX6udKHSlWaVEMWULAxlLr0/UGhFNo9aF
         E6eFPeK4P0N/+fQZp6CMJjWtDCTK+GYdZvnaRhpSKaZrMUwyUUphhdOGEpAil9AFETsM
         +HvkKagVvktL8/SPdFjrTeVT3J2AUOH7UnoIJKohPgpDty4Isv0dsYX2XBduJ6zuoi2R
         msTA==
Received: by 10.52.28.45 with SMTP id y13mr4110157vdg.10.1350600052972;
        Thu, 18 Oct 2012 15:40:52 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.220.226.7 with SMTP id iu7ls1372148vcb.6.gmail; Thu, 18 Oct
 2012 15:40:52 -0700 (PDT)
Received: by 10.58.19.136 with SMTP id f8mr5027685vee.18.1350600052175;
        Thu, 18 Oct 2012 15:40:52 -0700 (PDT)
Received: by 10.58.19.136 with SMTP id f8mr5027684vee.18.1350600052165;
        Thu, 18 Oct 2012 15:40:52 -0700 (PDT)
Received: from mail-vb0-f54.google.com (mail-vb0-f54.google.com [209.85.212.54])
        by gmr-mx.google.com with ESMTPS id es5si974869vdb.2.2012.10.18.15.40.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Oct 2012 15:40:52 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.212.54 as permitted sender) client-ip=209.85.212.54;
Received: by mail-vb0-f54.google.com with SMTP id v11so16321543vbm.27
        for <msysgit@googlegroups.com>; Thu, 18 Oct 2012 15:40:52 -0700 (PDT)
Received: by 10.52.175.200 with SMTP id cc8mr14128947vdc.21.1350600051789;
 Thu, 18 Oct 2012 15:40:51 -0700 (PDT)
Received: by 10.58.169.106 with HTTP; Thu, 18 Oct 2012 15:40:11 -0700 (PDT)
In-Reply-To: <CADKp0pyy=Nnv29LyhzAOX4B5wJNYnZ0h5d7zxNRyZxV2OGUSjg@mail.gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.212.54 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208026>

On Fri, Oct 19, 2012 at 12:13 AM, Chris B <chris.blaszczynski@gmail.com> wrote:
> Hi.. it is such a crime to have that default option of MSysGit mess
> around with the line endings.

No it's not.

> There is no thought to the fact that it's possible the Git users are
> not using Git the exact way the authors thought it would be used.

Suggesting this is just insulting. A lot of thought was laid to ground
for the decision.

> We have both Windows and Linux systems that have parts of their files
> stored in Git repositories. And in addition to that, some Linux and
> Windows Git clients. If everyone leaves the line endings alone,
> everything works out just fine!

No, it will not. Notepad, which is the default text editor on Windows,
barfs on LF line-endings, and many vi installations does the same
thing on Unix-systems bards on CRLF line-endings. And so does a huge
amount of custom, less tested tools.

Thinking that "this works for me, so it must work for everyone" is
exactly the reason why this whole situation is a big mess. You are
only making it worse by not realizing the issues.

> But messing with the line endings broke some things in production.

I'm not even sure what you're trying to say with this e-mail other
than to blame us for your own problems. Stop making broken commits.
Clean up after you when you did by accident. And for the love of God,
stop blaming other people when you messed up.

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

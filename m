From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Feature request: Add url/dir parameter to git svn info
Date: Sat, 11 Aug 2012 12:58:01 +0200
Message-ID: <CABPQNSYbBOijvYP+i5B4_73NQCf9pMjbk9UZBU0-uDrqFVRjpg@mail.gmail.com>
References: <1ca091b8-1c8e-419a-afbd-34f5aa3f1ac2@googlegroups.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, Git Mailing List <git@vger.kernel.org>
To: bartoszrojek@gmail.com
X-From: msysgit+bncCOPdven-DxDi9ZiBBRoETGe2TQ@googlegroups.com Sat Aug 11 12:58:44 2012
Return-path: <msysgit+bncCOPdven-DxDi9ZiBBRoETGe2TQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qa0-f58.google.com ([209.85.216.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxDi9ZiBBRoETGe2TQ@googlegroups.com>)
	id 1T09P2-0008D5-2H
	for gcvm-msysgit@m.gmane.org; Sat, 11 Aug 2012 12:58:44 +0200
Received: by qafi29 with SMTP id i29sf2542345qaf.3
        for <gcvm-msysgit@m.gmane.org>; Sat, 11 Aug 2012 03:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=zPCH5xwcJy9jJ24F/dgnV5R2oevZYz0CnxVJ4ylx/JU=;
        b=org9z1ehrbbfshjPvKbi/U7ihnBuBSDS2WvW//sc98j0LC9noQa7N0VYzr7985iq8g
         fxMOcxMBXOCPHaAQ+4yXixHYR0vKJyrQeipsmIz/4bqYynCg4cAJc8ybTEVmSAGUmkm8
         2kAplC2TS5Cs39CnOppy1Uo/cBIfI2KqZBiQc=
Received: by 10.52.66.44 with SMTP id c12mr791872vdt.19.1344682722593;
        Sat, 11 Aug 2012 03:58:42 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.52.100.72 with SMTP id ew8ls3865350vdb.9.gmail; Sat, 11 Aug
 2012 03:58:41 -0700 (PDT)
Received: by 10.58.249.242 with SMTP id yx18mr2201306vec.3.1344682721686;
        Sat, 11 Aug 2012 03:58:41 -0700 (PDT)
Received: by 10.58.249.242 with SMTP id yx18mr2201305vec.3.1344682721677;
        Sat, 11 Aug 2012 03:58:41 -0700 (PDT)
Received: from mail-vb0-f44.google.com (mail-vb0-f44.google.com [209.85.212.44])
        by gmr-mx.google.com with ESMTPS id t4si236630vds.3.2012.08.11.03.58.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Aug 2012 03:58:41 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.212.44 as permitted sender) client-ip=209.85.212.44;
Received: by vbbez10 with SMTP id ez10so2922035vbb.3
        for <msysgit@googlegroups.com>; Sat, 11 Aug 2012 03:58:41 -0700 (PDT)
Received: by 10.52.92.98 with SMTP id cl2mr4202358vdb.101.1344682721577; Sat,
 11 Aug 2012 03:58:41 -0700 (PDT)
Received: by 10.59.9.5 with HTTP; Sat, 11 Aug 2012 03:58:01 -0700 (PDT)
In-Reply-To: <1ca091b8-1c8e-419a-afbd-34f5aa3f1ac2@googlegroups.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.212.44 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203285>

On Sat, Aug 11, 2012 at 12:51 PM,  <bartoszrojek@gmail.com> wrote:
> Hi
>
> Why i cannot use git svn info outside of git folder ? This command miss an
> url/dir parameter. Can somebody add such function to this command ? It's for
> batch scripts etc
>

This isn't Windows specific, so this feature-request is more suited
for the main Git mailing list. Adding CC.

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

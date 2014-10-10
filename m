From: Duy Nguyen <pclouds@gmail.com>
Subject: msysgit works on wine
Date: Fri, 10 Oct 2014 18:58:48 +0700
Message-ID: <CACsJy8BAv9Bv_jFgW3L3+WYQMUOwRCFQ0sdAxWWwC_TnzesBBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBC2ZN5PHQUMBBFUU36QQKGQEI3XP3MY@googlegroups.com Fri Oct 10 13:59:26 2014
Return-path: <msysgit+bncBC2ZN5PHQUMBBFUU36QQKGQEI3XP3MY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qa0-f58.google.com ([209.85.216.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC2ZN5PHQUMBBFUU36QQKGQEI3XP3MY@googlegroups.com>)
	id 1XcYqu-0001ug-Hs
	for gcvm-msysgit@m.gmane.org; Fri, 10 Oct 2014 13:59:20 +0200
Received: by mail-qa0-f58.google.com with SMTP id dc16sf418015qab.13
        for <gcvm-msysgit@m.gmane.org>; Fri, 10 Oct 2014 04:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:date:message-id:subject:to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=r/bZnGeL0f/kd43GSzpbQmRN+CMvCTftzy4iq9UQQnE=;
        b=J7rhy9GI2U8qZx7SwJovB/seQL2kEk3K8HwiDvEsaWrP9Ru4jgTyJGHa87IxqNfHL0
         MoP/V9HFKvurt64xFVzMLsvJEQH10Itq/1Hg9cbolaUS8U0lB3WoBfT93SDevMpm9ZWj
         0iTA0V6dGcudn5iZiIpaHlKUZjIV5lUQVDrHCoFSPfdWFp79sUllPx8hkRmMDUMhDF5f
         olqTBYWRNpOkAQrvgDahrdsEAAPxqQQ5z5IYDRIlCHodHHgQCswqUn5YABePd/j537c2
         Se9FPIDSnMRsuNJRa71QrNtGx6OuDlcTnI5GptXEd+kODnoJFf928f/jjDsTxi5spFNC
         SqBQ==
X-Received: by 10.50.17.104 with SMTP id n8mr63161igd.12.1412942359011;
        Fri, 10 Oct 2014 04:59:19 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.111.131 with SMTP id ii3ls486118igb.32.canary; Fri, 10 Oct
 2014 04:59:18 -0700 (PDT)
X-Received: by 10.50.25.41 with SMTP id z9mr2830341igf.2.1412942358539;
        Fri, 10 Oct 2014 04:59:18 -0700 (PDT)
Received: from mail-ig0-x22c.google.com (mail-ig0-x22c.google.com [2607:f8b0:4001:c05::22c])
        by gmr-mx.google.com with ESMTPS id nt9si187099igb.1.2014.10.10.04.59.18
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 10 Oct 2014 04:59:18 -0700 (PDT)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 2607:f8b0:4001:c05::22c as permitted sender) client-ip=2607:f8b0:4001:c05::22c;
Received: by mail-ig0-x22c.google.com with SMTP id r2so2368647igi.5
        for <msysgit@googlegroups.com>; Fri, 10 Oct 2014 04:59:18 -0700 (PDT)
X-Received: by 10.50.43.233 with SMTP id z9mr5885384igl.41.1412942358449; Fri,
 10 Oct 2014 04:59:18 -0700 (PDT)
Received: by 10.107.131.1 with HTTP; Fri, 10 Oct 2014 04:58:48 -0700 (PDT)
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of pclouds@gmail.com designates 2607:f8b0:4001:c05::22c
 as permitted sender) smtp.mail=pclouds@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>

Just wanted to share that with at least wine 1.7.23 I can install
msysgit using the netboot method, clone and build git ok. I had to do
this to make gcc works actually, but it's probably no big deal

$ mkdir -p ~/.wine/drive_c/usr/libexec/gcc/mingw32 -p
$ cp ~/.wine/drive_c/msysgit/mingw/bin/as.exe
~/.wine/drive_c/usr/libexec/gcc/mingw32/
$ cp ~/.wine/drive_c/msysgit/mingw/bin/ld.exe
~/.wine/drive_c/usr/libexec/gcc/mingw32/

This may open a door for many people like me, who are interested in
Windows support, but don't own a Windows license (and probably don't
want to dual boot anyway). Of course tricky stuff would require real
Windows, but this would help with most "standard" windows stuff.
-- 
Duy

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

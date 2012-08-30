From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: relative objects/info/alternates doesn't work on remote
 SMB repo
Date: Thu, 30 Aug 2012 19:51:28 +0700
Message-ID: <CACsJy8BSpX7UxAEhZTqNnazAtSMp7oZtyxiBdnVoCXefWpTDEw@mail.gmail.com>
References: <CAGHpTBKNurqd0xcz9A9bC8MQU8yHfef0ozJ2Khr9uQvwHoyP2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Orgad and Raizel Shaneh <orgads@gmail.com>
X-From: msysgit+bncCLWW9eeFGBDzw_2BBRoEai3baA@googlegroups.com Thu Aug 30 14:52:08 2012
Return-path: <msysgit+bncCLWW9eeFGBDzw_2BBRoEai3baA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f58.google.com ([209.85.213.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCLWW9eeFGBDzw_2BBRoEai3baA@googlegroups.com>)
	id 1T74EA-0007Cs-1Y
	for gcvm-msysgit@m.gmane.org; Thu, 30 Aug 2012 14:52:06 +0200
Received: by yhmm54 with SMTP id m54sf1488744yhm.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 30 Aug 2012 05:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:from
         :date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=AP8VrW0OEDKRDImzO2qJ543Os0S3DuX/1E7UCkT1UzA=;
        b=EMDKPnjsTCMyjW2X93ZToUFNBTAWZytB1Wn6wdwp1S5JjKIk7pIgr2dpC0zsKr5jQC
         M5v3zU0WM2x+S/C50h9oQ39rdwAQnWewKhbv81IYuU0Up+OEDaxxIkLmuIcnHVZu+2tw
         ZZmACvnZw7JaaoEHwANukLjXbDpiCLq++l8Duh9FCQlsEsHxvh3sUdFpDDk8W8xvT+wn
         oP4nLhOe9YhlhzSMoXZEnkgRYrn7yCzH53zqbz7Sv95FN1xe0nF+8CHzuLfrJ1Yxku2K
         26RxeUGbbqBLrq+izy2b6hQ/SiNrUh3L9+8J9BqZtavdMlgHvarKg0VNzzME7vxUrzMk
         9s5Q==
Received: by 10.236.186.34 with SMTP id v22mr482373yhm.9.1346331123351;
        Thu, 30 Aug 2012 05:52:03 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.236.154.170 with SMTP id h30ls3418448yhk.7.gmail; Thu, 30 Aug
 2012 05:52:02 -0700 (PDT)
Received: by 10.236.175.233 with SMTP id z69mr3411462yhl.26.1346331122097;
        Thu, 30 Aug 2012 05:52:02 -0700 (PDT)
Received: by 10.236.175.233 with SMTP id z69mr3411459yhl.26.1346331122085;
        Thu, 30 Aug 2012 05:52:02 -0700 (PDT)
Received: from mail-iy0-f178.google.com (mail-iy0-f178.google.com [209.85.210.178])
        by gmr-mx.google.com with ESMTPS id c61si451178yhm.3.2012.08.30.05.52.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 30 Aug 2012 05:52:02 -0700 (PDT)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 209.85.210.178 as permitted sender) client-ip=209.85.210.178;
Received: by iaeh11 with SMTP id h11so3836275iae.23
        for <msysgit@googlegroups.com>; Thu, 30 Aug 2012 05:52:01 -0700 (PDT)
Received: by 10.50.149.202 with SMTP id uc10mr338040igb.2.1346331121502; Thu,
 30 Aug 2012 05:52:01 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Thu, 30 Aug 2012 05:51:28 -0700 (PDT)
In-Reply-To: <CAGHpTBKNurqd0xcz9A9bC8MQU8yHfef0ozJ2Khr9uQvwHoyP2g@mail.gmail.com>
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of pclouds@gmail.com designates 209.85.210.178 as permitted sender)
 smtp.mail=pclouds@gmail.com; dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204532>

On Wed, Aug 29, 2012 at 1:43 PM, Orgad and Raizel Shaneh
<orgads@gmail.com> wrote:
> Hi,
>
> I have a repo accessed through //server/share/foo/repo (Using msysgit).
>
> .git/objects/info/alternates contains '../../../bare/objects'
>
> Running 'git status' (or almost any other action) gives the following output:
> error: object directory /server/share/foo/bare/objects does not exist;
> check .git/objects/info/alternates.
>
> Note that it tries to access /server instead of //server.

Could be path normalization. What does "git rev-parse --git-dir" say?
Try to run it at top working directory and a subdirectory as well.

If you set GIT_OBJECT_DIRECTORY environment variable to
//server/share/foo/repo/.git/objects, does it work?
-- 
Duy

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

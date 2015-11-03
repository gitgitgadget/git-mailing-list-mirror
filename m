From: MH <mkckkcm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Automatic download at git-scm.com does not work (Was: 
 Cant download Git)
Date: Tue, 3 Nov 2015 08:15:26 -0500
Message-ID: <78A16E16-9FD7-4290-B365-8BE6F3B409D2@gmail.com>
References: <025c4d3a-f018-4e13-9fc8-7649460662cd@googlegroups.com> <20151103161428.a6be2380032c2d07c1769507@domain007.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=UTF-8
Cc: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,
 git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Konstantin Khomoutov <kostix+git-I8vNd4LC5SeHXe+LvDLADg@public.gmane.org>
X-From: git-users+bncBCEMB4M6YEGBB4HG4KYQKGQEUW3KOUY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Tue Nov 03 14:15:33 2015
Return-path: <git-users+bncBCEMB4M6YEGBB4HG4KYQKGQEUW3KOUY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-qg0-f58.google.com ([209.85.192.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBCEMB4M6YEGBB4HG4KYQKGQEUW3KOUY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1ZtbQw-0004f7-W8
	for gcggu-git-users@m.gmane.org; Tue, 03 Nov 2015 14:15:31 +0100
Received: by qgbb65 with SMTP id b65sf3483784qgb.1
        for <gcggu-git-users@m.gmane.org>; Tue, 03 Nov 2015 05:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :message-id:references:to:x-original-sender
         :x-original-authentication-results:reply-to:precedence:mailing-list
         :list-id:x-spam-checked-in-group:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe;
        bh=WxnO5qlIv1D0n2h0oNXeWlj47e7Hi5FRXeNrOZl1X4A=;
        b=dOVgP6Sd8JqhEs0L/yv7mOy9Xh6HSV9P128qwpfPhMcBgWCn1CbGge/909v/PSR3L5
         lpRl3DZOTBzsVOBfbHh4stB7PGwirv2kVhJA/WJYzEVcQxfKdYQjYQ1wi558DJmQBVGL
         +4KtOVMEc5ReCX/0BC3fsxpGpQ7vD4Ixpy+OpFkv5S5P/XxbwT8ndeT2Hk3Odh5jUJsG
         zJrbFLRCbGgEdxDRbEWSDb5a2HNxQOR/3mXMnmcob0Rqb388CMk2vA3qVk54PnWIoeTV
         5HwA1/Nm7Gk3/VdbwDT3fgCzvqgdSNty1HnOP7gkDhqj6rACb8+Q/DlQ3MvF2F9Q3d/8
         77mg==
X-Received: by 10.50.6.40 with SMTP id x8mr322878igx.0.1446556530358;
        Tue, 03 Nov 2015 05:15:30 -0800 (PST)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.107.154.2 with SMTP id c2ls85434ioe.64.gmail; Tue, 03 Nov 2015
 05:15:28 -0800 (PST)
X-Received: by 10.66.161.104 with SMTP id xr8mr22691413pab.26.1446556528274;
        Tue, 03 Nov 2015 05:15:28 -0800 (PST)
Received: from mail-qg0-x22f.google.com (mail-qg0-x22f.google.com. [2607:f8b0:400d:c04::22f])
        by gmr-mx.google.com with ESMTPS id b9si255601ywc.2.2015.11.03.05.15.28
        for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2015 05:15:28 -0800 (PST)
Received-SPF: pass (google.com: domain of mkckkcm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 2607:f8b0:400d:c04::22f as permitted sender) client-ip=2607:f8b0:400d:c04::22f;
Received: by mail-qg0-x22f.google.com with SMTP id m9so11837665qge.1
        for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Tue, 03 Nov 2015 05:15:28 -0800 (PST)
X-Received: by 10.141.1.6 with SMTP id c6mr12012359qhd.9.1446556528123;
        Tue, 03 Nov 2015 05:15:28 -0800 (PST)
Received: from [192.168.0.13] (c-71-192-28-88.hsd1.ma.comcast.net. [71.192.28.88])
        by smtp.gmail.com with ESMTPSA id d65sm9596195qhc.36.2015.11.03.05.15.27
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 03 Nov 2015 05:15:27 -0800 (PST)
In-Reply-To: <20151103161428.a6be2380032c2d07c1769507-g5ZlayWIM10NZ+ppGFcyYQ@public.gmane.org>
X-Mailer: Apple Mail (2.3096.5)
X-Original-Sender: mkckkcm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of mkckkcm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 2607:f8b0:400d:c04::22f
 as permitted sender) smtp.mailfrom=mkckkcm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;       dmarc=pass
 (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact git-users+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <git-users.googlegroups.com>
X-Spam-Checked-In-Group: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
X-Google-Group-Id: 934228491576
List-Post: <http://groups.google.com/group/git-users/post>, <mailto:git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:git-users+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/git-users
Sender: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/git-users/subscribe>, <mailto:git-users+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+934228491576+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/git-users/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280795>


> On Nov 3, 2015, at 8:14 AM, Konstantin Khomoutov <kostix+git-I8vNd4LC5SeHXe+LvDLADg@public.gmane.org> wrote:
> 
> On Tue, 3 Nov 2015 04:55:22 -0800 (PST)
> M Hendrickson <mkckkcm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 
>> I am trying to download Git. When I click download for Mac OS X it
>> says "download starting" but the download doesn't start.
>> 
>> There is a manual download option from sourceforge. But some have
>> warned me that downloading from sourceforge often contains unwanted
>> things included in the download.
> 
> That was a blunder of the (recent) past so I'd say it's OK to download
> directly from SF.  Note that the Mac OS X build accessible from
> git-scm.com, while being "officially blessed" is not prepared by the
> upstream Git developers (as they only distribute the source code) but
> rather this is a port coordinated there at that SF project you referred
> to.
> 
> Well, I've just verified that what would be automacitally downloaded
> has the same URL as that "download manually" link.
> So you should be fine with the manual download.
> 
>> Does anyone know why the download from git-scm.com is not working?

-- 
You received this message because you are subscribed to the Google Groups "Git for human beings" group.
To unsubscribe from this group and stop receiving emails from it, send an email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

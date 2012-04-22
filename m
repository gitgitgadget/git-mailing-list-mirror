From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: Git push stuck
Date: Sat, 21 Apr 2012 23:07:13 -0400
Message-ID: <CAAfQ0EGcFC6TYYrYNvuiJsLw8twKxHmwpwFp+hxQg2iESsbYFQ@mail.gmail.com>
References: <4F929200.4010406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: hen vertis <henvertis@gmail.com>
X-From: msysgit+bncCLn04amjAxDi6838BBoEN19Gcw@googlegroups.com Sun Apr 22 05:07:19 2012
Return-path: <msysgit+bncCLn04amjAxDi6838BBoEN19Gcw@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lpp01m010-f58.google.com ([209.85.215.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCLn04amjAxDi6838BBoEN19Gcw@googlegroups.com>)
	id 1SLn8t-0002rx-Fp
	for gcvm-msysgit@m.gmane.org; Sun, 22 Apr 2012 05:07:15 +0200
Received: by lamb11 with SMTP id b11sf6662088lam.3
        for <gcvm-msysgit@m.gmane.org>; Sat, 21 Apr 2012 20:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:sender:in-reply-to:references
         :date:message-id:subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:list-subscribe
         :list-unsubscribe:content-type;
        bh=H5wyb0vXoBgJ5D4/zxp0OL0W2mmIWBt+/crqkjwGu/k=;
        b=nyucFoclHhun/AB2sensdAVXxKUBxlCio3AQzckGcPXJ7FniXy9zYyp+SHsSjIceLH
         8B7d8LQNzGnNMlPZcaOYSmdUmlEa2Xu6M+NeE4479ZtVha8GGWuI+FwIo63OoLDwnp7k
         b3lju/+kReTkiOF7jOs6zxOO/J5H2NtQaw0DA=
Received: by 10.204.154.67 with SMTP id n3mr744520bkw.2.1335064034921;
        Sat, 21 Apr 2012 20:07:14 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.130.2 with SMTP id q2ls4624460bks.9.gmail; Sat, 21 Apr
 2012 20:07:13 -0700 (PDT)
Received: by 10.204.129.15 with SMTP id m15mr1219967bks.2.1335064033719;
        Sat, 21 Apr 2012 20:07:13 -0700 (PDT)
Received: by 10.204.129.15 with SMTP id m15mr1219966bks.2.1335064033705;
        Sat, 21 Apr 2012 20:07:13 -0700 (PDT)
Received: from mail-lb0-f174.google.com (mail-lb0-f174.google.com [209.85.217.174])
        by gmr-mx.google.com with ESMTPS id il15si2527458bkc.2.2012.04.21.20.07.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 21 Apr 2012 20:07:13 -0700 (PDT)
Received-SPF: pass (google.com: domain of peter.is.a.geek@gmail.com designates 209.85.217.174 as permitted sender) client-ip=209.85.217.174;
Received: by lbom4 with SMTP id m4so5439452lbo.5
        for <msysgit@googlegroups.com>; Sat, 21 Apr 2012 20:07:13 -0700 (PDT)
Received: by 10.152.123.229 with SMTP id md5mr8759677lab.34.1335064033264;
 Sat, 21 Apr 2012 20:07:13 -0700 (PDT)
Sender: msysgit@googlegroups.com
Received: by 10.112.103.106 with HTTP; Sat, 21 Apr 2012 20:07:13 -0700 (PDT)
In-Reply-To: <4F929200.4010406@gmail.com>
X-Original-Sender: peterisageek@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of peter.is.a.geek@gmail.com designates 209.85.217.174 as permitted
 sender) smtp.mail=peter.is.a.geek@gmail.com; dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196070>

On Sat, Apr 21, 2012 at 6:54 AM, hen vertis wrote:
> hi
> i working with git version 1.7.10.msysgit.1 on windows 7.
> my repository is on Ubuntu.
> i can make fetch and merge.
> but when i trying to push is not working.
> any idea will be welcomed.

This is a known issue with the implementation of the sideband 64k
feature when pushing using the bare git protocol. Nobody has been able
to adequately explain exactly what the problem is, so there hasn't
been a satisfactory patch yet. Windows appears to prevent writes to a
socket-backed file descriptor while another process is doing a
blocking read (or even a select). Perhaps it's a bug in Windows file
descriptor emulation layer, or perhaps its a bug in msysgit. More
eyes, and especially patches, are welcome.

Known workarounds include patching out sideband 64k, or using ssh
instead of the bare git protocol. More security/encryption is a good
thing, so I started using ssh.

CCing the msysgit mailing list, in case there have been recent
developments that I've missed.

Peter Harris

-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***

*** Please avoid top-posting. ***

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

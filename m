From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2] contrib: add win32 credential-helper
Date: Mon, 23 Apr 2012 18:05:57 +0200
Message-ID: <CABPQNSawsoheM6Qoxs-iQ-KYxYFs-s60oFLzdyRDFT0o=KXt1w@mail.gmail.com>
References: <1334861122-3144-1-git-send-email-kusmabite@gmail.com> <20120422180716.GA27339@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Jeff King <peff@peff.net>
X-From: msysgit+bncCOPdven-DxCQ_NX8BBoECDu7Ig@googlegroups.com Mon Apr 23 18:06:42 2012
Return-path: <msysgit+bncCOPdven-DxCQ_NX8BBoECDu7Ig@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f186.google.com ([209.85.216.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxCQ_NX8BBoECDu7Ig@googlegroups.com>)
	id 1SMLmj-0002E0-9G
	for gcvm-msysgit@m.gmane.org; Mon, 23 Apr 2012 18:06:41 +0200
Received: by qcsc2 with SMTP id c2sf12501664qcs.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 23 Apr 2012 09:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=dNOBo9h/anp4W+3BBLmjLhffh7vRdaPFy8+GYCQt4ic=;
        b=ctuezMyNpdRdraxHNnq2MliM3uvOUYvvzRicaokw2cstmNpEZRPU66MRf/EIe1Kr4u
         pVPgD9MCjTb1P6otlYjuxC5PHPgbZcJpJ0JOlBT+ebvhVUZjLLn8fMQzefWTIXqpUQyL
         pdEm5Q+udwks0uOycFBweyhB9SXXZkfemQ/IY=
Received: by 10.52.68.206 with SMTP id y14mr1465976vdt.1.1335197200296;
        Mon, 23 Apr 2012 09:06:40 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.52.185.71 with SMTP id fa7ls3647887vdc.5.gmail; Mon, 23 Apr
 2012 09:06:39 -0700 (PDT)
Received: by 10.52.88.201 with SMTP id bi9mr3567918vdb.6.1335197199356;
        Mon, 23 Apr 2012 09:06:39 -0700 (PDT)
Received: by 10.52.88.201 with SMTP id bi9mr3567916vdb.6.1335197199348;
        Mon, 23 Apr 2012 09:06:39 -0700 (PDT)
Received: from mail-vx0-f169.google.com (mail-vx0-f169.google.com [209.85.220.169])
        by gmr-mx.google.com with ESMTPS id cl2si8262789vdc.3.2012.04.23.09.06.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Apr 2012 09:06:39 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.220.169 as permitted sender) client-ip=209.85.220.169;
Received: by vcbfy7 with SMTP id fy7so4258355vcb.14
        for <msysgit@googlegroups.com>; Mon, 23 Apr 2012 09:06:39 -0700 (PDT)
Received: by 10.220.147.198 with SMTP id m6mr5753668vcv.49.1335197199060; Mon,
 23 Apr 2012 09:06:39 -0700 (PDT)
Received: by 10.220.192.8 with HTTP; Mon, 23 Apr 2012 09:05:57 -0700 (PDT)
In-Reply-To: <20120422180716.GA27339@sigill.intra.peff.net>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.220.169 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196135>

On Sun, Apr 22, 2012 at 8:07 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 19, 2012 at 08:45:22PM +0200, Erik Faye-Lund wrote:
>
>> Here's an updated version of my Windows credential-helper.
>
> Sorry, I've been traveling and haven't had a chance to look at this
> in-depth yet. I'll do so next week. In the meantime, I wanted to point
> out this similar project:
>
> =A0https://github.com/anurse/git-credential-winstore
>
> which somebody else pointed me to a few days ago. I don't know yet if
> your approaches are the same, or if it would be worth combining efforts
> or not.

Yeah, I saw that one a couple of days ago myself.

They use the same credential store, and I actually tried to make sure
they can use the same data.

But apart from that, they work quite differently. My credential-helper
only does storage, and passes the test-suite. The one you linked to
seems to ignore any password being sent to it, and instead prompts the
user if it doesn't already have a credential. It also does not seem to
support storing credentials for multiple users for a domain/path.

But probably the biggest problem for Git for Windows is that it's
written in C#, and we don't have a C# compiler in our tool-chain.

So I don't think there's much I can use from that helper, and I think
my helper is in a healthier state. But I'm obviously biased.

--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***

*** Please avoid top-posting. ***

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

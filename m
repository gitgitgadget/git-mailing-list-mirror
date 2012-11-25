From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Re: Python extension commands in git - request for
 policy change
Date: Sun, 25 Nov 2012 16:51:39 +0100
Message-ID: <CABPQNSY+Tnij4+_uZq3zwmgVjtUGsYpB7miJgf8meUWMCArNMg@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com> <CACsJy8BbUjrJtfpEvbcK==Y2gFNsFhFBN93CL36J5uVe=Ca4wQ@mail.gmail.com>
 <CABNJ2G+CevGU=-DjC073yGv0gupd9QK6eyjhrrQTNNmTkq_fxg@mail.gmail.com> <20121125103316.GA24514@thyrsus.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Pat Thoyts <patthoyts@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org, 
	msysGit <msysgit@googlegroups.com>
To: esr@thyrsus.com
X-From: msysgit+bncBDR53PPJ7YHRBNP5ZCCQKGQET5SO6FI@googlegroups.com Sun Nov 25 16:52:36 2012
Return-path: <msysgit+bncBDR53PPJ7YHRBNP5ZCCQKGQET5SO6FI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ia0-f186.google.com ([209.85.210.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBNP5ZCCQKGQET5SO6FI@googlegroups.com>)
	id 1TceVW-0000Ch-9G
	for gcvm-msysgit@m.gmane.org; Sun, 25 Nov 2012 16:52:34 +0100
Received: by mail-ia0-f186.google.com with SMTP id y25sf7305507iay.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 25 Nov 2012 07:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=GoGGiM+d1of+7FZyeCiVgBbE+gLtceUSs7e5DYV8ndM=;
        b=r07RDv2SaAXKCejtrpQswyHofL2RNht2Gr9npB4phHLbmXZcvKihUD+l1Jj6zs2isB
         Iv8r+UVURNOZdoYnseF9Zl64KEehsTBzy1Pzi/+zLyPQS5uou8IppzLMSePpFvD8Sdf2
         M1WfM5nFwMbY7PVUyb77OR80Nqw8MXN7x7pUsysFg4tdthbphZOfOyFZaJJD37uGAirc
         Pa6z/xrHvc2qE2l91S0a3UMGihU20FVywoBGncUPC+8aCiI37Bowt60T+uehs7D5LcRU
         DUlyFtgVIIkDZeDLSEDzVK1IE43qJ/tiAS7w3c8LMXEXWmRIWZX28Q7f5W563zSsauHg
         Gpdw==
Received: by 10.49.37.105 with SMTP id x9mr1729742qej.26.1353858742590;
        Sun, 25 Nov 2012 07:52:22 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.94.201 with SMTP id de9ls1343106qeb.5.gmail; Sun, 25 Nov
 2012 07:52:21 -0800 (PST)
Received: by 10.58.170.6 with SMTP id ai6mr2760927vec.35.1353858741335;
        Sun, 25 Nov 2012 07:52:21 -0800 (PST)
Received: by 10.58.170.6 with SMTP id ai6mr2760925vec.35.1353858741323;
        Sun, 25 Nov 2012 07:52:21 -0800 (PST)
Received: from mail-vc0-f172.google.com (mail-vc0-f172.google.com [209.85.220.172])
        by gmr-mx.google.com with ESMTPS id dj17si876224vdb.1.2012.11.25.07.52.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Nov 2012 07:52:21 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.220.172 as permitted sender) client-ip=209.85.220.172;
Received: by mail-vc0-f172.google.com with SMTP id fw7so9204203vcb.31
        for <msysgit@googlegroups.com>; Sun, 25 Nov 2012 07:52:21 -0800 (PST)
Received: by 10.52.38.34 with SMTP id d2mr13512397vdk.63.1353858741231; Sun,
 25 Nov 2012 07:52:21 -0800 (PST)
Received: by 10.58.169.106 with HTTP; Sun, 25 Nov 2012 07:51:39 -0800 (PST)
In-Reply-To: <20121125103316.GA24514@thyrsus.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.220.172 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210371>

On Sun, Nov 25, 2012 at 11:33 AM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Pat Thoyts <patthoyts@gmail.com>:
>> Git for Windows simply ships everything we need to run git - so if a
>> desirable module requires a version of python, we will add that
>> version plus any required modules into the installer. We already have
>> a patch to provide python in the msysgit tree - it would just require
>> polishing up a little. I'm certain this is no problem for the other
>> windows port (cygwin) either.
>
> Thank you - I think this completely disposes of the "Windows is a blocker
> for scripting language X" argument, with the case X = Python in point.

As the one who wrote that patch; not at all. That patch is a horrible
mess, and it is not yet proven that the resulting python executable
works any more than a basic hello world.

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

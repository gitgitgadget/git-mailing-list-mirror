From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Re: t0008-ignores failure
Date: Thu, 30 May 2013 08:58:17 +0200
Message-ID: <51A6F889.9030205@kdbg.org>
References: <CABNJ2G+u96P+_=Q7it0KbK9E01qunz7XZ7e3zCZvaTaOUuTQqQ@mail.gmail.com> <51A6A7B7.4010802@gmail.com> <7vzjvdp5q8.fsf@alter.siamese.dyndns.org> <20130530025258.GB19860@sigill.intra.peff.net> <20130530025554.GC19860@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karsten Blees <karsten.blees@gmail.com>,
 Pat Thoyts <patthoyts@gmail.com>, msysGit <msysgit@googlegroups.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Sebastian Schuberth <sschuberth@gmail.com>, 
 Git List <git@vger.kernel.org>,
 Adam Spiers <git@adamspiers.org>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCJYV6HBKQII34M3RUCRUBD3YK5VK@googlegroups.com Thu May 30 08:58:23 2013
Return-path: <msysgit+bncBCJYV6HBKQII34M3RUCRUBD3YK5VK@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f61.google.com ([209.85.215.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQII34M3RUCRUBD3YK5VK@googlegroups.com>)
	id 1UhwoY-0001x8-2L
	for gcvm-msysgit@m.gmane.org; Thu, 30 May 2013 08:58:22 +0200
Received: by mail-la0-f61.google.com with SMTP id eb20sf1770685lab.16
        for <gcvm-msysgit@m.gmane.org>; Wed, 29 May 2013 23:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=CmSWlRfi2xPAPv5Ezg50wCQ2CJJX8InD+ii2poOG1mo=;
        b=oQUuxJLx+yYiIHl7HxxafrPqpsjwIl6jcU2oJFGJHkQg19IlNakrHIMOybOqXyIgn7
         iDIpC0M2KkngHORgij4zkZj+0dAa4E5YN+ENYxZOKo8WFPReO4kNMDFUYWf1TCgcxv6n
         D/RFy4HNv6FHXtF5RTCJ5fFMS5GLnBcJFOq7gUriNm5AD6PEsFYyZuoURCE1Bf7hAMUh
         bUxwnbINm9WbfIjA8NVoTfsq7OAdfYPxcujTYvAV4FwG/KDHMOeGU5nrGbpm9k8ukbbb
         gCUPJ+iPz5sY7d6zfS/5XIR/bec4M104enN9AKaZJe1Y5XmeCt3YjvqKjE0x2JzxZ5px
         /1iw==
X-Received: by 10.180.102.194 with SMTP id fq2mr1901731wib.15.1369897101637;
        Wed, 29 May 2013 23:58:21 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.182.3 with SMTP id ea3ls163848wic.36.gmail; Wed, 29 May
 2013 23:58:20 -0700 (PDT)
X-Received: by 10.14.95.130 with SMTP id p2mr7559372eef.6.1369897100220;
        Wed, 29 May 2013 23:58:20 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp1.bon.at. [213.33.87.15])
        by gmr-mx.google.com with ESMTPS id o5si9607415eew.0.2013.05.29.23.58.20
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 29 May 2013 23:58:20 -0700 (PDT)
Received-SPF: neutral (google.com: 213.33.87.15 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=213.33.87.15;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 8B55D13004B;
	Thu, 30 May 2013 08:57:40 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 170B519F5DE;
	Thu, 30 May 2013 08:58:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130530025554.GC19860@sigill.intra.peff.net>
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 213.33.87.15 is neither permitted nor denied by best guess
 record for domain of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225935>

Am 30.05.2013 04:55, schrieb Jeff King:
> So while it would be nice to work on paths with colons everywhere, I
> doubt it is worth the effort to start checking it through the whole test
> suite.

And on top of it, on Windows, you can't have a path component or file
name that contains a colon...

-- Hannes

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

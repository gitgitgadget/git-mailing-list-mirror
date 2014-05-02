From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Re: #178 parsing of pretty=format:"%an %ad" causes
 fatal: bad revision '%ad'
Date: Fri, 2 May 2014 20:23:56 +0200
Message-ID: <CABPQNSYTWYwSgd=sa0QGmaFDuzprLzLNYmQEx-6MrZ_HEZimww@mail.gmail.com>
References: <BLU0-SMTP1116609FAC7E0C76123F929F430@phx.gbl> <20140502172358.GI9218@google.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dave Bradley <dbradley2@bell.net>, GIT Mailing-list <git@vger.kernel.org>, 
	msysGit <msysgit@googlegroups.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: msysgit+bncBDR53PPJ7YHRBZGFR6NQKGQEXUSCHMY@googlegroups.com Fri May 02 20:24:38 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBZGFR6NQKGQEXUSCHMY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yk0-f192.google.com ([209.85.160.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBZGFR6NQKGQEXUSCHMY@googlegroups.com>)
	id 1WgI8T-0006Oy-OE
	for gcvm-msysgit@m.gmane.org; Fri, 02 May 2014 20:24:37 +0200
Received: by mail-yk0-f192.google.com with SMTP id 20sf101006yks.9
        for <gcvm-msysgit@m.gmane.org>; Fri, 02 May 2014 11:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=tSzH428PN7yfIZgU3UsKWKmMTEsx+HiaxTj+2ljPGDM=;
        b=CsWapi9pW7ctFDrZctKZRYSUj3BTQ05+x4A/fX+yJQdtB5ZqVL+RWUF8QHNsXL9m+m
         o9N5W99S/u5VmECO53gYKe/ixJQXvHhshpjTLJN/yfRhzyHSQ3UZW3O2i9czUwuQbac7
         KP7GIhuUS+ltMOiKatWuOfmXZoydVv/CKQWwrL0ql/1zrCcpP9toS5PdDO93tJ0HNdzu
         NX6+4sWsvAzfM1a5SaWAn6rmU+d1DuhJc6ey0g0qMZnGNp/vlsBs9UOOOW2q29AXRozy
         7nauKwU5doRPcNqwrILuN+e8zEQeX//CPWMLD/2I4UPKVYOuXiwClIRK+VJexSwx7Y3v
         0UeA==
X-Received: by 10.50.79.137 with SMTP id j9mr120690igx.15.1399055076963;
        Fri, 02 May 2014 11:24:36 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.124.42 with SMTP id mf10ls360209igb.15.canary; Fri, 02 May
 2014 11:24:36 -0700 (PDT)
X-Received: by 10.66.66.35 with SMTP id c3mr9632796pat.7.1399055076169;
        Fri, 02 May 2014 11:24:36 -0700 (PDT)
Received: from mail-ie0-x235.google.com (mail-ie0-x235.google.com [2607:f8b0:4001:c03::235])
        by gmr-mx.google.com with ESMTPS id f5si221288igh.3.2014.05.02.11.24.36
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 02 May 2014 11:24:36 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::235 as permitted sender) client-ip=2607:f8b0:4001:c03::235;
Received: by mail-ie0-f181.google.com with SMTP id y20so5461219ier.40
        for <msysgit@googlegroups.com>; Fri, 02 May 2014 11:24:36 -0700 (PDT)
X-Received: by 10.50.30.6 with SMTP id o6mr6537716igh.43.1399055076046; Fri,
 02 May 2014 11:24:36 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Fri, 2 May 2014 11:23:56 -0700 (PDT)
In-Reply-To: <20140502172358.GI9218@google.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::235
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247950>

On Fri, May 2, 2014 at 7:23 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> (resending with the correct address for the Git for Windows developers.
> Sorry for the noise.)
> Hi Dave,
>
> Dave Bradley wrote:
>
>> G:\ws_test_env\GIT_TESTBED_TMP\fest-swing-1.x>git log --all --pretty=format:"%an %ad" -- pom.xml
>> xxxx xxxx Mon Nov 23 03:09:17 2009 +0000
>> xxxx xxxx Mon Nov 23 02:42:24 2009 +0000
>>
>> G:\ws_test_env\GIT_TESTBED_TMP\fest-swing-1.x>git log --all "--pretty=format:"%an %ad"" -- pom.xml
>> fatal: bad revision '%ad'
>
> On Linux, this example gets passed to git as six arguments:
>
>         log
>         --all
>         --pretty=format:%an
>         %ad
>         --
>         pom.xml
>

As does it on Windows.

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
For more options, visit https://groups.google.com/d/optout.

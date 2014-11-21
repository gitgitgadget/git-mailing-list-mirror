From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC 0/4] Fix the Visual Studio 2008 .sln generator
Date: Fri, 21 Nov 2014 20:22:55 -0000
Organization: OPDS
Message-ID: <7E90FA1615514FA1B47B268DCBCA9534@PhilipOakley>
References: <1416526682-6024-1-git-send-email-philipoakley@iee.org> <alpine.DEB.1.00.1411211032060.13845@s15462909.onlinehome-server.info>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=UTF-8; reply-type=original
Cc: "GitList" <git@vger.kernel.org>,
	"Marius Storm-Olsen" <mstormo@gmail.com>,
	"Ramsay Jones" <ramsay@ramsay1.demon.co.uk>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	"Michael Wookey" <michaelwookey@gmail.com>,
	"Msysgit" <msysgit@googlegroups.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBDSOTWHYX4PBBZN5X2RQKGQEAALMAQA@googlegroups.com Fri Nov 21 21:22:01 2014
Return-path: <msysgit+bncBDSOTWHYX4PBBZN5X2RQKGQEAALMAQA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f56.google.com ([74.125.83.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBZN5X2RQKGQEAALMAQA@googlegroups.com>)
	id 1XruiM-00074s-6j
	for gcvm-msysgit@m.gmane.org; Fri, 21 Nov 2014 21:21:58 +0100
Received: by mail-ee0-f56.google.com with SMTP id c41sf562584eek.21
        for <gcvm-msysgit@m.gmane.org>; Fri, 21 Nov 2014 12:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:reply-to:from:to:cc:references:subject:date:organization
         :mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=CIcGxssbakwH+ro+jj0USQvtX2QNqZFEssd7F38J2tU=;
        b=fEt7JUp6ZelAcN5Ma66a0tH91Uf8iCUcCFnLMNsayLDhiCLATX/AnNBryHwZqv25qw
         wlWFfHL5hO2k373iplEhg2v6w/tpSXK6MV8p1FLc0D4s+c9oeG56h/VWGtkrrU/Wasm2
         YoW9wZkuXTno/squwXezdJ9zgvEv+rX5y951KYf+cfKRwwso+2tE1W56afWYJmz8Wm4w
         xV18+SN1Jw5iS5Qpyy75jvazLfDeQNo9Ow87F/q2Re+mcZsITvJ04bnQqoP+wNX8tp0O
         bNT/LASzzCU7CXGPxykyowb0GZKta7sGOZhQBT0MWPzSr7WDyxKU/Eln615fCd0xRMDs
         8vcw==
X-Received: by 10.181.27.135 with SMTP id jg7mr1208wid.1.1416601317966;
        Fri, 21 Nov 2014 12:21:57 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.181.29.33 with SMTP id jt1ls21319wid.45.canary; Fri, 21 Nov
 2014 12:21:57 -0800 (PST)
X-Received: by 10.180.75.78 with SMTP id a14mr49429wiw.0.1416601317088;
        Fri, 21 Nov 2014 12:21:57 -0800 (PST)
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net. [62.24.128.238])
        by gmr-mx.google.com with ESMTP id p14si22996wie.1.2014.11.21.12.21.56
        for <msysgit@googlegroups.com>;
        Fri, 21 Nov 2014 12:21:57 -0800 (PST)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.238 as permitted sender) client-ip=62.24.128.238;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApYQADueb1RZ8YpUPGdsb2JhbABcgw5VWYgNw2YfCoZlAQMBAYEHFwEBAQEBAQUBAQEBODuDfQUBAQEBAgEIAQEuFggBASEFBgIDBQIBAxUDCSUUAQQYAgYHAwYOBggLCAIBAgMBDASICwMJDQm9V5AUAQsBH4pxg10dgiCDNoEfBYtohnxrg3qIZT+DGpYDSDABgkoBAQE
X-IPAS-Result: ApYQADueb1RZ8YpUPGdsb2JhbABcgw5VWYgNw2YfCoZlAQMBAYEHFwEBAQEBAQUBAQEBODuDfQUBAQEBAgEIAQEuFggBASEFBgIDBQIBAxUDCSUUAQQYAgYHAwYOBggLCAIBAgMBDASICwMJDQm9V5AUAQsBH4pxg10dgiCDNoEfBYtohnxrg3qIZT+DGpYDSDABgkoBAQE
X-IronPort-AV: E=Sophos;i="5.07,432,1413241200"; 
   d="scan'208";a="16965562"
Received: from host-89-241-138-84.as13285.net (HELO PhilipOakley) ([89.241.138.84])
  by out1.ip02ir2.opaltelecom.net with SMTP; 21 Nov 2014 20:21:56 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.238 as permitted sender) smtp.mail=philipoakley@iee.org
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

From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
> Hi Philip,
>
> On Thu, 20 Nov 2014, Philip Oakley wrote:
>
>> Are the patches going in the right direction?
>
> Yes.
Magic. Glad of the confirmation
>
> A couple of general comments:
>
> - please do not comment out code. Just remove it.
It's my debugging style until I get it working ;-0
>
> - the first three commit messages look funny, being indented by 4
>  spaces... unintentional?
I think that was from one of the tools I was using at the time. They'll 
be tidied and reflowed for the final version(s).
>
>> Is the processing of the .obj file in engine.pl sensible?
>
> Yes, but instead of adding dead code, it would be better to use the
> comment "# ignore". I would also strongly suggest to hard-code the
> complete file name instead of just the extension.
True, I realised that after posting (isnt it always the way).

> We know exactly which
> file name we want to ignore, and if there should be another .obj file
> eventually, it would be wrong to ignore it, too.

My concern was more about why a 'make' would produce .obj files (rather 
than .o files) in the first place. As I understand it we should never 
see .obj files generated from make with the exception of these ones that 
are library files implicitly known to MSVC - any thoughts?

>
>> and the extra care with s/\.o$/.c/ avoiding s/obj/cbj/.
>
> Technically, you need to use a group \($\|[ \t]\), but I think that 
> that
> would be overkill.
>
>> Does it affect the Qmake capability? (I've no idea)
>
> Frankly, neither do I ;-) But since you touched only engine.pl, I 
> would
> expect Qmake not to be affected at all, right?

As I understood the call sequence merry go round, the engine can pull in 
either function depending on command line options, hence the open 
question. But like you say, why expect it to be affected, and no-one has 
mentioned on list for years;-)

>
>> Is the quoting of filenames correct? (my perl foo is cargo cult!)
>
> IANAPME (I am not a Perl Monk either), but it looks good to me.
OK.
>
>> I've also updated the vcbuild/README to mention Msysgit (which
>> will be replaced soon by the newer/better Git-for-windows/SDK
>> (https://github.com/git-for-windows/sdk), but the benefits still
>> apply.
>
> The path you used is /msysgit/bin/msvc-build, but the real path would 
> be
> /bin/msvc-build.
>
>> Obviously, the patches will need squashing together,
>
> To the contrary, I like the current separation of concerns.
At the moment the first patch doesn't fully cure the .sln build, but 
there's no test anyway so bisecting would be problematic.

I'm happy to keep them small separate and clean ;-)

>
> Ciao,
> Johannes
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

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

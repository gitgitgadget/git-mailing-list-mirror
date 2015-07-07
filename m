From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Re: [PATCH 13/17] engine.pl: provide more debug print statements
Date: Tue, 7 Jul 2015 23:18:54 +0100
Organization: OPDS
Message-ID: <A555E0A67C1549A49531AD2A94879999@PhilipOakley>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org> <1435190633-2208-14-git-send-email-philipoakley@iee.org> <5591B845.8050201@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=UTF-8; reply-type=original
Cc: "Git List" <git@vger.kernel.org>
To: "Git MsysGit" <msysgit@googlegroups.com>,
	"Sebastian Schuberth" <sschuberth@gmail.com>
X-From: msysgit+bncBDSOTWHYX4PBBGVA6GWAKGQEGTHXTYI@googlegroups.com Wed Jul 08 00:18:05 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBGVA6GWAKGQEGTHXTYI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f55.google.com ([74.125.82.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBGVA6GWAKGQEGTHXTYI@googlegroups.com>)
	id 1ZCbBj-0004ei-KC
	for gcvm-msysgit@m.gmane.org; Wed, 08 Jul 2015 00:18:03 +0200
Received: by wgxz7 with SMTP id z7sf43790888wgx.1
        for <gcvm-msysgit@m.gmane.org>; Tue, 07 Jul 2015 15:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:reply-to:from:to:cc:references:subject:date:organization
         :mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=/2pXiYHjcfRbLosy3hmUxDFniRNVgD8RXTxWzSGbvCI=;
        b=jH/2+lmCTikRawGIj95ou9fLFE2AQZhqkHl0ePRmE/DZHhimCdqRsBaL3/CTJfUYYE
         93RsG8DK2k2wPHb1a0bhSa5llk7wT7EKC/heNefAQ4rs82Ta2n7KHC5OnW9Mm3xcYoBn
         HYSWvYr8H9xgUOah2PocG/6NrW31W8bYOwtQ1KYXIggY+XpiyqaqI8eEJPgdTlVVCM8p
         FbUv/oYM/u0sw8ZrrJI7OxY5xL+jzsgg74OssYvvL/PhBG3MGjUmdvQadbM415FM5Aqn
         muczRCKdgvIPmvAQALUnH50ho3AHW4uPUt0QSwUcU+V0GAoVbAdnolRXpmRg7cPu3u15
         lOvw==
X-Received: by 10.180.74.112 with SMTP id s16mr350608wiv.7.1436307483341;
        Tue, 07 Jul 2015 15:18:03 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.100.227 with SMTP id fb3ls2162102wib.23.canary; Tue, 07
 Jul 2015 15:18:02 -0700 (PDT)
X-Received: by 10.180.77.225 with SMTP id v1mr7670629wiw.5.1436307482200;
        Tue, 07 Jul 2015 15:18:02 -0700 (PDT)
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net. [62.24.128.238])
        by gmr-mx.google.com with ESMTP id bk2si1254092wib.1.2015.07.07.15.18.02
        for <msysgit@googlegroups.com>;
        Tue, 07 Jul 2015 15:18:02 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.238 as permitted sender) client-ip=62.24.128.238;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DKGAB4T5xVPG3LYAJbgxJUYIMghBu2O4FxgkGDKgQBAwEBgWc6EwEBAQEBAQEGAQEBAUEkG0EFg1gFAQEBAQMIAQEZFR4BASELAgMFAgEDFQMCAgUhAgIUAQQIEgYHAxQGARIIAgECAwGICAMWCbZEg1yCeIl9DYVmAQsggSGKKoJNgjmCby+BFAWRIYJ3AYEFg1yFIoMfRYNSg3+HbYcdgQmDGT0xAYJKAQEB
X-IPAS-Result: A2DKGAB4T5xVPG3LYAJbgxJUYIMghBu2O4FxgkGDKgQBAwEBgWc6EwEBAQEBAQEGAQEBAUEkG0EFg1gFAQEBAQMIAQEZFR4BASELAgMFAgEDFQMCAgUhAgIUAQQIEgYHAxQGARIIAgECAwGICAMWCbZEg1yCeIl9DYVmAQsggSGKKoJNgjmCby+BFAWRIYJ3AYEFg1yFIoMfRYNSg3+HbYcdgQmDGT0xAYJKAQEB
X-IronPort-AV: E=Sophos;i="5.15,426,1432594800"; 
   d="scan'208";a="38447155"
Received: from host-2-96-203-109.as13285.net (HELO PhilipOakley) ([2.96.203.109])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 07 Jul 2015 23:18:02 +0100
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
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273611>

From: "Sebastian Schuberth" <sschuberth@gmail.com>
> On 25.06.2015 02:03, Philip Oakley wrote:
>
>> --- a/contrib/buildsystems/engine.pl
>> +++ b/contrib/buildsystems/engine.pl
>> @@ -41,6 +41,7 @@ EOM
>>   # Parse command-line options
>>   while (@ARGV) {
>>       my $arg = shift @ARGV;
>> + #print "Arg: $arg \n";
>>       if ("$arg" eq "-h" || "$arg" eq "--help" || "$arg" eq "-?") {
>>   showUsage();
>>   exit(0);
>> @@ -129,6 +130,7 @@ sub parseMakeOutput
>>       print "Parsing GNU Make output to figure out build
>> structure...\n";
>>       my $line = 0;
>>       while (my $text = shift @makedry) {
>> + #print "Make: $text\n"; # show the makedry line
>
> Please never commit code that's been commented out. Also see
>
> http://dev.solita.fi/2013/07/04/whats-in-a-good-commit.html
>
> ;-)

The gif was fun, even if it's a little OTT. It does smack of religious
dogma though ;-)

>
> -- 

Hi Sebastian,

It's "deactivated code", not dead code [1].

I'd deliberately included this 'code', as per the commit message because
I saw this as a clear part of aiding future maintenance, and it matches
the rest of the code style, i.e. the judicious placement of a comment
that says 'here's the place to pick out the status when debugging' -
perhaps it's my engineering experience that sees the benefits.

These were the key debug points I used - other's I've removed from the 
series.

Philip


[1] In one of the replies to
http://embeddedgurus.com/barr-code/2013/02/dead-code-the-law-and-unintended-consequences/

:>> as per DO178B safety critical software development guideline
document Terms "Dead code" and "Deactivated Code" have distinct 
meanings:

Dead code : Dead code is source code (and it is a part of binary code)
that is not executed in the final system and it will be not having
traceability to any requirements (one can say unintentional code).

Deactivated code: code which is commented out or removed via #ifdef's
(it is not a part of final binary code) and it will be having
traceability to its low level requirements (its a intentional code and
it can be activated in some configurations through hardware traps for
debugging or other purposes.


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

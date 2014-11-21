From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC 2/4] Properly accept quoted space in filenames
Date: Fri, 21 Nov 2014 23:11:08 -0000
Organization: OPDS
Message-ID: <9E7656E05CE648B3A357858B4520110D@PhilipOakley>
References: <1416526682-6024-1-git-send-email-philipoakley@iee.org><1416526682-6024-3-git-send-email-philipoakley@iee.org> <xmqqegswyygc.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=UTF-8; reply-type=original
Cc: "GitList" <git@vger.kernel.org>,
	"Marius Storm-Olsen" <mstormo@gmail.com>,
	"Ramsay Jones" <ramsay@ramsay1.demon.co.uk>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	"Michael Wookey" <michaelwookey@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Msysgit" <msysgit@googlegroups.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: msysgit+bncBDSOTWHYX4PBBUUMX6RQKGQEGCLEMDI@googlegroups.com Sat Nov 22 00:10:12 2014
Return-path: <msysgit+bncBDSOTWHYX4PBBUUMX6RQKGQEGCLEMDI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f60.google.com ([209.85.215.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBUUMX6RQKGQEGCLEMDI@googlegroups.com>)
	id 1XrxLA-0002Sm-3G
	for gcvm-msysgit@m.gmane.org; Sat, 22 Nov 2014 00:10:12 +0100
Received: by mail-la0-f60.google.com with SMTP id pv20sf500818lab.5
        for <gcvm-msysgit@m.gmane.org>; Fri, 21 Nov 2014 15:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:reply-to:from:to:cc:references:subject:date:organization
         :mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=HtmH04LPIiEXf/SYV4Qg4IxluhTTqcp5Dmm4pfI1u0w=;
        b=UYtadjUvJeQnwqbWa1+dWH6gHIDoaaWhk/31wMc3dkR+8XDWP9VOMkqyvGWFOEkVAm
         8cklUomU961nrCOdLbGrDD/1tWLDmn6Hh8QOCYEzl0ojzBpOwN8Xd6ziphFocUS0SHSf
         cOHERJoDxf4YbpxWLmuEkkmYNMMmg9TqMNFVKFQIEDSDpgMINqQw/9M7DZxLpUN+u2Hh
         4M0rG9oMrsD4K5LkQrH10JJDGxmrHMYpRZMPw5g58vSz2ATS1lFJq5C2+ORcCtnOaxav
         lmaUaDuGFGq+msC4YagLBYTLMMesCZ28QT7odwoZqcr95pE4QR5NqiU7IuVyZkgVop2v
         VLrw==
X-Received: by 10.152.203.161 with SMTP id kr1mr53549lac.8.1416611411874;
        Fri, 21 Nov 2014 15:10:11 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.28.137 with SMTP id b9ls269795lah.29.gmail; Fri, 21 Nov
 2014 15:10:09 -0800 (PST)
X-Received: by 10.112.166.102 with SMTP id zf6mr2371774lbb.12.1416611409822;
        Fri, 21 Nov 2014 15:10:09 -0800 (PST)
Received: from out1.ip06ir2.opaltelecom.net (out1.ip06ir2.opaltelecom.net. [62.24.128.242])
        by gmr-mx.google.com with ESMTP id ed6si35475wib.3.2014.11.21.15.10.09
        for <msysgit@googlegroups.com>;
        Fri, 21 Nov 2014 15:10:09 -0800 (PST)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.242 as permitted sender) client-ip=62.24.128.242;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlELANvFb1RZ8YpUPGdsb2JhbABcgw6BLocJgQTKcwQCgQgXAQEBAQEBBQEBAQE4O4N9BgEBBAgBAS4eAQEhCwIDBQIBAxUMJRQBBBoGBwMUBhMIAgECAwGINL12kEKRC4M2gR8Fi2iGfGumO0gwgksBAQE
X-IPAS-Result: AlELANvFb1RZ8YpUPGdsb2JhbABcgw6BLocJgQTKcwQCgQgXAQEBAQEBBQEBAQE4O4N9BgEBBAgBAS4eAQEhCwIDBQIBAxUMJRQBBBoGBwMUBhMIAgECAwGINL12kEKRC4M2gR8Fi2iGfGumO0gwgksBAQE
X-IronPort-AV: E=Sophos;i="5.07,433,1413241200"; 
   d="scan'208";a="651625460"
Received: from host-89-241-138-84.as13285.net (HELO PhilipOakley) ([89.241.138.84])
  by out1.ip06ir2.opaltelecom.net with SMTP; 21 Nov 2014 23:10:09 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.242 as permitted sender) smtp.mail=philipoakley@iee.org
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

From: "Junio C Hamano" <gitster@pobox.com>
> Philip Oakley <philipoakley@iee.org> writes:
>
>>  sub handleCompileLine
>>  {
>>      my ($line, $lineno) = @_;
>> -    my @parts = split(' ', $line);
>> +    # my @parts = split(' ', $line);
>> +    my @parts = quotewords('\s+', 0, $line);
>
> Can somebody enlighten me why/if quotewords is preferrable over
> shellwords in the context of this patch?

"No" - Ignorance is bliss ;-) I think my cargo culting was the result of 
some googling for "quoting perl variables" or some such, which obviously 
came up with quotewords - I'm happy to take advice on this one!

quotewords did appear to work though back when I wrote this: 86dcfcf 
(Properly accept quoted space in filenames, 2012-05-06)
--
Philip 

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

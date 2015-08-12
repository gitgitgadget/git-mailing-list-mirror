From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH nd/dwim-wildcards-as-pathspecs] t2019: skip test
 requiring '*' in a file name non Windows
Date: Wed, 12 Aug 2015 09:28:11 -0700
Message-ID: <xmqqbnecmpyc.fsf@gitster.dls.corp.google.com>
References: <55CA5D56.6030800@kdbg.org>
	<a9e3c007fb6b39e7339c8d2b1c50d56b@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>,  Git Mailing List <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: msysgit+bncBCG77UMM3EJRBHXIVWXAKGQEJRVF2CQ@googlegroups.com Wed Aug 12 18:28:17 2015
Return-path: <msysgit+bncBCG77UMM3EJRBHXIVWXAKGQEJRVF2CQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pd0-f185.google.com ([209.85.192.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBHXIVWXAKGQEJRVF2CQ@googlegroups.com>)
	id 1ZPYsz-0005XQ-F4
	for gcvm-msysgit@m.gmane.org; Wed, 12 Aug 2015 18:28:17 +0200
Received: by pdrg1 with SMTP id g1sf5496703pdr.0
        for <gcvm-msysgit@m.gmane.org>; Wed, 12 Aug 2015 09:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive
         :list-subscribe:list-unsubscribe;
        bh=hCfol0ZigNQh5UFVbhaIeOI6gDrTOmkBHwW4p3mdZDg=;
        b=tfweDbzcBv47su3i493ZS/hWqcy3QRqCa2YtaWD6d5HNpFM6Bv1G9P6NQ1BOnB82/X
         DpVv1byruekl7pWF4QyBi3Wr9il5O2Tew0zYVT4eicBOP5pDcjJpHepPsg4oYQ5jiTzm
         DM3SpcBSmtCdvS654b0KYXKh2WZis1R1UoPDcNWjGKL93EZiEYAO1rGzEQKdMhSAyjPF
         sz8hQ3S8k9WeB/r6RH0FSbq6Jo8aeMWnbwtUBSBYXh2RvGdRFC7ghydhBI+gipLJKO7M
         fIlz1USl6MyyxJw3TXDTX1xXNoRc2LbxYiGhrw+kSGwN9zll7MTVKFFpdr92DRAGeFtn
         C7oA==
X-Received: by 10.140.96.138 with SMTP id k10mr361023qge.18.1439396896612;
        Wed, 12 Aug 2015 09:28:16 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.86.100 with SMTP id o91ls240844qgd.54.gmail; Wed, 12 Aug
 2015 09:28:14 -0700 (PDT)
X-Received: by 10.13.247.133 with SMTP id h127mr30971402ywf.2.1439396894115;
        Wed, 12 Aug 2015 09:28:14 -0700 (PDT)
Received: from mail-pd0-x229.google.com (mail-pd0-x229.google.com. [2607:f8b0:400e:c02::229])
        by gmr-mx.google.com with ESMTPS id c1si629162pdg.0.2015.08.12.09.28.14
        for <msysgit@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2015 09:28:14 -0700 (PDT)
Received-SPF: pass (google.com: domain of jch2355@gmail.com designates 2607:f8b0:400e:c02::229 as permitted sender) client-ip=2607:f8b0:400e:c02::229;
Received: by mail-pd0-x229.google.com with SMTP id fa8so8964998pdb.1
        for <msysgit@googlegroups.com>; Wed, 12 Aug 2015 09:28:14 -0700 (PDT)
X-Received: by 10.70.89.109 with SMTP id bn13mr68387317pdb.163.1439396893961;
        Wed, 12 Aug 2015 09:28:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:755f:3d29:a826:eda6])
        by smtp.gmail.com with ESMTPSA id 4sm7003242pdh.51.2015.08.12.09.28.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 09:28:12 -0700 (PDT)
Sender: msysgit@googlegroups.com
In-Reply-To: <a9e3c007fb6b39e7339c8d2b1c50d56b@www.dscho.org> (Johannes
	Schindelin's message of "Wed, 12 Aug 2015 13:25:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of jch2355@gmail.com designates 2607:f8b0:400e:c02::229
 as permitted sender) smtp.mailfrom=jch2355@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275779>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Hi,
>
> On 2015-08-11 22:38, Johannes Sixt wrote:
>
>> diff --git a/t/t2019-checkout-ambiguous-ref.sh
>> b/t/t2019-checkout-ambiguous-ref.sh
>> index 8396320..199b22d 100755
>> --- a/t/t2019-checkout-ambiguous-ref.sh
>> +++ b/t/t2019-checkout-ambiguous-ref.sh
>> @@ -69,7 +69,7 @@ test_expect_success 'wildcard ambiguation, paths win' '
>>  	)
>>  '
>>  
>> -test_expect_success 'wildcard ambiguation, refs lose' '
>> +test_expect_success !MINGW 'wildcard ambiguation, refs lose' '
>>  	git init ambi2 &&
>>  	(
>>  		cd ambi2 &&
>
> FWIW I planned to submit a patch including this fix:
>
> https://github.com/git-for-windows/git/commit/4694320330e1b4d9178e13e215ce60a1cc8e0b1c
>
> (The idea of the `fixup! ` was to make this change part of a larger
> change during the next merging rebase of Git for Windows.)

Thanks.  Is that an Ack?

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

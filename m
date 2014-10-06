From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Re: [PATCH v4] MinGW(-W64) compilation
Date: Mon, 06 Oct 2014 20:50:02 +0200
Message-ID: <5432E45A.8000208@kdbg.org>
References: <1412060563-22041-1-git-send-email-marat@slonopotamus.org> <20141006051707.GA23305@seldon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>, git@vger.kernel.org
To: Marat Radchenko <marat@slonopotamus.org>, gitster@pobox.com
X-From: msysgit+bncBCJYV6HBKQIN7SGLUECRUBDD43HQI@googlegroups.com Mon Oct 06 20:50:09 2014
Return-path: <msysgit+bncBCJYV6HBKQIN7SGLUECRUBDD43HQI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f62.google.com ([74.125.82.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIN7SGLUECRUBDD43HQI@googlegroups.com>)
	id 1XbDMH-0002Z9-3N
	for gcvm-msysgit@m.gmane.org; Mon, 06 Oct 2014 20:50:09 +0200
Received: by mail-wg0-f62.google.com with SMTP id x12sf486631wgg.17
        for <gcvm-msysgit@m.gmane.org>; Mon, 06 Oct 2014 11:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=bn0BPWgg+7lhrtIon2s9+78EbJq4xq8oqAoor9u1eSU=;
        b=lahDSPGGIMDoALUR72f5eyEyAzgkFW2UUJ7YC2p0rFWXb7X7fn7rAt7pl4u+1Fs/6N
         aAjd3LCKwc2GY3Va5gR1pIjlsZvXA9yjlBk0clFyEfkQKQ1ILtb5EbguxMNAWaePCVWX
         5ki40RCJzhSLkOvxfOnpCmf2O4STIpRPkR1snPy0bn7T9Ka7xDu/YL5MJmotdwoaXI1G
         Nnp7zPu9okJeC4xmEgM650W3fGiWBBhR0m3t9amcoL2pjwBf2qtI/X+T0d+DuAn13wuz
         nNouEfAs7T90AU4WrxiF6wkNcW1VILKDnePV22zdnh1lwwTLZCCIJHpjYWx/CyAWNjId
         ta4g==
X-Received: by 10.152.36.71 with SMTP id o7mr24367laj.29.1412621408828;
        Mon, 06 Oct 2014 11:50:08 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.4.72 with SMTP id i8ls513318lai.25.gmail; Mon, 06 Oct 2014
 11:50:07 -0700 (PDT)
X-Received: by 10.152.1.136 with SMTP id 8mr624375lam.5.1412621407046;
        Mon, 06 Oct 2014 11:50:07 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp1.bon.at. [213.33.87.15])
        by gmr-mx.google.com with ESMTPS id u2si247749wiw.0.2014.10.06.11.50.04
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Oct 2014 11:50:04 -0700 (PDT)
Received-SPF: none (google.com: j6t@kdbg.org does not designate permitted sender hosts) client-ip=213.33.87.15;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3jBW7b1Ky7z5tlK;
	Mon,  6 Oct 2014 20:49:30 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 9DDBF19F5CD;
	Mon,  6 Oct 2014 20:50:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <20141006051707.GA23305@seldon>
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: j6t@kdbg.org does not designate permitted sender hosts) smtp.mail=j6t@kdbg.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257914>

Am 06.10.2014 um 07:17 schrieb Marat Radchenko:
> On Tue, Sep 30, 2014 at 11:02:29AM +0400, Marat Radchenko wrote:
>> This patch series fixes building on modern MinGW and MinGW-W64 (including x86_64!).
> 
> Junio, ping?
> 

Sorry, I forgot to report that this updated series works now for me.

The patches all look reasonable. I don't have an opinion on the
restriction that MSVC < 2010 can't be used anymore (path 08/14).

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

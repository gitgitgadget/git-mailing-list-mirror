From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: Weird filename encoding issue
Date: Sat, 18 Oct 2008 19:51:53 +0200
Message-ID: <200810181951.53962.johannes.sixt@telecom.at>
References: <c6c947f60810170059s3859d906r9935b5e80d8a41c6@mail.gmail.com> <48F852FC.2070506@viscovery.net> <c6c947f60810172322o12beeb80xfd39b551b0db7c99@mail.gmail.com>
Reply-To: johannes.sixt@telecom.at
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>, git@vger.kernel.org
To: agladysh@gmail.com
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sat Oct 18 19:53:31 2008
connect(): Connection refused
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wf-out-1516.google.com ([209.85.200.166])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrFzD-0006xH-Ho
	for gcvm-msysgit@m.gmane.org; Sat, 18 Oct 2008 19:53:11 +0200
Received: by wf-out-1516.google.com with SMTP id u12so284069wfc.33
        for <gcvm-msysgit@m.gmane.org>; Sat, 18 Oct 2008 10:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=Lj4ykTxBkD08pY2poYadSCUKkVa++fRCqjaWuw0hJoo=;
        b=G3Rhfq3x0rkkef95SZsBQvQdQWN6zo3iI9Be0IV/L0WZSYsaETaGZ4ab+7gRESbSLw
         2TVgp+6ctdGx7rZ56/3aSyVj27kwz/xhsOySWjlb24ldE1gUtiCgEcU8rHksjh0tKGm4
         bLIUS0t///QNu+oxxMf4hB68Luae+S1eEsF8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        b=qzo9A3Aeri2oy1PZ8m4ZEn0kxIqN4VP0r0kfpfkQrPhgnna2/6HCLxnjzYc5/LGC60
         YSeoKwnlihqhenjcB6+ObYqzkzTnb6Kgh0Om/eO2V5jxK8xPvQ9HV+3SvJpfhiACORwl
         C/8+WrHS/4IU6d9n1hwsPFqqzPSC2SRDh4q5I=
Received: by 10.141.14.14 with SMTP id r14mr168316rvi.0.1224352317368;
        Sat, 18 Oct 2008 10:51:57 -0700 (PDT)
Received: by 10.106.212.23 with SMTP id k23gr3102prg.0;
	Sat, 18 Oct 2008 10:51:57 -0700 (PDT)
X-Sender: johannes.sixt@telecom.at
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.100.31.3 with SMTP id e3mr3406449ane.18.1224352316921; Sat, 18 Oct 2008 10:51:56 -0700 (PDT)
Received: from smtp5.srv.eunet.at (smtp5.srv.eunet.at [193.154.160.227]) by mx.google.com with ESMTP id 7si4940788yxg.0.2008.10.18.10.51.56; Sat, 18 Oct 2008 10:51:56 -0700 (PDT)
Received-SPF: neutral (google.com: 193.154.160.227 is neither permitted nor denied by best guess record for domain of johannes.sixt@telecom.at) client-ip=193.154.160.227;
Authentication-Results: mx.google.com; spf=neutral (google.com: 193.154.160.227 is neither permitted nor denied by best guess record for domain of johannes.sixt@telecom.at) smtp.mail=johannes.sixt@telecom.at
Received: from dx.sixt.local (unknown [93.83.142.38]) by smtp5.srv.eunet.at (Postfix) with ESMTP id CEF9E13A35D; Sat, 18 Oct 2008 19:51:54 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1]) by dx.sixt.local (Postfix) with ESMTP id 5F7932805A; Sat, 18 Oct 2008 19:51:54 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <c6c947f60810172322o12beeb80xfd39b551b0db7c99@mail.gmail.com>
Content-Disposition: inline
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98561>


On Samstag, 18. Oktober 2008, Alexander Gladysh wrote:
> 1. Git hooks do not work under msysgit.

This is new to me. Why are you saying that? (IOW, please be more precise with 
your description. We can't help you if all you tell us is "Does not work" .)

-- Hannes

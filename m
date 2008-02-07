From: Dmitry Potapov <dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Fri, 8 Feb 2008 01:18:37 +0300
Message-ID: <20080207221837.GQ30368@dpotapov.dyndns.org>
References: <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com> <alpine.LSU.1.00.0802071255110.8543@racer.site> <20080207130715.GA14000@bit.office.eurotux.com> <alpine.LSU.1.00.0802071324460.8543@racer.site> <7v1w7ooes3.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802071831520.8543@racer.site> <7vprv8mu2k.fsf@gitster.siamese.dyndns.org> <20080207202357.GO30368@dpotapov.dyndns.org> <57518fd10802071349w50446803q249cbda0e2998bc5@mail.gmail.com>
Reply-To: dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Luciano Rocha <luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org>, Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Jonathan del Strother <maillist-3GLpx8vVthx0ubjbjo6WXg@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Feb 07 23:19:16 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ag-out-0910.google.com ([72.14.246.188])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNF5P-0001hV-QO
	for gcvm-msysgit@m.gmane.org; Thu, 07 Feb 2008 23:19:16 +0100
Received: by ag-out-0910.google.com with SMTP id 32so6377388agc.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Feb 2008 14:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:dkim-signature:domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=ihY5y3VX9RPdmpUkot6mvf7+FAvJ22wjvAIFwl2a2mo=;
        b=siO0Fqye78kxKX90YDsetvej4gVDUCDQKH5rucDf5ZFzOFZS3lqFaWdg/xJBdiHGtOmbw9mae/XhvMchIrPtWOw8byQGVbobPfbxdgm+Lz4cgDioUIZ0kzXOKZGAS/iDCb+0OduLH+I+oftpINzLA6s63DwHdpKj2rS6n8v1NnM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:dkim-signature:domainkey-signature:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=lHJjMvIvyzjoONrmkmucTUGorzQtCMV5HLc0drUSBkyUsb2GgpNceX9dHh7eyKhxuokZt86BCKNx9g6NYi+ADDyqkUq8xE43iQFLVw18+j+DzC7ZstmLT7QebERHeDw6lEv5DCgdkjfwvw6IY18YJP6+A3YWUUbYGdJ1WkzzJ0c=
Received: by 10.150.148.7 with SMTP id v7mr515410ybd.29.1202422723371;
        Thu, 07 Feb 2008 14:18:43 -0800 (PST)
Received: by 10.107.134.19 with SMTP id l19gr1672prn;
	Thu, 07 Feb 2008 14:18:43 -0800 (PST)
X-Sender: dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.59.5 with SMTP id m5mr25885704pyk.0.1202422723139; Thu, 07 Feb 2008 14:18:43 -0800 (PST)
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159]) by mx.google.com with ESMTP id v63si7644007pyh.2.2008.02.07.14.18.42; Thu, 07 Feb 2008 14:18:43 -0800 (PST)
Received-SPF: pass (google.com: domain of dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 72.14.220.159 as permitted sender) client-ip=72.14.220.159;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 72.14.220.159 as permitted sender) smtp.mail=dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; dkim=pass (test mode) header.i=@gmail.com
Received: by fg-out-1718.google.com with SMTP id 22so2925927fge.23 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Thu, 07 Feb 2008 14:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent; bh=dUrptPR9F5uq0kSWoqIkJo29mRH61W3fIhy3a6fx5iE=; b=vxj+4tpBd0npDoqfr+FPQgYxAY2lACIhNXyn+nCifRy2+rk4kTw2//+20CMu3dVeKeVdp2XitGaB59Ofns+6AjD+ABFGJwMQv1ts0Le/Tin8uGLp52sNi90oUYFAHVWC16EKnLff4+yTNGAcDVH+UYAMzOSPNYKFbypnNFOH+2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent; b=YHMFFRn7hgsDCCiomzukz1YkZpqefZxOdQ1nJoonPQbn+zz4U11Hy2BJpRWsXDYhr7TERSaA2MYCuHVV6mjZPf01PcTts7qLRXuwOgHWbxaCTJNMOneDdzVMwDLd09WVqK01d/bbjfHCKLcI0xOVC8/6LFlOIaZySqya8J4h5oE=
Received: by 10.86.28.5 with SMTP id b5mr10909075fgb.79.1202422721756; Thu, 07 Feb 2008 14:18:41 -0800 (PST)
Received: from localhost ( [85.141.191.183]) by mx.google.com with ESMTPS id l12sm11025981fgb.8.2008.02.07.14.18.39 (version=TLSv1/SSLv3 cipher=OTHER); Thu, 07 Feb 2008 14:18:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <57518fd10802071349w50446803q249cbda0e2998bc5-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org;
	contact msysgit-owner-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:msysgit-help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73011>


On Thu, Feb 07, 2008 at 09:49:45PM +0000, Jonathan del Strother wrote:
> 
> Just out of curiosity - does this mean that MacPorts (a fink-like
> package manager for OS X) ought to display the license while
> installing?  Or does that somehow not apply here?

Unfortunately, I don't know much about OS X and the packet manager
you mentioned, but from common sense, I would say you should place
the copyright notice at the place where users traditionally can find
it when install other programs on that platform...

Dmitry

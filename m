From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Mon, 7 Jan 2008 14:58:46 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801071457040.3148@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <7vzlvhxpda.fsf@gitster.siamese.dyndns.org>
Reply-To: torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>, Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Robin Rosenberg <robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@public.gmane.org>, Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>, Peter Karlsson <peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Mon Jan 07 23:59:43 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.243])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JC0wW-0003RJ-Ba
	for gcvm-msysgit@m.gmane.org; Mon, 07 Jan 2008 23:59:40 +0100
Received: by wa-out-0708.google.com with SMTP id n36so511567wag.21
        for <gcvm-msysgit@m.gmane.org>; Mon, 07 Jan 2008 14:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-spam-status:x-spam-checker-version:x-mimedefang-filter:x-scanned-by:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=lyOJ8NyFTJ9uTxSXz+5Xt5p4HY8KW+UH0bfDm+YIeIY=;
        b=6lT3+fVR/bTqH+jXOtam0g14jliicLngGT3rYZhS/xGeMIfiGpv4Ai0oJktsSFqTaVDbLlcOrhPCLVMZaqqf0EPm7vZ3pLc7ZYIaxY0T2P2Tlhsu/wC8CYj/OKgiqvF/s2Df+DYGQ+otvF5fHx5cD6UQMGenVvkFdJk2/Gi3A80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-spam-status:x-spam-checker-version:x-mimedefang-filter:x-scanned-by:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=C7qnMTf4QyRw9WMZa2bSNeer7tWjbnNSPysIy/YQLXAEyn7sAYHCtIuAIIVc8YD3cfz2CzU34qCfW27tD+sriB585nPdEj77dYRQx418WRWB+Sz25JdZgw0969uU6SxNB4ErGXaA60bgzPHkONdjLwI1sb48EyG4EUoZq2HzVIE=
Received: by 10.140.82.35 with SMTP id f35mr746903rvb.10.1199746752888;
        Mon, 07 Jan 2008 14:59:12 -0800 (PST)
Received: by 10.44.13.45 with SMTP id 45gr1312hsm;
	Mon, 07 Jan 2008 14:59:12 -0800 (PST)
X-Sender: torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.114.210.2 with SMTP id i2mr3248076wag.21.1199746752529; Mon, 07 Jan 2008 14:59:12 -0800 (PST)
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org [207.189.120.14]) by mx.google.com with ESMTP id k36si1074274waf.0.2008.01.07.14.59.02; Mon, 07 Jan 2008 14:59:12 -0800 (PST)
Received-SPF: pass (google.com: domain of torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org designates 207.189.120.14 as permitted sender) client-ip=207.189.120.14;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org designates 207.189.120.14 as permitted sender) smtp.mail=torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55]) by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m07MwmhO010833 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Mon, 7 Jan 2008 14:58:49 -0800
Received: from localhost (localhost [127.0.0.1]) by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m07MwkN2016477; Mon, 7 Jan 2008 14:58:47 -0800
In-Reply-To: <7vzlvhxpda.fsf-jO8aZxhGsIagbBziECNbOZn29agUkmeCHZ5vskTnxNA@public.gmane.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.423 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_48
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69823>




On Mon, 7 Jan 2008, Junio C Hamano wrote:
> 
> So wouldn't the categorization be more like this?

Well, one thng we could do is to add a new concept, namely

	core.autocrlf = warn

and make *that* the default.

It would do the check, but not actually convert anything, just warn about 
it.

Then, it's up to the user to set it explicitly to "true" or "false", 
unless they just like seeing that warning a million times ;)

That might be acceptable to most people.

		Linus

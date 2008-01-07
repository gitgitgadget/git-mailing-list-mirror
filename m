From: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Mon, 07 Jan 2008 14:06:09 -0800
Message-ID: <7vzlvhxpda.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>,  Robin Rosenberg <robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@public.gmane.org>,  Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>,  Peter Karlsson <peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org>,  Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,  msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Mon Jan 07 23:07:01 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wr-out-0708.google.com ([64.233.184.249])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JC07X-00049h-F3
	for gcvm-msysgit@m.gmane.org; Mon, 07 Jan 2008 23:07:00 +0100
Received: by wr-out-0708.google.com with SMTP id 56so12199745wra.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 07 Jan 2008 14:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:from:to:cc:subject:references:date:in-reply-to:message-id:user-agent:mime-version:content-type:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=4tIvo4jmKOUNDot0ug6rz6H37xSajVWLl3vGllC05NM=;
        b=YFKSRf+ePzrPgAly3sSQeP72+NEUmbCFd4tqgSGfrMMFmjAwM5+U+QKO1Na121DrujzUktrIWCmfWb2uQqfJrxxEPcNMTnt6K34vz6rFn0hNz2yUcqOXp81iujzqfqV9qn85x3v+rREgMcmSA3yZtwl6XZKQjuv+wPS0szz8Yk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from:to:cc:subject:references:date:in-reply-to:message-id:user-agent:mime-version:content-type:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=QPH3BMHYruE8UrkHj2z0PyKaPIUgCIUrA5yZqLrgQDGd1MDclaBG2675+6xKn+fzpMxN/Xtz9rETRE26PwUTfEbliMans8yoRnrI69LTWONDYh2WD7eKQv3jv4o/anwMZJSvY18by8aeJauB5wlVRdPDPCjQimE90Cf8gMnvfNA=
Received: by 10.100.189.10 with SMTP id m10mr603375anf.22.1199743586374;
        Mon, 07 Jan 2008 14:06:26 -0800 (PST)
Received: by 10.44.219.52 with SMTP id r52gr1311hsg;
	Mon, 07 Jan 2008 14:06:26 -0800 (PST)
X-Sender: gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.140.186.20 with SMTP id j20mr1766765rvf.9.1199743585988; Mon, 07 Jan 2008 14:06:25 -0800 (PST)
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com [208.72.237.25]) by mx.google.com with ESMTP id x35si28311547nzg.2.2008.01.07.14.06.25; Mon, 07 Jan 2008 14:06:25 -0800 (PST)
Received-SPF: pass (google.com: domain of gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org designates 208.72.237.25 as permitted sender) client-ip=208.72.237.25;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org designates 208.72.237.25 as permitted sender) smtp.mail=gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org
Received: from a-sasl-quonix (localhost [127.0.0.1]) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A8E2F9AE9; Mon,  7 Jan 2008 17:06:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77]) (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DF4939AE4; Mon,  7 Jan 2008 17:06:15 -0500 (EST)
In-Reply-To: <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134-wjoc1KHpMeg@public.gmane.org> (Steffen Prohaska's message of "Mon, 7 Jan 2008 22:40:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69819>


Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org> writes:

> I believe the main question is which type of projects we would like
> to support by our default.  For real cross-platform projects that will
> be checked out on Windows and Unix we should choose
> "core.autocrlf true" as our default.  But if our default are native
> Windows projects that will never be checked out on Unix, then we
> should not set core.autocrlf by default.

If the primary target is native Windows projects that wants CRLF
in the work tree, you could still set core.autocrlf.  Your
checkouts will be with CRLF.  And someday perhaps somebody may
offer porting that to UNIX and his checkout will be without CR.

So wouldn't the categorization be more like this?

 - "real cross-platform" would want core.autocrlf = true;

 - "native Windows" can work either way;

 - "originated from UNIX" would be helped with core.autocrlf = true;

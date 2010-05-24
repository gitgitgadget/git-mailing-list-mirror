From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: What's cooking extra
Date: Mon, 24 May 2010 22:56:12 +0200
Message-ID: <20100524205612.GA28890@localhost>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org>
 <20100519170656.GA30161@pvv.org>
 <20100522130916.GA28452@localhost>
 <50199F1F-3513-43A6-8990-957F3D0AF58C@gmail.com>
 <20100522222746.GA2694@localhost>
 <CDD31343-2352-434B-B875-2013DAF49CE7@gmail.com>
 <20100523115127.GA20443@localhost>
 <744D05D2-FC47-45E5-92A1-CD93B0901E0C@gmail.com>
 <20100524094905.GA10811@localhost>
 <20100524124734.GD3005@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 24 22:56:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGehD-0004uv-K6
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 22:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756827Ab0EXU4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 16:56:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:45119 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711Ab0EXU4S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 16:56:18 -0400
Received: by fg-out-1718.google.com with SMTP id e12so2296fga.1
        for <git@vger.kernel.org>; Mon, 24 May 2010 13:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=getyX0/5dqcqjcJqEwaE12b7vMD6jdxVfWvlCNrxwyM=;
        b=f2vrr1O6TqySjl1AnTIQfl7g/cujtUZQ7DVTjYwC6LbGmi0ZoZp1bUzAMvgFJ/pLpl
         4y0KgcIMtrRu3xvvygHKpfsJWwfQddI2WiJVTZEV7xXB30Y1/EO4g9zmQg0+pVEdx6D5
         TAYARMuBCMxcXi8buUqCI3J6Sy+6S+dVitPTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=CN2Q6u+KfMTOs2Oj48Jsc7XQ1zAgwL0i7oak+Jnx+bWLldzNNojwOidWia0yywfwXB
         NfMKUKQK7/dftE4l/u5z8KaQ3nOMQZBxf3U/OcWgX6FRGzzX0LxPdzoHrYdIytGPkowx
         trwAOiPAbGgs2wZNacRTNLa9WDf6sn1jQiJIU=
Received: by 10.86.124.35 with SMTP id w35mr9008157fgc.49.1274734576608;
        Mon, 24 May 2010 13:56:16 -0700 (PDT)
Received: from darc.lan (p549A704B.dip.t-dialin.net [84.154.112.75])
        by mx.google.com with ESMTPS id 1sm6207109fkt.41.2010.05.24.13.56.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 13:56:15 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OGeh2-0007Xb-8t; Mon, 24 May 2010 22:56:12 +0200
Content-Disposition: inline
In-Reply-To: <20100524124734.GD3005@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147649>

On Mon, May 24, 2010 at 04:47:34PM +0400, Dmitry Potapov wrote:

> On Mon, May 24, 2010 at 11:49:05AM +0200, Clemens Buchacher wrote:
>
> > With CRLF file in the repository, core.autocrlf=true and
> > core.eol=lf,
> 
> I wonder if this combination should be allowed. core.autocrlf=true
> always implied that the native EOL is CRLF.

I just did what the commit message suggested:

    If core.eol is set explicitly (including setting it to "native"), it
    will override core.autocrlf so that
    
    [core]
            autocrlf = true
            eol = lf
    
    normalizes all files that look like text, but does not put CRLFs in the
    working directory.

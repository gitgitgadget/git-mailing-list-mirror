From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: What's cooking extra
Date: Mon, 24 May 2010 16:47:34 +0400
Message-ID: <20100524124734.GD3005@dpotapov.dyndns.org>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org>
 <20100519170656.GA30161@pvv.org>
 <20100522130916.GA28452@localhost>
 <50199F1F-3513-43A6-8990-957F3D0AF58C@gmail.com>
 <20100522222746.GA2694@localhost>
 <CDD31343-2352-434B-B875-2013DAF49CE7@gmail.com>
 <20100523115127.GA20443@localhost>
 <744D05D2-FC47-45E5-92A1-CD93B0901E0C@gmail.com>
 <20100524094905.GA10811@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon May 24 14:47:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGX4K-0001od-Og
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 14:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756900Ab0EXMrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 08:47:40 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:53485 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756810Ab0EXMrj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 08:47:39 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1849772fga.1
        for <git@vger.kernel.org>; Mon, 24 May 2010 05:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=dBO1SX63d5/tFxn7RhqS29C7Gsej68frkNbdJLA9AQg=;
        b=U5jKE05phem89VG+0G9vaeMLAwFgoYa8GZHBZXq9L+Udo6t4B6XQaGGPAuNH4zNDa8
         8wI693t4HP4beDS3hSR/DAeOS9wrl1/qYT3AVY1JxoL/klaUIfvwrDLHPminR5TDXW6Z
         5Y7ti4Cf9cev0hHDKKJWp6ZaIj1UaEA4ypdIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uu2QaP3juDNHnJLtDqKobt5/SB6UKDOxGzV9ynOL49UOaDsYEBZj7FYo1CBkc1R9w9
         xMLQMT9SWuU345aiDFuCh12rQFtttRHR29fEK+aRk/A371AF8dtQJnBBP0/LRxNEqUJF
         xzw3rGaBJxStGEzPWW3r5oK0QKF2Rnkdbs8QA=
Received: by 10.86.22.31 with SMTP id 31mr8292032fgv.24.1274705257738;
        Mon, 24 May 2010 05:47:37 -0700 (PDT)
Received: from localhost (ppp85-140-126-0.pppoe.mtu-net.ru [85.140.126.0])
        by mx.google.com with ESMTPS id 4sm9484056fgg.2.2010.05.24.05.47.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 05:47:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100524094905.GA10811@localhost>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147630>

On Mon, May 24, 2010 at 11:49:05AM +0200, Clemens Buchacher wrote:
> 
> Just because a feature is requested doesn't mean it's useful, or
> even harmless. This has nothing to do with version control in the
> first place, so I do not see why we should suffer the additional
> complication.

IMHO, ability to enforce a specific for particular types of files is
a good thing, and if you can say that these files must have CRLF, it
should be possible to say that those files must have LF. At least, it
would be a logic thing to do. I don't see how it can be harmful.

> 
> With CRLF file in the repository, core.autocrlf=true and
> core.eol=lf,

I wonder if this combination should be allowed. core.autocrlf=true
always implied that the native EOL is CRLF. So I do not think any
reasonable behavior can be deduced for this combination. Can you
imagine _anyone_ who would want to have such settings? Otherwise,
it is better to error out if this combination is encountered.


Dmitry

From: bill lam <cbill.lam@gmail.com>
Subject: Re: checkout to a reflog entry
Date: Tue, 25 Aug 2009 13:37:47 +0800
Message-ID: <20090825053747.GC391@debian.b2j>
References: <20090825045235.GB391@debian.b2j>
 <20090825052200.GA15880@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 25 07:39:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfokz-0007TU-NK
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 07:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477AbZHYFhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 01:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754451AbZHYFhw
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 01:37:52 -0400
Received: from mail-px0-f196.google.com ([209.85.216.196]:36934 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083AbZHYFhw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 01:37:52 -0400
Received: by pxi34 with SMTP id 34so5561636pxi.4
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 22:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=x7+W3dICYb9GA9OwfrPc/LLCvh6dJHEbw+tiat8y/eI=;
        b=Sfexx744aLR55mIQ/GFnqABb0/KhSIm2/I7rC+S5s4XBk9/v/lI8YfSnn6N9WI+jp6
         bZuQwsU9F7UyC8PB4WpeEfawVcpxg6V0OGyjDNYJL2VlHfbwfOUZ48XfWUQPrvjHcH7l
         v8KYhngpZr7fb6Uw1LGWUgQqJDkfVkKySTnFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=fWjM9Pt7jW+A3i3jBXhSRKnpVi8fq3u3Uh6HFNd4kF3U795ctqgmhQKFmUpJYRO+7V
         xtHdtRntpLIbpUuw0+e3xzUAsdmZZMGdRcnh02dmnzu5EJg46/1aAJrQNwNKlH9oxZe5
         XZJknaAX7T6CphcBC68Tgdxqm3XrjDNwm/YgY=
Received: by 10.115.101.10 with SMTP id d10mr8379045wam.61.1251178673784;
        Mon, 24 Aug 2009 22:37:53 -0700 (PDT)
Received: from localhost (n218103237119.netvigator.com [218.103.237.119])
        by mx.google.com with ESMTPS id j39sm1116292waf.45.2009.08.24.22.37.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 Aug 2009 22:37:52 -0700 (PDT)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090825052200.GA15880@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127006>

On Tue, 25 Aug 2009, Jeff King wrote:
> A reflog entry is not a branch; it is just a pointer to the commit where
> a branch was at some point. Using "git checkout" on it will let you
> explore the contents, just as you might with a tag. If you want to build

Thank you for explanation on the difference between checkout and
reset.

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3

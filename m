From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] jn/gitweb-blame fixes
Date: Fri, 20 Nov 2009 00:05:08 +0100
Message-ID: <200911200005.08841.jnareb@gmail.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 00:05:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBG3y-0003sJ-HO
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 00:05:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757845AbZKSXFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 18:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757843AbZKSXFF
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 18:05:05 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:63995 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756686AbZKSXFD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 18:05:03 -0500
Received: by bwz27 with SMTP id 27so2941524bwz.21
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 15:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=5OXvB8tRJLaHj/lKJr1cpqZBFzG0E/7JWFM0fEKvvcI=;
        b=bj37GNIzJBD1w2t1Gd0NloaX6Q5h8VrCg0x9a//R6FB66dIaLw7ShL3MnehjUTi2v+
         rISx2NQApB+5tYhg8uB7sR4u86hpBYU8kV2ZRQYc/BIR5Gqg9vY8KqP7RWzIFPTKbjzf
         hfWIIQNLxdeHllZI24oFbPmA5JKZEb02XAhUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=wAx8oCpujs6D0NV8key299xrA3QL6lYXqoZut3IgxG7hKQF/3FcZ4st7pI1178rKuF
         s7RJDcFzATl8yynz6AKzcvNXnnhGYFWjymogDs75iGJyUrdFC8RhGLfkXDk4c0yy5wK0
         WwxucqkeOErdw+b0xe99LyrNEe+N2+ermGOrw=
Received: by 10.204.143.153 with SMTP id v25mr607657bku.116.1258671908539;
        Thu, 19 Nov 2009 15:05:08 -0800 (PST)
Received: from ?192.168.1.13? (abvw68.neoplus.adsl.tpnet.pl [83.8.220.68])
        by mx.google.com with ESMTPS id 15sm368447fxm.14.2009.11.19.15.05.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 15:05:07 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1258659887-5244-1-git-send-email-bebarino@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133266>

On Thu, 19 Nov 2009, Stephen Boyd wrote:

> This series is based on next's jn/gitweb-blame branch.
> 
> I was trying out the incremental blame and noticed it didn't work each 
> time. The first patch fixes the crashing I experience when blaming
> gitweb.perl (ironic ;-)
> 
> The second patch fixes a visible bug I see in Firefox. Although I assume
> on other browsers it's not a problem? I haven't tested it on others so I
> can't be sure.

Thanks for working on this.  Also it is nice to have incremental blame
tested for another browser, beside Mozilla 1.17.2 and Konqueror 3.5.3

-- 
Jakub Narebski
Poland

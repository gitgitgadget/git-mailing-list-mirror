From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Syntax highlighting support
Date: Thu, 18 Feb 2010 20:00:18 +0100
Message-ID: <201002182000.19721.jnareb@gmail.com>
References: <20100217212855.2014.49834.stgit@localhost.localdomain> <alpine.DEB.1.00.1002181103400.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 18 20:01:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiBcy-0007pI-Tb
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 20:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758136Ab0BRTAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 14:00:33 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:4461 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755334Ab0BRTAa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 14:00:30 -0500
Received: by fg-out-1718.google.com with SMTP id 22so14772fge.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 11:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Hsla/mnml+W6pLlWwV0dlv2iJuWdjkwWh/uwV7HqEZw=;
        b=e4lILslbHm/ihQMl8CW+uGZUYBZheaUm1piCppNMgPmECq7hH6iJybmMRFhRQmH75W
         p2E9MZ0LEjFZLmSfmCtIjgRmw5d1U/xZ7xMb6r2JvHnV3wNsiQfix7prWDs5MVFB3+vV
         xTftNcjJiOarV7loYlQOsw2zc4rZac1vIR0xE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=LXwa7r4kEuflzR6SKi6ag5RIpzNTuxCMUiU9ill8QhJ4b8pX9exLyRF84M9+5Uu0Tw
         +zEQo+XMZw5A4Dl0SZno/oyT10nTCj2f3jSVkpZAgOGp7hLAiLzRqKpqKWYigWdyY8lQ
         LMkYTv5MjFN+Qncj5T+xn8iPFonqGLInWjyUw=
Received: by 10.223.6.88 with SMTP id 24mr9477386fay.2.1266519628629;
        Thu, 18 Feb 2010 11:00:28 -0800 (PST)
Received: from ?192.168.1.13? (abwu39.neoplus.adsl.tpnet.pl [83.8.244.39])
        by mx.google.com with ESMTPS id p17sm1743931fka.5.2010.02.18.11.00.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 11:00:25 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.DEB.1.00.1002181103400.20986@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140363>

On Thu, 18 Feb 2010, Johannes Schindelin wrote:
> On Wed, 17 Feb 2010, Jakub Narebski wrote:
> 
> > [jn: cherry picked from bc1ed6aafd9ee4937559535c66c8bddf1864bec6
> >  in http://repo.or.cz/w/git/dscho.git, with a few changes]
> 
> Thanks. These changes are greatly appreciated, and I will try to find the 
> time to install this in our production system tomorrow.

This patch is also available in 'gitweb/web' branch in my repository:
http://repo.or.cz/w/git/jnareb-git.git

P.S. I have applied your patch "cherry-picking" it from your repository
by saving 'patch' view from gitweb and using git-am on it.  You can pull
  git://repo.or.cz/git/jnareb-git.git gitweb/web
or you can do the same
  http://repo.or.cz/w/git/jnareb-git.git/patch/7bf179bb5c40518b98bc63ebcfa3ae7f0b437a42
-- 
Jakub Narebski
Poland

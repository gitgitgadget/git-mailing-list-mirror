From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCHv3 4/5] gitweb: Starting work on a man page for /etc/gitweb.conf (WIP)
Date: Wed, 8 Jun 2011 18:40:16 +0200
Message-ID: <201106081840.17253.jnareb@gmail.com>
References: <1307382271-7677-1-git-send-email-jnareb@gmail.com> <20110606221236.GD30588@elie> <20110606222500.GE30588@elie>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>,
	Drew Northup <drew.northup@maine.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 18:40:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QULo1-0004LB-Bt
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 18:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705Ab1FHQk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 12:40:26 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43117 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab1FHQkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 12:40:25 -0400
Received: by fxm17 with SMTP id 17so450525fxm.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 09:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=KfN+VjBGlinnBH0YD9nHR3pXedtRmkSxBu41nnW2lc0=;
        b=xQKNBUgsdZF8h4pNFWls9Am0eCWw+TwmNSNW47hAZ5rJ0FJ1t6Oc745rNDj/i9HQBh
         lI9iVN+t85vvCiGSKxoZDTU1Qm6tUz48FcsN6D/35M+1dUOXU2m548b8tA9IkMlOC8Xe
         kCQsdbu8GP9tMyH930oFzjLHjwlJwWMMTy7k0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=d+Zs4WpU1qH1MWlWO7Qea709OlXmuROCq7UUG7nfxhF7hE/zZ6pWHLdWM1m07d+HsV
         fS+0TeOYbMLQn16OivehRlk/Bss8UUZZvilXPxZkjRTb8f4+WEqqPTWlLcpsMuz0TcI9
         Q3yapsF3sGGKRJ/xRQtV2dzcaD1fLXQ9vm+HI=
Received: by 10.223.33.6 with SMTP id f6mr530257fad.85.1307551224251;
        Wed, 08 Jun 2011 09:40:24 -0700 (PDT)
Received: from [192.168.1.15] (abvu41.neoplus.adsl.tpnet.pl [83.8.218.41])
        by mx.google.com with ESMTPS id l26sm311318fam.21.2011.06.08.09.40.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 09:40:23 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110606222500.GE30588@elie>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175398>

Jonathan Nieder wrote:
> Jonathan Nieder wrote:
>> Jakub Narebski wrote:
> 
>>> +$GIT::
>>> +	Core git executable to use.  By default set to `$GIT_BINDIR/git`, which
> [...]
>> I think a better default would be "git", so if a newer git gets
>> installed in /usr/local/bin then gitweb would notice automatically.
> 
> Wait, that's quite wrong.  What I was forgetting about is the case
> where the webmaster does not control the web hosting but just has a
> place to drop CGI scripts under ~/public_html/cgi-bin.  In such a case
> it would be very convenient that "make install-gitweb" just does the
> right thing (including using a private copy of git).

Right, "git" might not be in PATH of a web server (which can have
reduced PATH for security reasons anyway).

-- 
Jakub Narebski
Poland

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Fix mod_perl support.
Date: Wed, 5 Nov 2008 23:40:26 +0100
Message-ID: <200811052340.27677.jnareb@gmail.com>
References: <200811060110.07965.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Petr Baudis <pasky@suse.cz>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 23:41:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kxr4V-0003A4-5V
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 23:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbYKEWkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 17:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbYKEWkj
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 17:40:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:17635 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164AbYKEWki (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 17:40:38 -0500
Received: by ug-out-1314.google.com with SMTP id 39so655791ugf.37
        for <git@vger.kernel.org>; Wed, 05 Nov 2008 14:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=3aXRg6PyEvyYizF6XlisAYgpb//cuV/zHuY5EhVTJ8Q=;
        b=lQwfXOd2itw3tF1qnZMjFON0DFZJSyswbWS3Pmb/c3HPnXNKNYkVqJ/kJM7ixARcwD
         gVXXRYcawnctr3OnNH0khcCHn3DosmOnxP616ImC4K4+Gzz1vdTElYLNINcY25w3mLKQ
         zu97nWnQImNnqax+RTXZas9ISOc52xBKUEq7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=W38Iq28cs0F5ViL9vWetUm5GtiS0gYBenKS9CypkuSg5NeU9V5qTpkpaYtHDPHgKUn
         OnMtSkAlEN5bbayVQwen+vid+d4VwXvY0cvjp8FpHNTGftZZaVhyJ8lhqIemE0Dr6uec
         6glavV1NJwc/mSI+cKSsibQBNWlfGDwNGVQTo=
Received: by 10.67.32.18 with SMTP id k18mr99681ugj.27.1225924837102;
        Wed, 05 Nov 2008 14:40:37 -0800 (PST)
Received: from ?192.168.1.11? (abwq47.neoplus.adsl.tpnet.pl [83.8.240.47])
        by mx.google.com with ESMTPS id o7sm2704997uge.0.2008.11.05.14.40.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Nov 2008 14:40:35 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200811060110.07965.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100195>

Alexander Gavrilov wrote:

> [...] it is necessary to declare all global
> variables as 'our' [...]
> 
> Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>

I have forgot about that when reviewing path_info patches. I'm sorry
about that. Good catch, and good explanation.

Acked-by: Jakub Narebski <jnareb@gmail.com>

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index c5254af..2174d4a 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
[...]

> -my $path_info = $ENV{"PATH_INFO"};
> +our $path_info = $ENV{"PATH_INFO"};
[...]

-- 
Jakub Narebski
Poland

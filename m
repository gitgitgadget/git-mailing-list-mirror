From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 1/5] cache: rename cache_name_compare() to
 name_compare()
Date: Wed, 18 Jun 2014 12:11:09 -0700
Message-ID: <20140618191109.GW8557@google.com>
References: <1403117117-10384-1-git-send-email-jmmahler@gmail.com>
 <1403117117-10384-2-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 21:11:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxLGR-0002Y6-6w
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 21:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741AbaFRTLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 15:11:13 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:45547 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104AbaFRTLM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 15:11:12 -0400
Received: by mail-pb0-f50.google.com with SMTP id rp16so1065422pbb.9
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 12:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=W6B1I3oSzZjYz3l8xwvtf5uKYOWI+3mpmNeDovwYcnA=;
        b=oSp+qvgEZqbJZO5hVUbOpjvIR+PtAe6kjm7NfEjH+ZI0742xk3GIFZcFFkN47dpN/x
         8yLt2KsSiV1W8tj0I6CqC4b59uyYRHzzlN7ixwRNQlXAPxOFS+B5L0kZ7BXLIHtPYR2q
         SR0yuxFjWQdu/AT8AP9+dNjKKk7ks2GLwR4wlGaks+e06852wm0w/cPqE046kJtm4Huw
         YcGpQtm4YHeKqLLso+UfKxfb7/Br0u9laUJoaqmsZCUA0gtIEZUVImf2XVzsdy7BhxQU
         DQRTUJeBB1ifUWlKiJKKWYXu/TaVwVQ7nDcUWDOsN8N+iNugW8szsOvLwDZ+17u7Jhpk
         hnVg==
X-Received: by 10.67.21.205 with SMTP id hm13mr91675pad.112.1403118672067;
        Wed, 18 Jun 2014 12:11:12 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id fm8sm14494164pab.28.2014.06.18.12.11.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 18 Jun 2014 12:11:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1403117117-10384-2-git-send-email-jmmahler@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252030>

Jeremiah Mahler wrote:

> The cache_name_compare() function is not specific to a cache.
> Make its name more general by renaming it to name_compare().

Sounds reasonable.

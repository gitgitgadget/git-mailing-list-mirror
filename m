From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation: 'cherry' does not cope well with merges
 from upstream
Date: Thu, 1 Jul 2010 16:35:12 -0500
Message-ID: <20100701213512.GB4283@burratino>
References: <1278012954-sup-3724@pimlott.net>
 <20100701210919.GA4283@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>,
	=?iso-8859-1?B?RnLpZOlyaWMgQnJp6HJl?= <fbriere@fbriere.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Andrew Pimlott <andrew@pimlott.net>
X-From: git-owner@vger.kernel.org Thu Jul 01 23:36:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OURQz-00044z-IJ
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 23:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933130Ab0GAVgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 17:36:35 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61670 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933297Ab0GAVfk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 17:35:40 -0400
Received: by iwn7 with SMTP id 7so2470097iwn.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 14:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9EZDu/So8izbi90NahavNJjQnktRAV5+OZm+v8DT3Wg=;
        b=IfnCwVa/ZigQSei0o2BteledmT08/ZL2LMoJ05DebsxNmvZHXAbRJ2xklrT7iWdxMV
         YKpfZvBvVtJXbnYjzBR8B5dcy6bu++br+9BplM/oAnH9VKlcIUy5SQYJNsIqatoVVpQD
         2uBMaubYlyEKFMH8AXLtKNkqy3aLaq4b5xhqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qIoihXyY53RVSaT48S/k9CMyQUaxsdfx6nGpkHklwBULN0T8toJY2IN47nGMzO8YE1
         dcneRi6BfLvcNz3Brd1JZtJ43EPcaVta9HMVAOIQauWki+CI/ZXbwMxueXtYNdSY0wKx
         8Tfr43ClvOEcABnZcdKryv4Cs3hdYE7Le/SD8=
Received: by 10.42.1.17 with SMTP id 17mr22246ice.86.1278020138517;
        Thu, 01 Jul 2010 14:35:38 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g31sm32370502ibh.8.2010.07.01.14.35.37
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 14:35:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100701210919.GA4283@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150088>

Jonathan Nieder wrote:

>                                    it makes sense semantically
> since even if a new patch patches an old patch from <upstream>,

err, for 'patches' read 'matches'.  I was not trying to say
something that complicated. :)

Sorry for the noise.
Jonathan

From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH/RFC v4 02/13] read-cache.c: Re-read index if index file
 changed
Date: Mon, 27 Aug 2012 11:39:30 +0200
Message-ID: <20120827093930.GC26470@tommy-fedora.surfnet.iacbox>
References: <001d01cd82db$0dc00870$29401950$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Mon Aug 27 11:40:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5vnb-00082X-Fg
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 11:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753549Ab2H0Jjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 05:39:49 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:61037 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487Ab2H0Jjg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 05:39:36 -0400
Received: by wicr5 with SMTP id r5so3385129wic.1
        for <git@vger.kernel.org>; Mon, 27 Aug 2012 02:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=AjcCithrCveOzBciDMfSiFFKRoYkow8i8SqBBpYfAWQ=;
        b=gaXDdY34Jt3nRHUYHrOvzXzslh1C2JlYx695HJX9WHvl4C4eewNNVlOkNbWqlP13Fv
         p0nNmBsefqzFmhRSDM5FAtjxPJFgzMt25IjeXmGYB8lCLj3rHlOJ1lzvHRux7ULlD4vX
         9zQyPSAzIalpsO1RMTt9/tdPQ3BEsucxTEuJLGsZ6y+i7UOS0G8ajyxTwxY7q1m7fr+e
         Ic/hN+a8E/5LPUH5eGnsFNVXaP9PRF3pmz+hC5kjRGJNDQdeiJUMK+IFmBHcuajHvRNC
         3+9K2GzYAHCmKk21CE69y+DTuj2W5/YViph5C3f40Pg2Aj7yMSP8rLlBIUqxnXHyK1zo
         DuhA==
Received: by 10.180.94.38 with SMTP id cz6mr22958846wib.10.1346060374444;
        Mon, 27 Aug 2012 02:39:34 -0700 (PDT)
Received: from localhost ([95.171.54.129])
        by mx.google.com with ESMTPS id n15sm3514834wie.7.2012.08.27.02.39.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 27 Aug 2012 02:39:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <001d01cd82db$0dc00870$29401950$@schmitz-digital.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204331>

On 08/25, Joachim Schmitz wrote:
> "Thomas Gummerer" <t.gummerer@gmail.com> schrieb im Newsbeitrag news:<1345111129-6925-3-git-send-email-t.gummerer@gmail.com>...
> > [...]
> > +		usleep(10*1000);
> 
> usleep() is not available to anybody, e.g. it is not in HP NonStop (not in every case at least)
> 
> Bye, Jojo
> 
Thanks for noticing, will be fixed in the re-roll.

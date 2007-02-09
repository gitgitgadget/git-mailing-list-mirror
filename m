From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: restriction of pulls
Date: Fri, 9 Feb 2007 16:45:31 +0000
Message-ID: <200702091645.33384.andyparkins@gmail.com>
References: <200702091149.12462.duelli@melosgmbh.de> <200702091619.23058.andyparkins@gmail.com> <45CCA301.4060504@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Rogan Dawes <lists@dawes.za.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christoph Duelli <duelli@melosgmbh.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 09 17:50:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFYwz-00019V-IG
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 17:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946657AbXBIQqS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 11:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946639AbXBIQp4
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 11:45:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:55117 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946667AbXBIQpj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 11:45:39 -0500
Received: by ug-out-1314.google.com with SMTP id 44so827848uga
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 08:45:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fo6MsPAHinhw3kM7i1R42bq+mZN4jwJ4RwwCWbNiD1y9KAAlRWCRvmR2jHc+hktHpM/FuVGtjVMrlrcr8CUISj5oFmIBogKFh2FZl27cZUqAEKwLkfMspyQgTpP1xUq2VV6Ib1lJlPjCxbZ3fPjcIeUK78VCgraJtGRaYhkbY7Q=
Received: by 10.66.242.20 with SMTP id p20mr11444554ugh.1171039537546;
        Fri, 09 Feb 2007 08:45:37 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id m1sm4443834ugc.2007.02.09.08.45.34;
        Fri, 09 Feb 2007 08:45:35 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <45CCA301.4060504@dawes.za.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39186>

On Friday 2007 February 09 16:36, Rogan Dawes wrote:

> Please note that my suggestion does NOT imply allowing partial checkins
> (or if it does, it was not my intention)

My apologies then; I did misunderstand.


> > In every way that matters you can do a partial checkout - I can pull any
> > version of any file out of the repository.  However, it should certainly
> > not be the case that git records that fact.
>
> Why not? If you only want to modify that file, does it not make sense
> that you can just check out that file, modify it, and check it back in?

Sorry - what I meant was that it shouldn't record that you checked out 
revision 74 of that file and retain a link from the current version to that 
old version.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com

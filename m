From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH 1/3] builtin-status: submodule summary support
Date: Thu, 13 Mar 2008 21:05:17 +0800
Message-ID: <46dff0320803130605g492ebc89y9476aba6ae729d9f@mail.gmail.com>
References: <1205288512-20435-1-git-send-email-pkufranky@gmail.com>
	 <47D78753.2040902@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 14:06:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZn8k-0003fy-SM
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 14:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119AbYCMNFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 09:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754078AbYCMNFW
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 09:05:22 -0400
Received: from hs-out-0708.google.com ([64.233.178.250]:35505 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816AbYCMNFV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 09:05:21 -0400
Received: by hs-out-0708.google.com with SMTP id 4so2600995hsl.5
        for <git@vger.kernel.org>; Thu, 13 Mar 2008 06:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=IdgO/MRomrYbzYvLZLKTwxRjY9iANjdYkPOGiGnsJvQ=;
        b=we5GVxzlV91kLTlfmxJ5oUTTBbXp08t2bmuFP5cnJQKBAkjqQpsE/WzKpQ7YY+7hktl38HP6rXT4s3z8OSYx363rQa6AWAfvgbS7bTQYW8Ju9F1nMwj+u2U5X3J6fRq51hlNNEVVTcsRu/QUHASmOlaQERgSmBIYH+OzNJWc5LY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YgaQIngv+wFvYDV0ivgUOjb2LqA1+LDLiBfKBFDz73bEpF/Edk25eNfUM3opwsyxUHaDr/YKuJ4h4rzRSZy21jMZMjV8eyfUAWYW4NxpMlYSyaN2/uo9ik4bhwHNLpYBTeSzk9nlkI5wbAvzkPbbQUvcGoUxyhpKGBMIk5wyep8=
Received: by 10.100.127.18 with SMTP id z18mr19503832anc.39.1205413517540;
        Thu, 13 Mar 2008 06:05:17 -0700 (PDT)
Received: by 10.100.5.18 with HTTP; Thu, 13 Mar 2008 06:05:17 -0700 (PDT)
In-Reply-To: <47D78753.2040902@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77075>

>
>  Where is summary_limit? Did you split this patch series incorrectly?
>
>  > +             s->amend ? "HEAD^" : "HEAD",
>
>  Any chance that we avoid "HEAD^" here? Perhaps we have the SHA1 around
>  somewhere? I fear that our MSYS bash mangles it into "HEAD". I shall test it.
>
I am not familiar with git core code, and don't find a way to avoid 'HEAD^' yet



-- 
Ping Yin

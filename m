From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH (REVISED)] Add core.editor configuration variable
Date: Thu, 19 Jul 2007 08:48:51 +0100
Message-ID: <200707190848.54655.andyparkins@gmail.com>
References: <11848281302504-git-send-email-aroben@apple.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Adam Roben <aroben@apple.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 09:49:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBQl4-0005Wy-U4
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 09:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757615AbXGSHtB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 03:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753821AbXGSHtB
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 03:49:01 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:2001 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756177AbXGSHs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 03:48:59 -0400
Received: by ug-out-1314.google.com with SMTP id j3so359693ugf
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 00:48:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QASUw6uHmmKOsZo0SC7BoqV/JvSXtDILH8sxiC+kMCTNiZdXdUS5inkPUd3DpTjFpPkt5PjtITi5PxbUUagqKBPPhdni8ZNJ5N+A0D5VN4OGLB9FYoLztqyhEQh8uJ+JGk4n2AH6z5Z7NW2Lz1ETYsXZFInTb2sVDYewXQ5FLHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ppThEV3CCBe+yvCyeQbZoBMsOKNBDS40zOPKt6R+FYQJ+CdY1q7QCAmQ+/saWu30+UbqEst9OtlCWD1fMCcGlz9lV4BAe30noPDutFKBFArxavZ7YMwVFYTgzdxXG2AG0brmFBGSNovt9bELzTND3mXawd+siqTAcgRPFyGQ6BA=
Received: by 10.66.254.2 with SMTP id b2mr1003276ugi.1184831338844;
        Thu, 19 Jul 2007 00:48:58 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id c25sm3228570ika.2007.07.19.00.48.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jul 2007 00:48:58 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <11848281302504-git-send-email-aroben@apple.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52950>

On Thursday 2007 July 19, Adam Roben wrote:

>    Well, it turns out we already do launch an editor in other places,
> namely "git am -i" and "git send-email --compose". So, this patch takes
> care of those cases as well.

Perhaps I'm being overly pedantic, but it seems odd to put options that are 
relevant only to porcelain under the "core" section.

core.pager is in the same category - but that's already in.

Would porcelain.editor be a better name for this variable?


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com

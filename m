From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/4] reset: add a few tests for "git reset --merge"
Date: Thu, 10 Sep 2009 22:59:15 +0200
Message-ID: <200909102259.16469.jnareb@gmail.com>
References: <20090910200334.3722.20140.chriscool@tuxfamily.org> <20090910202333.3722.45063.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Sep 10 22:59:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlqkH-0004EU-9A
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 22:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321AbZIJU7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 16:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754077AbZIJU7I
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 16:59:08 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:32933 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032AbZIJU7H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 16:59:07 -0400
Received: by fxm17 with SMTP id 17so407635fxm.37
        for <git@vger.kernel.org>; Thu, 10 Sep 2009 13:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=AmpsCnPHVP3kRPrHqdp1BeDd1L/BXGdvVUn0L2ixf3o=;
        b=de8CEicZS9MjD3KEy+6FxJarVCOW91ZYOwo5rXEs1p5eH3/wDH2pwep/qityUCm0sX
         IhnHE2oNddeLd8M70nKixln8rTkAWhIg4utL8IoVdgLEEagO9o8LpQXk1LwUiuV3xxcy
         HNKFt0lDHzKQH0ZJeKsJUzvLoBMGVwJAIFWOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=lvnQNGYtnPSVYBYkOoGXnsaQsmPItRwwYKpAQBkn51NVKh3yWEtPE5g9p5BHqfpR76
         smzMrMAgp2WASar03fTeqXmjHi0uRI9Iu+w1dN6esAsgu+4QH9b5VH5Dubd/uSqhWapK
         R6HukNaZpG8X80Ctv9upyX4OLicbKxVPllwE8=
Received: by 10.86.220.11 with SMTP id s11mr1609008fgg.47.1252616349315;
        Thu, 10 Sep 2009 13:59:09 -0700 (PDT)
Received: from ?192.168.1.13? (abwa69.neoplus.adsl.tpnet.pl [83.8.224.69])
        by mx.google.com with ESMTPS id 4sm845043fge.23.2009.09.10.13.59.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Sep 2009 13:59:08 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090910202333.3722.45063.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128148>

Christian Couder wrote:

> diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
> new file mode 100755
> index 0000000..45714ae
> --- /dev/null
> +++ b/t/t7110-reset-merge.sh
> @@ -0,0 +1,70 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2009 Christian Couder
> +#
> +
> +test_description='Tests for "git reset --merge"'
> +
> +exec </dev/null

What does this do?

-- 
Jakub Narebski
Poland

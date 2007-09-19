From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Side-by-side diff and patch visualization
Date: Wed, 19 Sep 2007 14:08:20 +0100
Message-ID: <200709191408.21527.andyparkins@gmail.com>
References: <A92611E8-1035-46A6-AFEF-9C8A6F93AFB1@wincent.com> <20070919120956.GA20715@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 19 15:10:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXzIB-0000OO-Sg
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 15:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754267AbXISNIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 09:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754226AbXISNIb
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 09:08:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:40730 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532AbXISNIa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 09:08:30 -0400
Received: by nf-out-0910.google.com with SMTP id g13so170909nfb
        for <git@vger.kernel.org>; Wed, 19 Sep 2007 06:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=AwvQBYJoGcqU0qEXC4fxQBWN5fM6tKI048VbEpm0Qsc=;
        b=RG4ecRMDj2aUrxoPns0zBK1rjKp5VmLFGsIQOKazUjOkLjyZld5hWradVq9jfOvJBcBglwN8NOfghYRlS1jA8Pvp4uU/v69xR++AQMo5NMDsqpO3WkUlkYmaNIDtIlkNoCi7PgNbGa+3tGohuq4rzr/92e6LeZ0OJzhM4QUBaVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IposeXrZdEeGHMWgBHuJ44y+kpjWm0VVY/mOYr3cprwA52zwjZVh9LPj+kqy5IWCu+NvrdHkSNndhQlSR9GSLzd69Y0y2097242kLmL1zkAZiR9z69UyCQqRY6nyAH4KU+Qkc1BCvxzfdEfmDrTKFJ1AXVPf1aGZHLZrYsfnbCw=
Received: by 10.78.160.4 with SMTP id i4mr305339hue.1190207308577;
        Wed, 19 Sep 2007 06:08:28 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id i15sm800438wxd.2007.09.19.06.08.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Sep 2007 06:08:27 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <20070919120956.GA20715@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58710>

On Wednesday 2007 September 19, Jeff King wrote:

> Have you tried kompare?
>
>   git-diff HEAD~5 | kompare -

You can also throw in the "--unified" switch to see the whole file, rather 
than just the bits that have changed (if that's what you like).

 git-diff --unified=9999999 HEAD~5 | kompare -


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com

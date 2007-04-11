From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Rebase, please help
Date: Wed, 11 Apr 2007 09:48:01 +0200
Message-ID: <81b0412b0704110048j30193650r6a7e7417a9afeaf8@mail.gmail.com>
References: <200704110852.00540.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alexander Litvinov" <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 14:59:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbXYl-0003su-Ea
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 09:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbXDKHsE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 03:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbXDKHsE
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 03:48:04 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:55263 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbXDKHsB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 03:48:01 -0400
Received: by an-out-0708.google.com with SMTP id b33so103947ana
        for <git@vger.kernel.org>; Wed, 11 Apr 2007 00:48:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kkC5R0LQNz6MwNUqnPD+WA8tpc4a1EsD+sk+k/N3an3rsFMojlAe+RbZTxb4j68RDfnci0paV2XfCehuxc3qXh62q2qbH+sJJTVHw7L1febllONsu+fbuie+qUr9k9yYmhAADrTBNv4weCVyPNtaE1VJPj9JzEZSHX4Gqxf58e0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P1/XRQkKBaUSwAdPyeZw6VXoCexzssXA2Jq1iO/nbRsKdSzEemnb/szhR9vCSOPDGqv0Z/obw+MZB3hSMVZ3pbt4RM/k67iu5XVjFzQ1HmqmR6EOO4xRQhIUCF+fYOqlpajjxF7UNI46W2d3sLYwFRbyjFd97WZBfjarHjgLUWk=
Received: by 10.100.140.6 with SMTP id n6mr219240and.1176277681056;
        Wed, 11 Apr 2007 00:48:01 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Wed, 11 Apr 2007 00:48:01 -0700 (PDT)
In-Reply-To: <200704110852.00540.litvinov2004@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44214>

On 4/11/07, Alexander Litvinov <litvinov2004@gmail.com> wrote:
>
> What is --merge for ? Will the result be the same ?

Maybe, maybe not. It uses merge strategies instead of git-am
and has advantages over blindly applying the patches (it can
know how a change got in, and it uses resolved conflict cache).

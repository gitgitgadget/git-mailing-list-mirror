From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Stupid quoting...
Date: Wed, 13 Jun 2007 14:06:48 +0200
Message-ID: <81b0412b0706130506m8b35f9eje32e2c4e669b348d@mail.gmail.com>
References: <86ir9sw0pi.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jun 13 14:06:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyRci-0006kn-Ht
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 14:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757625AbXFMMGv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 08:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757253AbXFMMGv
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 08:06:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:35826 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757232AbXFMMGu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 08:06:50 -0400
Received: by ug-out-1314.google.com with SMTP id j3so392539ugf
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 05:06:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a+iv9IPLQnFMhTY0fTpdFp5liRSqqtkV7exmJoSzLJqOAeiICtbmJd1CnNsQhwzZj2AwwEeUntX8IPtmX7bxnLeN4HpW1A1poXRH3wIflw7aW8NDPeku4vzoXfjoo8VreHjl/HJ3Yyw2aRHUGJOPBBfCRXkhIlJJQNUMK1FVhdw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EknvT5hn7SL/77qd+ancr2TPyuMF6InSQZu5/rtRRh+rn9/3ACahrb4+t/MMsgp2sUWeuiBoRTO0WHcytKt4sizY3zO3n9UNMDRhEiJ+zN6Q5j+zPt27mWaIVzlBhocEJRrvXyISmrt4nT2So7rPZHh0bx61YrSENxQPf7U906M=
Received: by 10.78.204.1 with SMTP id b1mr147021hug.1181736408549;
        Wed, 13 Jun 2007 05:06:48 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Wed, 13 Jun 2007 05:06:48 -0700 (PDT)
In-Reply-To: <86ir9sw0pi.fsf@lola.quinscape.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50050>

On 6/13/07, David Kastrup <dak@gnu.org> wrote:
>
> what is the point in quoting file names and their characters in
> git-diff's output?  And what is the recommended way of undoing the
> damage?
>

Just use "-z". Everything will be unquoted and separated by \0

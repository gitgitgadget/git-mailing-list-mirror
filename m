From: Ori Avtalion <ori@avtalion.name>
Subject: Re: [PATCH] Fix typo in filter-branch example
Date: Thu, 13 Aug 2009 20:15:22 +0300
Message-ID: <4A844A2A.6080305@avtalion.name>
References: <4a843cdf.1608c00a.504c.0eed@mx.google.com> <alpine.DEB.1.00.0908131903280.7429@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 13 19:15:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbdtj-0003eN-Hx
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 19:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755149AbZHMRPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 13:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752291AbZHMRPV
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 13:15:21 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:50916 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbZHMRPV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 13:15:21 -0400
Received: by bwz22 with SMTP id 22so715553bwz.18
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 10:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=jHS2Z4qV0kDCzcoa2qWGQ9YjxtYnQ83Ad7VqZ96LUKo=;
        b=b9AwD7yGxhaAYlBg0Ltif2+cVpKl8rc4SHWRMUtWv0z9B6Ugm8ivWis3lWr66yq4xF
         fjrNdoj77CTerNsGC/x0oNrrz8KaVjgwb04ZAd3zi8Whv4v1QziKZQO6ZhiiC8qDbb9V
         GDu+01CtBHExTdAsE2n7z0W4vcfBDj1QXGZ7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=u/1YrNT2zRUDl1C37cjaqCMWyo5vFhyomQ8JLsJ5W8QqH70US98eLiAFYUaQAXEgce
         pVuUbYE1XFsEyEMSH2bThMrETzinxK5xDSbCNdkaPwOg1Hga/FkickxK+ipN1XKuSpUJ
         f7hMAxOb2ybUwrDxKkInr4IU0O3d9jibMLLq0=
Received: by 10.103.171.20 with SMTP id y20mr393775muo.100.1250183720520;
        Thu, 13 Aug 2009 10:15:20 -0700 (PDT)
Received: from ?192.168.1.55? (bzq-79-179-35-131.red.bezeqint.net [79.179.35.131])
        by mx.google.com with ESMTPS id g1sm2523471muf.46.2009.08.13.10.15.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Aug 2009 10:15:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.1.3pre) Gecko/20090811 Shredder/3.0b4pre
In-Reply-To: <alpine.DEB.1.00.0908131903280.7429@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125841>

On 08/13/2009 08:04 PM, Johannes Schindelin wrote:
>
> This is not a typo. '&' is sed's way to specify the matched string.  Where
> does it occur anyway (the commit message makes a fabulous place to put
> such information)?

Whoops! My mistake!

I think I accidentally removed it when I tried the example, and then 
added it in a wrong position when that didn't work :)

Sorry for the false alarm!

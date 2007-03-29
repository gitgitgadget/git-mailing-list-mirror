From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: SEGV in git-merge recursive:
Date: Thu, 29 Mar 2007 13:29:46 +0200
Message-ID: <81b0412b0703290429k63642a34u6bea1e08803ffba7@mail.gmail.com>
References: <20070329075010.GA3493@hermes>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 29 13:29:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWspI-0001Lo-Qn
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 13:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362AbXC2L3r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 07:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753364AbXC2L3r
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 07:29:47 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:53855 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362AbXC2L3q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 07:29:46 -0400
Received: by wr-out-0506.google.com with SMTP id 76so185754wra
        for <git@vger.kernel.org>; Thu, 29 Mar 2007 04:29:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NZ+SSSHqh5j7IAL04svShh2uKhU0IwDCmIrx5yK6Gf51i/azfHaI55jwaGsA3+9zm0g+/CmpWC0GUPjvDgclZhHzTTm4pBFGKFTlUR4z4PfeepF9kGjMxw86N7K8BmgbHxcYDoB/WGTFLZ2KjnLSUGBedceM2E99jDXYScAmwm0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H7/whwhaKsP4OkrNElq7FgGvtEzXEU/ccngYLXRPtECeGCwpNoSHzv74/SLBvubhofWxXPLUmARDjxu7ucGQo7LaO+DS90ApdkgeE9gpFuepIl2k7afXH15nRfK1GAXlD6rdjiPlU/5zGFfNt4BzMXHtWcuE40hF6X5BBPAkGkU=
Received: by 10.100.172.3 with SMTP id u3mr288212ane.1175167786325;
        Thu, 29 Mar 2007 04:29:46 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Thu, 29 Mar 2007 04:29:46 -0700 (PDT)
In-Reply-To: <20070329075010.GA3493@hermes>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43428>

On 3/29/07, Tom Prince <tom.prince@ualberta.net> wrote:
> I have been keeping my Maildir in git, a non-trivial merge that causes a
> segfault in git-merge-recursive.
>
> It does not appear to matter which direction I try to merge.
>

BTW, what git do you have? git --version?

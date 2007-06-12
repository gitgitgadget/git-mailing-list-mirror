From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH 2/4] Abstract a PatchSet object out of Series.
Date: Tue, 12 Jun 2007 23:09:50 +0100
Message-ID: <b0943d9e0706121509j5088e164iadedb561501d6a55@mail.gmail.com>
References: <20070611003117.4736.33551.stgit@gandelf.nowhere.earth>
	 <20070611003330.4736.69293.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Wed Jun 13 00:10:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyEZP-0002zo-FS
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 00:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756192AbXFLWJy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 18:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756634AbXFLWJx
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 18:09:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:53263 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756589AbXFLWJw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 18:09:52 -0400
Received: by ug-out-1314.google.com with SMTP id j3so272961ugf
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 15:09:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OtVa656jO8OTATbNiXZyOETaMUTWuZdz8s2WUNmgn9vtbYkP1LGLj8OHJ04PeO+tO4mbCFGRKi2MgyhjnHpABlVDyn5AFYRA2JiTNtiaDdZC67sMSHUJ9iqGAsEtTqTPRd4mKOJ2QMGPZHtgTxxE0AAYtp6mhM91MIO1IU4g37k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Kk6BeEEI0bN5O6XJEpn5GvdA5cG3p7drnA4sclZqtR0J1QdgqsW+vsUYtLZtou26IBFT3mJhimIcIFqstJ+9kOdJUiXBxZQsfLKRLRsm+h1ykG350BuTMHJVHdDryEXlInaqxLNBmKdUwgCA9WHxjIEnfxC+h5DwFREVSqjZLTM=
Received: by 10.66.240.2 with SMTP id n2mr775672ugh.1181686190065;
        Tue, 12 Jun 2007 15:09:50 -0700 (PDT)
Received: by 10.67.27.11 with HTTP; Tue, 12 Jun 2007 15:09:50 -0700 (PDT)
In-Reply-To: <20070611003330.4736.69293.stgit@gandelf.nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50005>

On 11/06/07, Yann Dirson <ydirson@altern.org> wrote:
> The goal is to move into PatchSet all functionnality that is not
> dependant of Series being a real stack, paving the way for handling
> parallel (hydra) stacks, or any other way to organize patches.

Thanks for the patches. I applied this one as well and I like the
idea. What is your long-term plan with this split?

The HEAD in my repository fails the test suite. Do you have any
additional patches pending (some patches were not applied in order as
I had to manually fix the conflicts). Anyway, please check my
repository for any missing patches.

Thanks.

-- 
Catalin

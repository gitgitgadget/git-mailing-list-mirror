From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: stgit 0.13 import mbox problems
Date: Thu, 23 Aug 2007 21:36:05 +0100
Message-ID: <b0943d9e0708231336h3a92de22oc025c69b9209da9a@mail.gmail.com>
References: <20070823092254.GA5976@kroah.com>
	 <20070823180633.GA24530@filer.fsl.cs.sunysb.edu>
	 <20070823184758.GB17601@kroah.com>
	 <20070823185608.GC1608@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Greg KH" <greg@kroah.com>, git@vger.kernel.org
To: "Josef Sipek" <jsipek@fsl.cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Thu Aug 23 22:36:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOJPZ-0003WH-GU
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 22:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755727AbXHWUgJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 16:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755568AbXHWUgI
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 16:36:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:18845 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754748AbXHWUgH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 16:36:07 -0400
Received: by nf-out-0910.google.com with SMTP id g13so464228nfb
        for <git@vger.kernel.org>; Thu, 23 Aug 2007 13:36:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NYa+50wNCCVRE0iYn2Nz9FECmk2r6flhyX791nDN2VRjguycRo8ztkhTovatP9RyWDCHPXG3lwcQEhoU6ABlVjvZFx5bNEyIb85y2uev05959cVmDeV7XI3u9PCZRJRS1CYmaTVe3l0r9UyDajKxDD6j57cojpe2kQInLrOfmXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JP9TkIG0Ofrxz/48KVDiLDTa78qs7ozNfowoKDSBXWV+pW2SnHvNQQ8IgIf63Dzh7xaKidFxvIHt522AMZydB8m0hMqTj3V+xLIBMeW4e7YPK2I0OTVKI5xpQstp3Q2A0tUvcDtLe5OgaYy5bczN0q6y6FysJwYXCqYnuzbA5T4=
Received: by 10.78.183.15 with SMTP id g15mr1472745huf.1187901365943;
        Thu, 23 Aug 2007 13:36:05 -0700 (PDT)
Received: by 10.78.151.11 with HTTP; Thu, 23 Aug 2007 13:36:05 -0700 (PDT)
In-Reply-To: <20070823185608.GC1608@filer.fsl.cs.sunysb.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56527>

On 23/08/07, Josef Sipek <jsipek@fsl.cs.sunysb.edu> wrote:
> Yep. Two different projects taking different approaches to storing the
> patches. I go with the plaintext diff approach ala quilt, while stgit uses
> git objects to store the data.

But guilt also generates a commit object when pushing a patch. Or am I wrong?

-- 
Catalin

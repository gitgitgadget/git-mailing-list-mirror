From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Re: stg branch --create test v2.6.24-rc1 doesn't work
Date: Tue, 30 Oct 2007 10:20:05 +0530
Message-ID: <cc723f590710292150y752034c7x5642758eb51a7ed6@mail.gmail.com>
References: <cc723f590710260342t5fd0bdc3nc1ea5198cea1a604@mail.gmail.com>
	 <b0943d9e0710291011p11bd8901udeb758fa653610bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: kha@treskal.com, "Git Mailing List" <git@vger.kernel.org>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 05:50:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imj3V-0003Vi-NN
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 05:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbXJ3EuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 00:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbXJ3EuH
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 00:50:07 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:6376 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbXJ3EuF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 00:50:05 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2360225wah
        for <git@vger.kernel.org>; Mon, 29 Oct 2007 21:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=bnMRabdMqjsRd/GvVJpHt2L5tKEB3oiWpGD5I2kvnJg=;
        b=tKkvtNgDEK6rydrm2+SHB7M2ySDMUrwJwcAGvH+xOE1aHaibAOAgkn+9wIWajFCFcESmYWldh597Zz6Irf6X6OYxcDAsZDd4EcUBdXHQm25qoRZJN1TNhb2+OZ0PRxJSW4FSAGEVSNBK5fjKogq+uadXMFH72g/EGNr5CwlZyis=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ke1L1p+jqz6mg/N1DW02NMBe5CuSAZTNtUlTwqMxcGqubNCrahmc0O7MhUbrgfHJPK2xWsRUSHJeAbLbZle9c8Oj7YBdVGS/Gy0vU6Q106EgswyiL2/a5ZcTRCzgYk/fhARI//3IAFjErXrMNf+YBeybHVHdosgsDVkoXftLNUk=
Received: by 10.114.175.16 with SMTP id x16mr4659295wae.1193719805079;
        Mon, 29 Oct 2007 21:50:05 -0700 (PDT)
Received: by 10.115.48.11 with HTTP; Mon, 29 Oct 2007 21:50:05 -0700 (PDT)
In-Reply-To: <b0943d9e0710291011p11bd8901udeb758fa653610bc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62661>

On 10/29/07, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 26/10/2007, Aneesh Kumar <aneesh.kumar@gmail.com> wrote:
> > $ stg branch --create test v2.6.24-rc1
> > Checking for changes in the working directory ... done
> > Don't know how to determine parent branch from "v2.6.24-rc1"
> > Branch "test" created
> > [test@linux-review-ext]$ git log
> >
> >
> > Throws an error/warning in the above command.
> >
> > Also import then gives
> >
> > [test@linux-review-ext]$ stg import
> > /home/opensource/patches/ext4-patch-queue/ext4_mballoc_freespace_accounting_fix.patch
> > Checking for changes in the working directory ... done
> > fatal: cebdeed27b068dcc3e7c311d7ec0d9c33b5138c2 is not a valid 'commit' object
> > stg import: git-commit-tree failed with code 128
>
> What version of StGIT are you using?
>


Latest stgit.  d4356ac6143757131b58c95ca5c6a7b386cc6087


> You could try 'stg branch --create test v2.6.24-rc1^{commit} but I
> thought latest StGIT adds this by default.
>


-aneesh

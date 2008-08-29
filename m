From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: How to create a branch without any links to the others branches
Date: Fri, 29 Aug 2008 19:34:53 +0700
Message-ID: <fcaeb9bf0808290534w5025b436s1087bb6a0ffcb16f@mail.gmail.com>
References: <38b2ab8a0808290127o32621d09vac07e7811e6e8139@mail.gmail.com>
	 <81b0412b0808290227g328b793cl58a606e718b4b3ff@mail.gmail.com>
	 <38b2ab8a0808290237l703b0394rad8f42c091d7143f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org
To: "Francis Moreau" <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 14:37:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ3Dn-0000sz-Bb
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 14:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbYH2Mez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 08:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbYH2Mez
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 08:34:55 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:23893 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbYH2Mey (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 08:34:54 -0400
Received: by fg-out-1718.google.com with SMTP id 19so532623fgg.17
        for <git@vger.kernel.org>; Fri, 29 Aug 2008 05:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=51C7bTe+4cjfUD/tHcF/WVw39ww7TPNy6Ohx+CvyQJw=;
        b=dLzDkoP1TATiTXxXiGfvj5h5byCTEYoplW+glOZtm63ErDFNbqildpqKN7vzG2lQse
         BJlDfBT13Dk9kQ9wXba3axr7fGOFor1oBdW2xVykaqAsaAmGNEOse47fbpcpcSConL19
         4EA5MUMhR8ar78PEuiwdv0Rg93dgwXjKH01VA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=uLjQo/6n6BnBWr1Iov/EwxUWjBJEhlYFJRpfNvtexFV2Pu9AE+ztPN6ECNY6qUYLS8
         QRCz/IsAQ74q51GIwYGsMoAL2Bt1Vs5aP6OBP7t83ePCZxpk3MNsWH1goplfgfiFIL+I
         0m1LOhi5B8ExfhZsdsbXBuYqLbugt1+hFPKPo=
Received: by 10.86.96.18 with SMTP id t18mr2025205fgb.78.1220013293082;
        Fri, 29 Aug 2008 05:34:53 -0700 (PDT)
Received: by 10.86.30.20 with HTTP; Fri, 29 Aug 2008 05:34:53 -0700 (PDT)
In-Reply-To: <38b2ab8a0808290237l703b0394rad8f42c091d7143f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/29/08, Francis Moreau <francis.moro@gmail.com> wrote:
> On Fri, Aug 29, 2008 at 11:27 AM, Alex Riesen <raa.lkml@gmail.com> wrote:
>  >
>  > $ rm .git/HEAD
>  > $ echo ref: refs/heads/NEW-BRANCH-NAME > .git/HEAD
>  > $ git commit
>  >
>
>
> well, it looks pretty git internal hack thing to me.

There is an old thread that uses "git symbolic-ref" or something
instead of "echo...", it would look less hacky. Or you could create a
new repository, make a new branch there, then pull that branch to your
repository.
-- 
Duy

From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: git submodule when submodule is not a clone of a repository
Date: Fri, 18 Jan 2008 18:46:03 +0100
Message-ID: <8c5c35580801180946q3ba824e2s4c32ac504166c684@mail.gmail.com>
References: <loom.20080118T171433-93@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Sergio Callegari" <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 18:46:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFvIb-0003ec-8f
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 18:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763004AbYARRqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 12:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762957AbYARRqH
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 12:46:07 -0500
Received: from nz-out-0506.google.com ([64.233.162.239]:2128 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762803AbYARRqG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 12:46:06 -0500
Received: by nz-out-0506.google.com with SMTP id s18so884269nze.1
        for <git@vger.kernel.org>; Fri, 18 Jan 2008 09:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=nl3AVKfXtQsbXWQgGZ4HkIRgPn1tOcNWVEPYdf8FbAc=;
        b=rafKn6E813Lu36N4chw8xC9t4/GOGUulXxqHf97LeYjQdouu417O+tezIBoOySfGCuU4BHZHQFFP+4Akj+oFPjoE1ascD5Jw/yn1BlxwHdGP/BcX+BQBTTANdxk7a6G8by0cUiSBZAcyg9UeBsgNcKe6wDPEwx9rYluM/tNptxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VLFhJfy6j1msQtWoGDJg02gWxcHLL1F2pQS8q9fSCc/7LbQt7agJnFmFqpv4NLb1bsetJn5oyerZ3iRTd8+TUJ6QniYewf2z9H+nxjoOfdb45W9euOHW0TPZKt7IH3KJ8gvol7PdPFSJ+wPD4egtCbYIRPXt37ATZubcEvPR94k=
Received: by 10.114.59.1 with SMTP id h1mr1273670waa.39.1200678363161;
        Fri, 18 Jan 2008 09:46:03 -0800 (PST)
Received: by 10.114.241.8 with HTTP; Fri, 18 Jan 2008 09:46:03 -0800 (PST)
In-Reply-To: <loom.20080118T171433-93@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71044>

On Jan 18, 2008 6:25 PM, Sergio Callegari <sergio.callegari@gmail.com> wrote:
> Would it make sense to have a git submodule update not try to fetch if there is
> no url defined, but still checkout the right commit for the submodule (rather
> than skipping the submodule at all) ?

Actually, we could (and probably should) teach git-submodule not to
fetch if the requested SHA1 is already available in the submodule, and
I guess this would solve the problem quite nicely for your usage.

But that will probably not happen before 1.5.4.

--
larsh

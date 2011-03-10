From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Using libgit2 code in git.git as a Google Summer of Code project?
Date: Thu, 10 Mar 2011 05:55:49 -0600
Message-ID: <20110310115549.GA31046@elie>
References: <AANLkTinqem5e0+vxzR64s1Y9o7B8RgEFXcm0HV_jeZ4Y@mail.gmail.com>
 <AANLkTikkFDLKn5KMaSTwUABBVX_vYDj8pW1kqmsm1_vy@mail.gmail.com>
 <20110310101332.GC26851@elie>
 <AANLkTikQ3x9A6v3y698_om_4_qB87Zpi_kG3u3=d+Dur@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: libgit2@librelist.com, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Vicent Marti <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 12:56:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxeTL-0006fV-Dw
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 12:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883Ab1CJLz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 06:55:58 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49906 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251Ab1CJLz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 06:55:57 -0500
Received: by gwaa18 with SMTP id a18so381420gwa.19
        for <git@vger.kernel.org>; Thu, 10 Mar 2011 03:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=agdtDBTQzIvhmMyE99gVa7tSPOCxni+gORFbL+loFkw=;
        b=KzCKA7nMZiiRnhiiwxwf80NBH1SLj57RhuCWJSQtInCZiu6GgWXdfMhM04zvRb7Iyy
         9MEeKWS6tESwgUwV0WH2+6la6ohddpKUSnBYLqZr0P2AYCWtaPlGvSTmcUErXyXz2ZpX
         SpQ/OKX8A1QAsQNq6yMDl7glrNcGWoKfYTlbc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pxlfGBvvE0qd2pkvM8WOjuNdEjDdBdMzWDNF5jI1E0YwFFadCw4oIrNqEF2MuylTmE
         7zYHsfpz+7PSqN3VxHW4r/obTvgBiNDWfJJFjAPZVRcUyUSAfB45menIZQVgF9b0cjK4
         pI3CkrgGF1SMRlNC7HyJyqFPLwuZUADJ/YA24=
Received: by 10.150.176.9 with SMTP id y9mr931841ybe.429.1299758157105;
        Thu, 10 Mar 2011 03:55:57 -0800 (PST)
Received: from elie (adsl-68-255-100-150.dsl.chcgil.ameritech.net [68.255.100.150])
        by mx.google.com with ESMTPS id q29sm2214373yba.14.2011.03.10.03.55.52
        (version=SSLv3 cipher=OTHER);
        Thu, 10 Mar 2011 03:55:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikQ3x9A6v3y698_om_4_qB87Zpi_kG3u3=d+Dur@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168813>

Hi again,

Two quick notes.

Vicent Marti wrote:

> I think that right now it would be a quite daunting task to start
> replacing parts of git.git with libgit2. The architecture changes
> required would be quite significant, because of the way that git.git
> and libgit2 are designed (Unix-only, non-reentrant/cross-platform,
> reentrant)

(Side note: git actually can be built with MSVC, though the build
process might be unfamiliar.  See compat/vcbuild/README for details.)

> On top of that, the API for the library is not
> yet stable, so that integration may end up being kind-of-wasted work.

This is precisely why I want to see attempts at using it starting
soon, whether as a student project or not: it would be a bad thing if
git reveals assumptions or limitations in the API requiring major
rework after the API has already solidified.

> So, personally, I don't know anybody interested on mentoring *that*
> specific task, but I'm certainly interested on mentoring a "help
> complete libgit2" task

Sounds good to me. ;-)

Thanks for explaining.
Jonathan

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Using libgit2 code in git.git as a Google Summer of Code project?
Date: Thu, 10 Mar 2011 04:13:32 -0600
Message-ID: <20110310101332.GC26851@elie>
References: <AANLkTinqem5e0+vxzR64s1Y9o7B8RgEFXcm0HV_jeZ4Y@mail.gmail.com>
 <AANLkTinqem5e0+vxzR64s1Y9o7B8RgEFXcm0HV_jeZ4Y@mail.gmail.com>
 <AANLkTikkFDLKn5KMaSTwUABBVX_vYDj8pW1kqmsm1_vy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: libgit2@librelist.com
X-From: git-owner@vger.kernel.org Thu Mar 10 11:13:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxcsJ-0001QM-DG
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 11:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147Ab1CJKNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 05:13:38 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33857 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980Ab1CJKNh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 05:13:37 -0500
Received: by ywj3 with SMTP id 3so581571ywj.19
        for <git@vger.kernel.org>; Thu, 10 Mar 2011 02:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Bi0aObCous74K2Aoy0zPQov96LM47fIZWSjbebjTuUM=;
        b=qJZ/IPx46bgL4O6ey1e6Ep0GipJhVOjN7FbhHRacSzlalpnnac7nJ75FBDb91+RiSr
         c2xyfXUGcWf/rVhrnnCKVtuRFIMuD3TS9ZHLHVIR3gNozmV0DsizgGNWIwGuiHGgIgBJ
         G//mHSDSDMkOIXsnjQI5qlZxGnjof1xOQhb48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jb+74mEpZ1qu1JfNxP8OI3yi7xdufS8VmeJCRSMgOW5/Lt7EyWhty4VlRzt01s/KRP
         5gSfUPlby34c7GOgN6zfYmFa9yQhqOwFP961IPjdIQO7SbMViSttjxfSKXgYiGAK77++
         papw+tEMK1uL34fZ8zhyEPhJ8wvFdKBoyGRVU=
Received: by 10.100.76.9 with SMTP id y9mr3505512ana.217.1299752016638;
        Thu, 10 Mar 2011 02:13:36 -0800 (PST)
Received: from elie (adsl-69-209-61-99.dsl.chcgil.sbcglobal.net [69.209.61.99])
        by mx.google.com with ESMTPS id c39sm1612996anc.7.2011.03.10.02.13.34
        (version=SSLv3 cipher=OTHER);
        Thu, 10 Mar 2011 02:13:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikkFDLKn5KMaSTwUABBVX_vYDj8pW1kqmsm1_vy@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168806>

Hey Vicent et al,

Vicent Marti wrote:

>                                                           there have
> been proposals to merge parts of libgit2 into the original Git client;
> however, this is not one of our priorities (we are designing git.git
> to be embeddable in Git backends and GUI programs), and the library is
> not yet stable enough for that kind of job. We'll see what the future
> brings -- git.git would certainly benefit from some of our code, if
> anything because it's (slightly) faster and cleaner than the original
> implementation.

I've been thinking that it would be interested to start this work
early on, partially so that libgit2 and git.git can get to know each
other better so to speak (which could help libgit2 along nicely and
help git get past some old limitations, I think).  So I'm thinking of
proposing stealing some of your code, with an eye toward eventually
making git "just another libgit2 user", as a Google summer of code
project idea.

Is that a sane idea?  Is there any particular subset of the lib that
would be an interesting place to start?  Do you forsee any obstacles?
Do you know anyone who might be interested in mentoring such a
project?

Admittedly I'm not so familiar with libgit2 yet, so I'm willing to
believe the answers might be no, no, yes, and no. ;-)

The Google Summer of Code application deadline is this Friday
(March 11) at 23:00 UTC.  If this does seem like a sane thing to do,
it might be nice to put it on the ideas page at:

  https://git.wiki.kernel.org/index.php/SoC2011Ideas

Thanks for your work.
Jonathan

From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile git)
Date: Fri, 3 Aug 2007 07:36:39 -0400
Message-ID: <fcaeb9bf0708030436q50322fbbne3a793d693e9f0e3@mail.gmail.com>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site>
	 <46B2D547.6050406@trolltech.com>
	 <fcaeb9bf0708030417y39f84db2lb0b202af57d8fccb@mail.gmail.com>
	 <46B31181.5020007@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Marius Storm-Olsen" <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 13:36:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGvSW-0004gS-1M
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 13:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760649AbXHCLgl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 07:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760635AbXHCLgl
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 07:36:41 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:18098 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759908AbXHCLgk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 07:36:40 -0400
Received: by an-out-0708.google.com with SMTP id d31so153881and
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 04:36:40 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fxZNtWPfnLbYvfdEWK8YPkRZAogM4i50sptzI2KZWBVFOr4mdIJpvPJDI4NEpIjN4+0VfCA9DG5F4mH4Xe6HJxped0QToX1g+n8Krzp18qnqx487BrHpwwr4A1Rf11P+JA5k5wLRm1O4AewZ858MNamUo9I1Dl5cZlgVbtwSaq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EeKprzl0Fo6LwttSuyiueVl6mMIwcfsgKr8dg7hocXFe2quI53UrC0rEyKKMq7w63em/FkyMOCrYXBEJ7oHRnV+vhwqeZl199YviVqJNNkjHV6UN8oryyWr0CxUAoRANg7xAShqT4u3/vzqrpQJa3VGa82OUQxOTr55lx6Zz7yc=
Received: by 10.100.168.13 with SMTP id q13mr1652984ane.1186140999884;
        Fri, 03 Aug 2007 04:36:39 -0700 (PDT)
Received: by 10.100.198.17 with HTTP; Fri, 3 Aug 2007 04:36:39 -0700 (PDT)
In-Reply-To: <46B31181.5020007@trolltech.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54705>

On 8/3/07, Marius Storm-Olsen <marius@trolltech.com> wrote:
> >> Great effort Johannes! The package work perfectly on XP. I'm
> >> trying to get it to work under Wine, but it (Wine) is not playing
> >>  nice with me at the moment. (The whole system barfs of "Access
> >> Denied" and other things. Grrr)
> >
> > Even if it installs ok under Wine, git may not work properly
> > because a bug in dup2() not duplicating to 0-2 and some others that
> > I think only affect tests. So get XP if you can or prepare to fix
> > Wine along the way.
>
> Yeah, I wasn't going to use it under Wine actually. Just wanted to see
> if I could get it building there, to ease automated packaging later.
> However, I've given up on it, due to a perl issue, which might be
> caused by the issue you describe.

You could cross-compile it. You'll need a cross toolchain, zlib stuff
and a good config.mak (I can send you one if you have trouble with
it).
-- 
Duy

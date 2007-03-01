From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: defaults for where to merge from
Date: Thu, 1 Mar 2007 01:07:07 +0100
Message-ID: <81b0412b0702281607l6f9b1cadg9f3a84b06b9acd7d@mail.gmail.com>
References: <es450f$d58$1@sea.gmane.org>
	 <200702281522.14965.andyparkins@gmail.com>
	 <Pine.LNX.4.64.0702281526270.15314@reaper.quantumfyre.co.uk>
	 <Pine.LNX.4.63.0702281643200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0702281045u2e511ebfie14a7b718531f8c4@mail.gmail.com>
	 <45E5DE8A.2080101@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Julian Phillips" <julian@quantumfyre.co.uk>,
	"Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org,
	"Paolo Bonzini" <bonzini@gnu.org>
To: "Paolo Bonzini" <paolo.bonzini@lu.unisi.ch>
X-From: git-owner@vger.kernel.org Thu Mar 01 01:07:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMYpF-0003Z8-Oh
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 01:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932800AbXCAAHK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 19:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932806AbXCAAHK
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 19:07:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:14524 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932800AbXCAAHI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 19:07:08 -0500
Received: by ug-out-1314.google.com with SMTP id 44so274389uga
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 16:07:07 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=izenW52KSIn5sDrrMt7Ta6Icdw+JYLZVqMbQE2XPM47N21Buc8OLaAomvkolonB8a2tu5qrqrdNy3QNekXNPyVNW0SCzl7ye3kZVVPhOPzViGNOnUisOs71YtXOUtM9lHHwQer7BJrd9lJFAVSEPTv7Yd7zV894pb1D9TWtkEaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fKc+pmSyW5ABUD0heFU3iSwnAQtAvtXyHfk8uBhvoKhweceYE1+tl0O1K3h37PK3xikunJNEecshg0O7+R5NS7bmcf8bZoGNtDznh6yeAO3BN/fW+cIWnOI3lNayAQrNZHYJfJ2aEYfBtT2Ilp94/0+epvqcBuQxNdwp+6bxR0U=
Received: by 10.78.204.7 with SMTP id b7mr106094hug.1172707627114;
        Wed, 28 Feb 2007 16:07:07 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Wed, 28 Feb 2007 16:07:07 -0800 (PST)
In-Reply-To: <45E5DE8A.2080101@lu.unisi.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41025>

On 2/28/07, Paolo Bonzini <paolo.bonzini@lu.unisi.ch> wrote:
> > As is an option to disable the feature. I.e. for scripts, which create
> > branches
> > blindly, without knowing they working on a remote branch.
> > So, please, provide an option to do what git-checkout/git-branch did
> > before:
> > which is just create the branch, nothing more.
>
> This does create the branch and nothing more.

... except ...

> It sets up "git pull" to
> do the obvious thing, but does not do anything more.  The branch is left
> in the same state than without the patch.  So the scripts will still
> work unless they create branches blindly, and blindly do a "git pull"
> expecting it to do the unobvious thing.

Well, I find it unobvious for pull to magically starting merging.
Perhaps I'm using branch configuration in .git/config for too long,
and actually expect nothing to be merged if there is no appropriate
branch configuration.

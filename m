From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: How to create branches above master
Date: Wed, 4 Aug 2010 08:07:56 +0000
Message-ID: <AANLkTik-qw3bFHWLwMnqJuzgu=HHSRiiVRBW2nfjRTy3@mail.gmail.com>
References: <29342864.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Bharani Prasad <bharaniprasadvs@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 10:08:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgZ1F-0006o5-PU
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 10:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756254Ab0HDIH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 04:07:59 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35743 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755754Ab0HDIH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 04:07:57 -0400
Received: by iwn7 with SMTP id 7so5951343iwn.19
        for <git@vger.kernel.org>; Wed, 04 Aug 2010 01:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=S9IiV//nnrD4xdlHkVQ+8SMcOXf1agvLXqAnl4bI73U=;
        b=maAWGEqviQFL/+7jd5yLtfNujBwYzChuwAmR3JvM9hKNWd9GFwgMaD/G8VjPPuS7FN
         pPKiNgL0dREq/gW9F5B4x3dzhX7lT6Xj9mEST/72A9uRepXBL2JGr/WYrLUTStYJGvlf
         TnTdZCwjkCled64uBk6QVv4nX3QwnggN6caXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=YqGqLFwPznBUMiNGTINVfgpgJ87+1wDJq+nxt0grsyfP9sOGF9NFTCUrzjThMme02b
         ASL73dU1W9SZhqQyfsSEs/9DpcOlJEIvwNATr8YEzKjyI8PAaWg6vZUI+LjwCdD1ps+h
         1SHBiOz7WDf3dDIXelTfYlNjFDSnve/SH/j/0=
Received: by 10.231.171.3 with SMTP id f3mr10057036ibz.145.1280909276730; Wed, 
	04 Aug 2010 01:07:56 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Wed, 4 Aug 2010 01:07:56 -0700 (PDT)
In-Reply-To: <29342864.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152565>

On Wed, Aug 4, 2010 at 07:22, Bharani Prasad <bharaniprasadvs@gmail.com> wrote:
> I am using git-repository along with gerrit server for code review, I want
> to create branches called "Integration" branch & "Release" branch

What's stopping you? See git-checkout(1) for how to create branches.

> I got different projects which I need to integrate in "integrate" branch and
> give it to testing and once the bugs are fixed it should go to "release"
> branch.

See git-merge(1) et al for how to merge branches.

> Please do help me with this issue, as it is critical...

Please ask more specific questions if you'd like useful answers.

> And also can you suggest me what can I use for Continuous build system in
> Linux Fedora

Buildbot? Any of the intersection between Google's results for
"continuous integration" and "git". They're all good.

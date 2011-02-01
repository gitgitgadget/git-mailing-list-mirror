From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Features from GitSurvey 2010
Date: Tue, 1 Feb 2011 12:42:13 -0600
Message-ID: <20110201184213.GF3771@burratino>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com>
 <20110129231310.GA11088@burratino>
 <vpq62t3ejje.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Feb 01 19:42:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkLBM-0004Tn-Ok
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 19:42:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062Ab1BASmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 13:42:23 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45929 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297Ab1BASmW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 13:42:22 -0500
Received: by vws16 with SMTP id 16so2501081vws.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 10:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=RLJ+Ly6Ghr97b5uvCqqwR2qwVUBf6N3UocNDPSZGQ2A=;
        b=Gv8bH97i5dBPtWVzNQrB/9d6LiFus0wrGe+5eVlKKcvmK1l29r0wrDObX7XKksekwA
         BhvZJ6G/f5dIvrpBjCdxPkD6SrxSJFzIj2o9uHWHKE4hPCU/F0VtTL9qJRxKjcMHwYZy
         ZNJo3IGQhbvmC39iGsXwwUMoQ7M9rx1W2mano=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=I0sObYTCcCBAGu/pYjEh7mfSNLJSqHaJefy2Ba/k3vh5oa6pAvdnMFqhW0FB3wkq4y
         ptIMcnFPXvacYYsXjXs2H7/j6ygktDoWuANrf4DwPACRBpsPt/RsT/atW7mV9voYY7tz
         qS1udmWpK4A2AzYTjD9G6ZnUJvvcHmA1fbqtA=
Received: by 10.229.81.11 with SMTP id v11mr5457662qck.152.1296585741005;
        Tue, 01 Feb 2011 10:42:21 -0800 (PST)
Received: from burratino (adsl-69-209-75-28.dsl.chcgil.ameritech.net [69.209.75.28])
        by mx.google.com with ESMTPS id t7sm15842227qcs.16.2011.02.01.10.42.18
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 10:42:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <vpq62t3ejje.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165844>

Matthieu Moy wrote:

>>> support for tracking empty directories
[...]
> http://thread.gmane.org/gmane.comp.version-control.git/56310/focus=56348

Thanks!  I followed up a bit on this lead in the "tracking empty
directories" thread.

>>> advisory locking / "this file is being edited"
[...]
> That needs to be integrated with Git, but it should probably still
> remain out of the Git core, because different users would want
> different locking databases. Hooks and git-* commands in the $PATH are
> probably sufficient.

Yes, a nice side effect could be the addition of a couple of hooks.

An rcs-style workflow (lockable files absent from worktree until
locked) on top of git sounds fun.

From: "Aubrey Li" <aubreylee@gmail.com>
Subject: Re: git clone problem through HTTP
Date: Fri, 20 Apr 2007 21:38:18 +0800
Message-ID: <6d6a94c50704200638y7cd3c81aj3ff7f78863f4ab8d@mail.gmail.com>
References: <6d6a94c50704200015p65dc4a8dn4abd8aaed35b9521@mail.gmail.com>
	 <Pine.LNX.4.64.0704201245330.10595@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Julian Phillips" <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Apr 20 15:38:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HetJp-0007Nl-R2
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 15:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbXDTNiV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 09:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753537AbXDTNiV
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 09:38:21 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:28581 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbXDTNiU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 09:38:20 -0400
Received: by an-out-0708.google.com with SMTP id b33so930735ana
        for <git@vger.kernel.org>; Fri, 20 Apr 2007 06:38:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AesYeXywXDEjomXl10KN+ARYXl2fuE2xeH1UbY/4GReelm+cwJplkUXnfyesBGzdqlfNcDjfezYvsG/6zbfdv3lmBkEGEsEQAKwaPxJJ/lqAgc7BWSTtyVxIxtHSxzxs4jK8UtfThieWtuIEnnZkQoNFaNkRVZq6zSO3IUlOytg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FGTfy3SRR+FSbNKrHuDHfCzD/mucYQPMobhqi7XcbgsdJ5uE3zotM1Tn9lE5SHtVXXPeen3TML9MZyKRCuLGQhRAdstaqieskudPf0b6tj3Z2jNXx31GMT5l7P9JN0nwdLCtg61DpWE/eWLtmL6k3Coiozgcgu/RbPWJTR2tUBE=
Received: by 10.114.202.15 with SMTP id z15mr1244052waf.1177076299012;
        Fri, 20 Apr 2007 06:38:19 -0700 (PDT)
Received: by 10.114.146.20 with HTTP; Fri, 20 Apr 2007 06:38:18 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0704201245330.10595@reaper.quantumfyre.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45103>

On 4/20/07, Julian Phillips <julian@quantumfyre.co.uk> wrote:
> On Fri, 20 Apr 2007, Aubrey Li wrote:
>
> > I'm behind of a firewall on which the git port is not permitted, so I
> > can only use http protocol. Unfortunately, I can't clone linus' git
> > tree at all.
>
> Linus packs his refs, which means that currently you can't clone using
> http, with any version of git.

I really don't understand why packed refs or not depend on the protocol.
It doesn't make any sense.
>
> Try http://repo.or.cz/r/linux-2.6.git/ instead?  This appears to be a
> straight clone, but without packed refs.

Does git support to update working copy to a different URL? for
example, I clone the repo through GIT, and switch the working copy to
HTTP, is it possible?
Or clone it from http://repo.or.cz/r/linux-2.6.git, and switch it to
www.kernel.org?

-Aubrey

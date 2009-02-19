From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: merge smart enough to adapt to renames?
Date: Thu, 19 Feb 2009 14:58:52 -0500
Message-ID: <81bfc67a0902191158x5f0f92d1p7e4af2f9cda50a12@mail.gmail.com>
References: <81bfc67a0902182212h578e677ck6029c56cb86f7bce@mail.gmail.com>
	 <slrngpqquq.j03.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 21:00:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaF4J-0007cE-Gw
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 21:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756235AbZBST64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 14:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753571AbZBST64
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 14:58:56 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:51440 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565AbZBST6z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 14:58:55 -0500
Received: by qyk4 with SMTP id 4so938986qyk.13
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 11:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=id/9rXZBF8/EWvVebJhQWDi4AzF4nvXviJARaSTodaI=;
        b=aRxQdQkeTViHMEab/8oDVbalpm1gdsSeOl4mL5CU9a6EoKuY4hSWZ1KO0iXAl5ubWp
         50n5SBEz/r1zPZ30mb6KfysObFnvjPG5QRPx383GG1jEG5w0ASbA1O+oa08ND+SkjfQ1
         UATC9MJeKqp/J7Nl4H+CxfDguqY3StAMS5CCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SBqu5VgUuYWLCfVnUQY6ZELe7+RoRLrg70g1p4b8S22i8cG7kmiBfYARP8vFG9oF/n
         pXhAYvI8XRf4fjhtm2r7fsnZYiRr0Tep4lS4avTdrlq4gq2X/RICt4KjHZKkHA+WCFgD
         liKCIjF7bKxxGAt1okVVSWDWIobOV9IMve8Q8=
Received: by 10.229.84.213 with SMTP id k21mr4320582qcl.19.1235073532170; Thu, 
	19 Feb 2009 11:58:52 -0800 (PST)
In-Reply-To: <slrngpqquq.j03.sitaramc@sitaramc.homelinux.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110737>

> Yes.  I maintain two copies of something (in different
> repos) like this...

nice... now the real kicker if I merge from another branch
sunrise/reviewed and redirect it's package.mask to
package.mask/sunrise will git be smart enough to differentiate from
the gentoo.org one and the sunrise one? I think even more important is
how would I even tell it to do that once I've moved the first one.
-- 
Caleb Cushing

http://xenoterracide.blogspot.com

From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: rebase vs rebase -i
Date: Thu, 4 Feb 2010 14:57:13 -0500
Message-ID: <76718491002041157o37de139brb7995076274375aa@mail.gmail.com>
References: <76718491002032019i5f8ea947paa527988ddb7a378@mail.gmail.com>
	 <alpine.DEB.1.00.1002041414530.4505@intel-tinevez-2-302>
	 <76718491002040914t12956bb2gbe21ae89f31cbc7f@mail.gmail.com>
	 <alpine.DEB.1.00.1002041859000.4505@intel-tinevez-2-302>
	 <76718491002041010k84ad55ct5c3e80529e8f8428@mail.gmail.com>
	 <alpine.DEB.1.00.1002041946170.4505@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 04 20:58:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd7qp-0005yO-Vv
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 20:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681Ab0BDT5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 14:57:50 -0500
Received: from mail-iw0-f189.google.com ([209.85.223.189]:59335 "EHLO
	mail-iw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932988Ab0BDT5P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 14:57:15 -0500
Received: by iwn27 with SMTP id 27so92213iwn.5
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 11:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=cUkae0JHjEOmfpSqj8NHr+8ROo7DzqljExhUAYNJiGM=;
        b=g0d/M2WGfeGRFwaRyOyIUfSSC7i+1JBMH/haMAtFJRQWKaHhJr4KtO+3X+zAXVcaN9
         kXFeqTVZPLMF860UIMGaDmB6y8WbdqdLp+0Fal4PdrO5OX9Gsx25PBZzOXJDWKHSmkVU
         aumGrQIjG7xDX+ACSx6Yq47Sw0rzK0dKuG4Ww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=jzduIUZUYJ+flHWLoqU4t1EENC0S0mzkhViaZmgsp/HZPneJTWY3W+Hp2prdUBAI5S
         Y7dape9NGyo+QQgaCHD42FEa3hkTZWYkOmvoe3leObmTZLlXDymW5OTAQuWUE4TcZafT
         yo4HYVyXv/tfRhVYib8YLibmb/DFeeLzMLWR0=
Received: by 10.231.166.68 with SMTP id l4mr607221iby.40.1265313433716; Thu, 
	04 Feb 2010 11:57:13 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1002041946170.4505@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139000>

On Thu, Feb 4, 2010 at 1:46 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Both "rebase -i" and "rebase -m" are really a cherry-pick in a loop.

Well then I'm still confused. I see where pick_one() in
git-rebase--interactive.sh is using cherry-pick.

But call_merge() in git-rebase.sh is using git-merge-recursive (absent
specifying another strategy).

?

j.

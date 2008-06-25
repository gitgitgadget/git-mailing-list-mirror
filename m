From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-fetch remote tag to local branch fails
Date: Wed, 25 Jun 2008 02:10:38 -0700 (PDT)
Message-ID: <m3bq1pkhh3.fsf@localhost.localdomain>
References: <33f4f4d70806240517h5e3ae420h263dd0c2d6bae459@mail.gmail.com>
	<8aa486160806240638o221b01d2i2f46cc8f0f3760a3@mail.gmail.com>
	<33f4f4d70806240701o1c00cef2g688a188970964b0f@mail.gmail.com>
	<8aa486160806240727r6fc6de6doec8300700293a3a7@mail.gmail.com>
	<33f4f4d70806240831q14caacddp66645e1bcfb6d14b@mail.gmail.com>
	<8aa486160806240911p49d7bcb8q82a8d68c51206543@mail.gmail.com>
	<33f4f4d70806250150q41f09764m4ae0cc1cd6e15e30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-15?q?Santi_B=E9jar?= <sbejar@gmail.com>,
	git@vger.kernel.org
To: "Klas Lindberg" <klas.lindberg@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 11:11:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBR2i-000368-H1
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 11:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756108AbYFYJKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 05:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756114AbYFYJKm
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 05:10:42 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:33504 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756108AbYFYJKl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 05:10:41 -0400
Received: by nf-out-0910.google.com with SMTP id d3so117965nfc.21
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 02:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=+0z6caU/tEAmndFefkf4J3CiP0Cjl0mRdzxq2ybHmOg=;
        b=pwGWldWKiDHN1W9kn6DbOonaEL/Sqq4HGOgiok3xRhhWb7i+/oj3OMp2MTI3KB7QZk
         l/vtw9QMnp5dQPrreWsarPVHHUHctl7Awmb7BO95zCY3cF1ZDZo3JQEg3KlVDlVFeeij
         I4GwF5Yf7QJRvWN2A5TCV1Y6o9pCD7VtPO60w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=G2ezXxNeMaBWj0izHlFj7cmnaBTL89aw2mVYf2+JaSCaxodEptpeMOZU/hFf3akgD7
         tT3UzSJWTmvGF3rrfKp4SUTBbv/iZSFO6sE4V7wW3+gTzztE2TsSo+z1uAC+RlBxDcZp
         S0bmKHKcz/MLLIYZmxfaVjqH4bjHVwXqCvo/U=
Received: by 10.210.21.6 with SMTP id 6mr1340323ebu.3.1214385039054;
        Wed, 25 Jun 2008 02:10:39 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.223.44])
        by mx.google.com with ESMTPS id d23sm52398718nfh.11.2008.06.25.02.10.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Jun 2008 02:10:38 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5P9AX4R014291;
	Wed, 25 Jun 2008 11:10:34 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5P9AXkE014288;
	Wed, 25 Jun 2008 11:10:33 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <33f4f4d70806250150q41f09764m4ae0cc1cd6e15e30@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86258>

"Klas Lindberg" <klas.lindberg@gmail.com> writes:

> Note that I'm not trying to solve the problem addressed by the
> submodules system in git; I need configuration management.

Why not use one of existing tools (see InterfacesFrontendsAndTools
page on Git Wiki, http://git.or.cz/gitwiki/), like IsiSetup, or
etckeeper?

-- 
Jakub Narebski
Poland
ShadeHawk on #git

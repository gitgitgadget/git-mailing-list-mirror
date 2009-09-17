From: Nick Edelen <sirnot@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2009, #04; Wed, 16)
Date: Thu, 17 Sep 2009 18:03:28 +0100
Message-ID: <c77435a80909171003g3e2fe9f6sa2e528459fa790f0@mail.gmail.com>
References: <7v1vm6kskd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 19:10:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoKV3-0004EU-J7
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 19:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbZIQRKT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Sep 2009 13:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752496AbZIQRKS
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 13:10:18 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:58845 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328AbZIQRKR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Sep 2009 13:10:17 -0400
X-Greylist: delayed 412 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2009 13:10:17 EDT
Received: by bwz6 with SMTP id 6so172435bwz.37
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 10:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=S9XAKe9fI7X/l+oH6lonCgccC2Zqg/cpxXXhX32PvmI=;
        b=ubnFsNDcSn++zmMCJWsaR45nP/H0xR5/0Prc1NS/+GdudGC0KLDP2x+o84i9PRmtb2
         qn6ROrR7obJ1rdQpVvZRjR0rDNbk+o2nkG8Y6Doc11yR4j1QV3haPvB8g5kTyrhHYRNa
         prUpuuR2voQn15OHSLqANk7YTlorIQ8QaCLmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QqkTH7cGcm05mv/ZW0xmZxUVv7/NXBiR09BYZ7FO6No+y4KOJRxATeGncGYhCRGq6x
         gCwSGyz787EgPRWFWK8wbNjncqWpmObLnBJL3pg1FaAcQzwS1fDsE3dfLZ7OA9ZQgKmV
         AgpbVTIIzVETfvFycoMXPsaS8Xj5stZyJev0g=
Received: by 10.204.156.217 with SMTP id y25mr569365bkw.182.1253207008868; 
	Thu, 17 Sep 2009 10:03:28 -0700 (PDT)
In-Reply-To: <7v1vm6kskd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128765>

> * ne/rev-cache (2009-09-07) 7 commits
> =A0. support for commit grafts, slight change to general mechanism
> =A0. support for path name caching in rev-cache
> =A0. full integration of rev-cache into git, completed test suite
> =A0. administrative functions for rev-cache, start of integration int=
o git
> =A0. support for non-commit object caching in rev-cache
> =A0. basic revision cache system, no integration or features
> =A0. man page and technical discussion for rev-cache
>
> Replaced but I do not think this is ready for 'pu' yet.

Er, what direction would you suggest taking to bring this patchset up
to scratch?  I've run several tests locally, and it seems to work as
intended, but I wouldn't assert that I've taken every possibility into
account.  Should I submit some tests/benchmarks in more real-world
environments?  I'm afraid that I'm not personally among the intended
audience for this, so I don't have a really solid idea of how this
might perform in the wild.

 - Nick

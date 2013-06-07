From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Dependencies and packaging (Re: [Administrivia] On ruby and contrib/)
Date: Fri, 7 Jun 2013 14:29:37 -0500
Message-ID: <CAMP44s0ko1T96J7u3xdrZgxnvG_JwizLyWqFuginujggDCQD_w@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<rmivc5rp9w2.fsf@fnord.ir.bbn.com>
	<CAMP44s07p0vpS_2cjAjB=QWoZjjPSuAm09xwk4BjAAD+hsJrSw@mail.gmail.com>
	<rmisj0vnorm.fsf@fnord.ir.bbn.com>
	<CALkWK0kQSuvv9owUYxatKTKW+GEpR0kL6XsyrOJD66yfodycUQ@mail.gmail.com>
	<20130606213124.GB12924@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Troxel <gdt@ir.bbn.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 21:29:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul2M2-0007St-Uy
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 21:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999Ab3FGT3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 15:29:39 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:32840 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608Ab3FGT3i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 15:29:38 -0400
Received: by mail-lb0-f171.google.com with SMTP id 13so1346405lba.2
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 12:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DwqK3mQHc5NqSO6J3DperPRb6mjg3/DZtHlYLW45fwM=;
        b=vQzf29ecJjWBSlYOBnZtSW6Yu1mLUQls0ulG2Y1weogP8yaTaM/BKOfUs+ClVuoJwC
         BVjAbTxTtVoziTfu4Rw+pStoJ3uzIcVGJBLGueQDLTsrz8Nk2wMSqGBotX/QERRWQkJ3
         4xQ9qsZHBx7C0eh67jA95WIfdU5R+0oA/TBLpJmP18kzU+ZTncHCnWu9t+IyK6h2v20G
         8wbD5js7WD4TESpaISWKFc/HOqP3e5xL/ki8s/xvCb+fYmwqcjd1P91SNF0z5Q9zn0Tv
         k/w0wn6mXF3Nl7DZ0d+QEk68lQHOpH/6O4fnqv2MMMDYIqbE6CjxgOPbdkGmVSJEbE3w
         kvcA==
X-Received: by 10.152.22.73 with SMTP id b9mr75867laf.36.1370633377193; Fri,
 07 Jun 2013 12:29:37 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Fri, 7 Jun 2013 12:29:37 -0700 (PDT)
In-Reply-To: <20130606213124.GB12924@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226682>

On Thu, Jun 6, 2013 at 4:31 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ramkumar Ramachandra wrote:
>
>>                                      Git is probably the _last_ thing
>> to be complaining about when it comes to packaging.
>
> It would be nice if contrib/ files supported the usual "make; make
> install; make clean" targets.  That's missing functionality that does
> matter to at least one packager.
>
> It would be nice if the dependencies associated to each piece of
> functionality or makefile flag were documented more clearly.
> Currently when e.g. features of gitweb gain dependencies I don't
> notice until the testsuite fails.

Here's a good example how to do that:
https://github.com/felipec/git/blob/fc/master/contrib/remote-helpers/Makefile

-- 
Felipe Contreras

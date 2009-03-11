From: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
Subject: Re: Generalised bisection
Date: Wed, 11 Mar 2009 22:14:28 +0000
Message-ID: <efe2b6d70903111514r2855d910heac71bc0029d2766@mail.gmail.com>
References: <efe2b6d70903081840v18e77aa7w2dac2bed553d0d6a@mail.gmail.com>
	 <200903100808.15875.chriscool@tuxfamily.org>
	 <efe2b6d70903110159h78de744yc141effaf5aa0821@mail.gmail.com>
	 <43d8ce650903110235q5e2a59f6t201d5e65a4937476@mail.gmail.com>
	 <alpine.DEB.1.00.0903111304520.10279@pacific.mpi-cbg.de>
	 <43d8ce650903110508o3d12f32m8202fae750d215a@mail.gmail.com>
	 <alpine.DEB.1.00.0903111358260.10498@intel-tinevez-2-302>
	 <43d8ce650903110624t47e37b19n3fc72e3243978200@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 23:21:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhWij-0000pj-LK
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 23:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655AbZCKWOc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2009 18:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753488AbZCKWOc
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 18:14:32 -0400
Received: from mail-fx0-f176.google.com ([209.85.220.176]:51038 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbZCKWOb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 18:14:31 -0400
Received: by fxm24 with SMTP id 24so180719fxm.37
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 15:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iKjqgUcgbVrykbPjWYRyyFvKspr2V00kdd92To6S8lk=;
        b=Td/5FfOnp16yLuD9SgBjLabCWWo15hmHl7ObCalZaIEruDVIlRLWq3oOkhaBG52yh9
         QxuOFaGYmukLJImvR8BrniREuFrDbfjCHqyBXFJ257b0npNQdpQyox1bvAYpHLc46XGq
         MS4j+V66OZptdjKHY1vCULtTbZJq4+0w4v9vI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bK/nt/nXw47DOkzoZXMLR67Ni1HjEzZdnyw2/8fj3SKjIfAHUcHr0HYbatnj7Gkr3+
         qyCFsojZy36PGGzYomqbqD8myHOPC/GBi18OUUF4b/x/n5RQtRcMpSfqgtyfYi8adle/
         XUlfD26fjail8G0ceyHwoQv9mzxslJ+iItqio=
Received: by 10.204.62.82 with SMTP id w18mr257621bkh.129.1236809668854; Wed, 
	11 Mar 2009 15:14:28 -0700 (PDT)
In-Reply-To: <43d8ce650903110624t47e37b19n3fc72e3243978200@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112983>

[John will get this twice, sorry]

On Wed, Mar 11, 2009 at 1:24 PM, John Tapsell <johnflux@gmail.com> wrot=
e:

> =A0 Not
> quite sure how it would fit in though (I'd rather it was called from
> "git bisect" rather than adding another separate git command)

I guess the most obvious route would be to add an option to 'git bisect=
 start'
 to specify that it should be used instead of the usual algorithm.

Ealdwulf

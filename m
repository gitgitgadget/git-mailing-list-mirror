From: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
Subject: Re: Generalised bisection
Date: Fri, 13 Mar 2009 10:00:53 +0000
Message-ID: <efe2b6d70903130300q4ea2aa99q7e956d3bcbcfec4c@mail.gmail.com>
References: <efe2b6d70903081840v18e77aa7w2dac2bed553d0d6a@mail.gmail.com>
	 <200903100808.15875.chriscool@tuxfamily.org>
	 <efe2b6d70903110159h78de744yc141effaf5aa0821@mail.gmail.com>
	 <43d8ce650903110235q5e2a59f6t201d5e65a4937476@mail.gmail.com>
	 <efe2b6d70903111515p2b9f656bp186d0b3cc7ae483d@mail.gmail.com>
	 <43d8ce650903112345x3d40b70ap7e4c0f8c7d0b6069@mail.gmail.com>
	 <alpine.DEB.1.00.0903121154560.10279@pacific.mpi-cbg.de>
	 <d9c1caea0903121102y5452603fua0e7a1b82e121b01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	John Tapsell <johnflux@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>
To: Steven Tweed <orthochronous@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 11:10:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li4Ld-00036S-1P
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 11:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063AbZCMKIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 06:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752331AbZCMKIl
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 06:08:41 -0400
Received: from mail-bw0-f175.google.com ([209.85.218.175]:51245 "EHLO
	mail-bw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbZCMKIk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 06:08:40 -0400
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Mar 2009 06:08:39 EDT
Received: by bwz23 with SMTP id 23so53583bwz.37
        for <git@vger.kernel.org>; Fri, 13 Mar 2009 03:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7yr4u2CnGkVCmk14dMqmFyLczCZ1PBSyjhaEO8I2xXI=;
        b=aCvh9A5MIkjdD3uBoegcRbylRvzlwP1VdUGruFVK/fGC6SqdxVOi/R7y5Lzcd0HZW0
         S+dvBKGQyQnJrrbrwgUFac12CFWGLhU9hVpQtmPg6/wD4PCGM6xAZ/Yi/k0LDxSRpMac
         i5iIyF2qOOFt/swgU+TGU7WcJFDNeSQgS06xU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=S4l8GsWeTLmXAgpwJpc85t241B9ihGzxEQtZhoJLPlxxof0FhFRoS+OMrbw70Twbzk
         eJ7Y8HaXoBps1AOx/i9waV2ogX0XgR0XiqTdmGl0pun29uZC4O15NA34JZ5oqgjn+Bvc
         lklzlm5gtaX6li738UHveXtFfXJDvmNF2KsSQ=
Received: by 10.204.57.79 with SMTP id b15mr336513bkh.172.1236938453488; Fri, 
	13 Mar 2009 03:00:53 -0700 (PDT)
In-Reply-To: <d9c1caea0903121102y5452603fua0e7a1b82e121b01@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113163>

On Thu, Mar 12, 2009 at 6:02 PM, Steven Tweed <orthochronous@gmail.com> wrote:

> I haven't even looked at the source code so a description of the
> mathematical algorithm would help, but I'll just point out that
> underflow (in the case of working with probabilities) and overflow
> (when working with their negated logarithms) is inherent in most
> multi-step Bayesian algorithms. The only solution is to rescale things
> as you go so that things stay in a "computable" range. (You're almost
> never interested in absolute probabilities anyway but rather relative
> probabilities or, in extreme cases, just the biggest probability, so
> rescaling isn't losing any useful information.)

Hmm, I'll have to think about that one.

Ealdwulf

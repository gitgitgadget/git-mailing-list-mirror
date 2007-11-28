From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Rollback of git commands
Date: Wed, 28 Nov 2007 11:23:30 -0500
Message-ID: <9e4733910711280823q5fa14120scb6371a1465efca5@mail.gmail.com>
References: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com>
	 <7vmyszb39s.fsf@gitster.siamese.dyndns.org>
	 <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com>
	 <9e4733910711271749q1b96bfe9i60e43619c89234b9@mail.gmail.com>
	 <3AAC5548-A9AC-4236-B1F7-5CFDE11B52C4@adacore.com>
	 <20071128162002.GB20308@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Geert Bosch" <bosch@adacore.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 17:24:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxPhX-0008Oq-Vk
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 17:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755669AbXK1QXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 11:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753859AbXK1QXc
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 11:23:32 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:10598 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbXK1QXb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 11:23:31 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1798223wah
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 08:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=xQIwWSNeg45XfZTCBr/svf17wwy3T8bx+XFDwdMXrEY=;
        b=o/wjSzRJ+ioxSQbDHUCEwD9mLO/X3CxrdwcSRKFcuHBy17jhNWlPc1gMgbjNb+owRqzARgrcUReO20hDsxittFc3m6hZZ+qDoGJ0alhRd2Aaz1VyfGBWBWwiPeFoynOPhUP5+n7FU0/PaK27gYlcRChuj11T/BA/OqsGXRDtu0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=x0Qok/0QlMUn17j4KP4pBbYdxEkj8mAnObdLsbno3BhIKEyBZJ3adwYkZWzs5a/8yDOadje9FlTs1/sgNU+Ns/heV1QVpvtzWA7iP73dj3mfvoOsWYO4PsgwAa1xBQuZ5W6XVNBWIb6Hva2gYxewp1y779zSh3NAJdVkflp7sfY=
Received: by 10.114.144.1 with SMTP id r1mr356359wad.1196267010952;
        Wed, 28 Nov 2007 08:23:30 -0800 (PST)
Received: by 10.114.160.3 with HTTP; Wed, 28 Nov 2007 08:23:30 -0800 (PST)
In-Reply-To: <20071128162002.GB20308@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66371>

On 11/28/07, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 27, 2007 at 11:07:29PM -0500, Geert Bosch wrote:
>
> > I have always wondered why refs and tags are not
> > in the regular object store. In a way, there
> > should be just one root pointer (SHA1) pointing
> > to a tree with refs, etc.
>
> Assuming that they also retain the "having an object implies having all
> of the objects it points to" property, then it makes it hard to talk
> about subsets or single refs. If I fetch from you and you communicate
> your repo state as some hash, then I am stuck getting _all_ of your
> refs to complete this property.

push/pull would still work at the branch level. The local state
tracking objects wouldn't be exchanged.

>
> -Peff
>


-- 
Jon Smirl
jonsmirl@gmail.com

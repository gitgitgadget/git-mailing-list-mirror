From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: remote#branch
Date: Wed, 31 Oct 2007 13:41:12 +1300
Message-ID: <46a038f90710301741n67526976vda1cd131270aa7f@mail.gmail.com>
References: <20071016210904.GI26127@efreet.light.src>
	 <Pine.LNX.4.64.0710280000240.4362@racer.site>
	 <20071029174000.GA4449@efreet.light.src>
	 <alpine.LFD.0.999.0710291112590.30120@woody.linux-foundation.org>
	 <20071029214925.GH21133@thunk.org>
	 <alpine.LFD.0.999.0710291545250.30120@woody.linux-foundation.org>
	 <20071030030104.GK21133@thunk.org>
	 <7vtzo9s221.fsf@gitster.siamese.dyndns.org>
	 <20071030044026.GA9600@thunk.org>
	 <alpine.LFD.0.999.0710292150400.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Theodore Tso" <tytso@mit.edu>,
	"Junio C Hamano" <gitster@pobox.com>, "Jan Hudec" <bulb@ucw.cz>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Petr Baudis" <pasky@suse.cz>,
	"Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 31 01:41:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In1ef-0000zc-Rg
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 01:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966AbXJaAlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 20:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754937AbXJaAlP
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 20:41:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:37683 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044AbXJaAlN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 20:41:13 -0400
Received: by ug-out-1314.google.com with SMTP id z38so229479ugc
        for <git@vger.kernel.org>; Tue, 30 Oct 2007 17:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=bb4W4drKQ6i3XwTMwOIfMX9RvEf+1FA21LT5Ng5yb1g=;
        b=rMMMMjW+d4LojNH94MQXw7vABbNqxzchsX6lMVJ081K4G6pYzoZa8aZc6HEXLxjwXxw4CmrOMZaUGlGZRhqGNcGRmzjxm1eC0PEeP3qAq3vv1TTPmQk2JJY0PL9gWr9JDjHx3qofyYmCXdkXtSR5tW0JgXhlEcSb6z5yWbKnxS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PM6rxQK9ZXyZriTNJwfpMa1X/xc4qJBd0EpNPr8qozqVJEpsm1Lxp1koSLEV5hEuG5sPukCwDc7ERzN8tF/pVVIifvzzFFMvlApJoJrk6lI30Z0i5MWYwerekLtLgq0pP793Vb0qzttgtfxT+tzEZYeOqhnPlWxw70PYWyUNcpE=
Received: by 10.67.103.12 with SMTP id f12mr683861ugm.1193791272182;
        Tue, 30 Oct 2007 17:41:12 -0700 (PDT)
Received: by 10.66.252.2 with HTTP; Tue, 30 Oct 2007 17:41:12 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0710292150400.30120@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62771>

On 10/30/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Quick! WHO THE F*CK CARES?

Ah, damn. In all the discussion & flamefesting to say that people
don't want to use the # character, noone talks about of what cogito
used it for.

Having something functionally similar to

  cg-clone git://foo.tld/bar.git#blue

would save a few steps -- and some potential confusion -- for projects
using GIT.

In case it's not clear what it does (not everyone here has used
cogito) it will create and checkout a branch tracking the "blue" head
on the repo when the clone is done. This is _instead of_ creating and
checking out the branch that tracks the configured "HEAD" of the repo.

IMHO is a quite nice thing to have -- and AFAICS we don't have it in
master or pu. I care about the shed for the bike, not its colour.
cheers,


m

From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: any problems with new branch of gitk?
Date: Wed, 15 Mar 2006 14:00:28 +0100
Message-ID: <81b0412b0603150500k11e69c5s95158b61fda3ca70@mail.gmail.com>
References: <17419.24973.402408.237865@cargo.ozlabs.ibm.com>
	 <20060306202340.GA5946@steel.home>
	 <17431.63509.670409.212654@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 15 14:01:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJVcV-0007mR-Md
	for gcvg-git@gmane.org; Wed, 15 Mar 2006 14:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbWCONAm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Mar 2006 08:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081AbWCONAm
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Mar 2006 08:00:42 -0500
Received: from nproxy.gmail.com ([64.233.182.206]:23972 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751923AbWCONAa convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Mar 2006 08:00:30 -0500
Received: by nproxy.gmail.com with SMTP id x30so72580nfb
        for <git@vger.kernel.org>; Wed, 15 Mar 2006 05:00:28 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jl5paBTqNrWYrMM0ykKKjN1mqcIqYc1BI+6TIO2bjKT/Gg5Pr05+xE9eW1UTPNrkczgHDkCrYjofYFvdnqVSnsNu+QY6KHH/F5YMhcGTjPvcgQf0HM8HIbGC3w8664C1yPFfOlOdsWJq1CYPl4j1VzvxjFhdTTN3Pkz3L/NGoiY=
Received: by 10.49.61.20 with SMTP id o20mr235394nfk;
        Wed, 15 Mar 2006 05:00:28 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Wed, 15 Mar 2006 05:00:28 -0800 (PST)
To: "Paul Mackerras" <paulus@samba.org>
In-Reply-To: <17431.63509.670409.212654@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17607>

On 3/15/06, Paul Mackerras <paulus@samba.org> wrote:
>
> > I don't if that was intended (see the screenshot attached), but some
> > lines miss arrows. Click on where the arrow would be works (jump to
> > counterpart arrow). Never have this with the old gitk.
> >
> > Tcl/Tk 8.4.9 (Gentoo).
>
> Yes, it seems that tk 8.4 can't draw arrows on the ends of diagonal
> line segments.  The old gitk coped with this by simply shortening the
> line until it got to a vertical line segment.  I can probably do
> better than that with the new layout algorithm.  I'll look at it.
>

Ok, thanks for confirmation. I wasn't sure if that's me, Gentoo, or tk.

On related note: do you know of any way to start gitk with sensible
layout under cygwin? I ended up with commenting out sourcing of
.gitk. It produces a window compressed in one block, which I can
resize and relayout later. Any other attempt to preset the size or
layout either can't be (literally) seen or can't be changed into something
usable.

From: Brian Swetland <swetland@google.com>
Subject: Re: `git-send-email' doesn't specify `Content-Type'
Date: Sun, 11 Nov 2007 00:45:15 -0800
Organization: Google, Inc.
Message-ID: <20071111084515.GB18021@bulgaria>
References: <87ode3klc7.fsf@chbouib.org> <Pine.LNX.4.64.0711100052290.4362@racer.site> <20071110101420.GA21353@bulgaria> <20071110122528.GA4977@atjola.homenet> <20071110123505.GA24445@bulgaria> <20071110125126.GA7261@atjola.homenet> <20071111083224.GA30299@sigill.intra.peff.net> <20071111083915.GA18021@bulgaria> <20071111084117.GC30299@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ludovic =?iso-8859-1?Q?Court=E8s?= <ludo@chbouib.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 11 09:46:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir8SD-0006vT-Jl
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 09:46:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747AbXKKIpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 03:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752896AbXKKIpu
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 03:45:50 -0500
Received: from smtp-out.google.com ([216.239.33.17]:57397 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbXKKIpt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 03:45:49 -0500
Received: from zps18.corp.google.com (zps18.corp.google.com [172.25.146.18])
	by smtp-out.google.com with ESMTP id lAB8jbff008965;
	Sun, 11 Nov 2007 08:45:37 GMT
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:to:cc:subject:message-id:references:
	mime-version:content-type:content-disposition:in-reply-to:organization:user-agent;
	b=MPj0/ipI28IG/tgUkuVoVrAwllkUOJwfAq7BQO4rs9lkefzgdq9gkCVRn0oZmQbx+
	qteszTtZ2OhBsHfnjudiw==
Received: from bulgaria (bulgaria.corp.google.com [172.18.102.38])
	by zps18.corp.google.com with ESMTP id lAB8jaRN024573;
	Sun, 11 Nov 2007 00:45:36 -0800
Received: by bulgaria (Postfix, from userid 1000)
	id B2CA08F45C; Sun, 11 Nov 2007 00:45:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20071111084117.GC30299@sigill.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64434>

[Jeff King <peff@peff.net>]
> On Sun, Nov 11, 2007 at 12:39:15AM -0800, Brian Swetland wrote:
> 
> > This issue with the encoding of the author got me thinking...
> > 
> > What happens if the metadata has utf8 content and the patch itself has 
> > some *other* non-ascii encoding (some iso-latin variant perhaps).
> > 
> > Is there any way to deal with that situation sanely other than indicate
> > that it's 8bit content and not specify an encoding?  Is that what
> > happens currently?
> 
> The body has to be in one encoding, so at the time that you know both
> encodings, you have to pick one and convert the data from the discarded
> encoding into the used encoding.

That seems potentially bad in that the transport (mailed patches) could
be altering the contents of the patch.  Or is this process reversed when 
the patch is finally applied?

Brian

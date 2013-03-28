From: Jeff Mitchell <jeffrey.mitchell@gmail.com>
Subject: Re: propagating repo corruption across clone
Date: Thu, 28 Mar 2013 09:52:47 -0400
Message-ID: <CAOx6V3Yx5CYGQXMY_LUy0mxpROZveYjitdAqY_hC4dRcMU9sXw@mail.gmail.com>
References: <CAOx6V3YtM-e8-S41v1KnC+uSymYwZw8QBwiCJRYw0MYJXRjj-w@mail.gmail.com>
 <20130325145644.GA16576@sigill.intra.peff.net> <CACsJy8A0eOWEJ2aqPSLof_CodJM6BadFxQHy5Vb0kAwwTSTS3w@mail.gmail.com>
 <20130325155600.GA18216@sigill.intra.peff.net> <CAOx6V3a6vGJvJ4HEmAXdTRKKCzRJS23OYd_em1b3aQLzPNEtQA@mail.gmail.com>
 <20130325200752.GB3902@sigill.intra.peff.net> <CAOx6V3ZWB1ZpmXcaBeSaPOvHqmAMF3U1rTXuwinFGmEZQwFGYQ@mail.gmail.com>
 <20130326165553.GA7282@sigill.intra.peff.net> <1364340037755-7580771.post@n2.nabble.com>
 <7vr4j1qzao.fsf@alter.siamese.dyndns.org> <1364410309241-7580845.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Rich Fromm <richard_fromm@yahoo.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 14:53:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULDGw-0001Z7-E6
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 14:53:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089Ab3C1NxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 09:53:11 -0400
Received: from mail-ve0-f172.google.com ([209.85.128.172]:47776 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755644Ab3C1NxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 09:53:09 -0400
Received: by mail-ve0-f172.google.com with SMTP id oz10so3040146veb.17
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 06:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=PhBiEUp8CiYbJrY1nko8KSU3t5UI7MRuvmoZlFYwUmg=;
        b=tTFQZHqEBvMV//yv58/hc7oT79VXicCN0JgKWd7AqXLeaVk10+vWV8DEI93gk678gc
         58Qc9AIcrPVrqH279y7011PyAhIaqLZXA1SJ2xmB++nmDoQ9gl+SlV0I2IXVrSctpGx+
         Ub3AFi9YiYftT9H+4KzBMhuU3HVNWyv/jRO9Itqgb5tzXCYRseLzwE5Zx0xEDRN6TvKr
         zrSiOORBglkOFNSmcLT2tMbdHLbmvJL6vQAClcxjZWkQb/6OAX3ugPacl17DGOSqUya9
         bic0y/EheuH+8Y88TbQ8pk/qvquzNFW9lDAHqMpPZYAkMa/CEOJ5fjIP+Tq5lofviqkJ
         b/VA==
X-Received: by 10.52.30.170 with SMTP id t10mr23025877vdh.4.1364478788878;
 Thu, 28 Mar 2013 06:53:08 -0700 (PDT)
Received: by 10.59.7.37 with HTTP; Thu, 28 Mar 2013 06:52:47 -0700 (PDT)
In-Reply-To: <1364410309241-7580845.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219397>

On Wed, Mar 27, 2013 at 2:51 PM, Rich Fromm <richard_fromm@yahoo.com> wrote:
> Nevertheless, I will try to contact Jeff and point him at this.  My initial
> reading of his blog posts definitely gave me the impression that this was a
> --mirror vs. not issue, but it really sounds like his main problem was using
> --local.

Actually, I wasn't using --local, I just wasn't using --no-local, as I
mixed up that and --no-hardlinks (which lies somewhere between, but is
still not the same as using file://).

It's entirely possible that you read the posts before I updated them.

Also, keep in mind, if you're evaluating what you're doing, that the
system we have was not set up to be a backup system. It was set up to
be a mirror system. With proper sanity checking, it would have acted
in a decent capacity as a backup system, but that wasn't why it was
set up, nor how it was set up.

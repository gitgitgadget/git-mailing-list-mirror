From: Jeff King <peff@peff.net>
Subject: Re: [RFC] pull/fetch rename
Date: Wed, 21 Oct 2009 03:47:59 -0400
Message-ID: <20091021074759.GB13531@coredump.intra.peff.net>
References: <200910201947.50423.trast@student.ethz.ch>
 <alpine.LNX.2.00.0910201912390.14365@iabervon.org>
 <20091021063008.GA3349@glandium.org>
 <7v3a5db6ij.fsf@alter.siamese.dyndns.org>
 <7v63a99pok.fsf@alter.siamese.dyndns.org>
 <20091021074522.GA13531@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Hommey <mh@glandium.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 09:48:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0VvW-0005r6-6x
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 09:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158AbZJUHr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 03:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753047AbZJUHr7
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 03:47:59 -0400
Received: from peff.net ([208.65.91.99]:59763 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752730AbZJUHr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 03:47:59 -0400
Received: (qmail 31808 invoked by uid 107); 21 Oct 2009 07:51:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 21 Oct 2009 03:51:38 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Oct 2009 03:47:59 -0400
Content-Disposition: inline
In-Reply-To: <20091021074522.GA13531@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130896>

On Wed, Oct 21, 2009 at 03:45:22AM -0400, Jeff King wrote:

> Declaring it a failure depends on what you consider the goal of "git
> remote update" to be. I find it very useful as a shorthand for "fetch
> from _all_ remotes"[1]. Which does save typing over
>
> [...]
>
> On Wed, Oct 21, 2009 at 12:22:35AM -0700, Junio C Hamano wrote:
>
>> *1* The only thing "git remote update" does that "git fetch" does not
>> is that it can serve as "fetch from everywhere" shorthand.  But that
>> is something we could have added to "git fetch".  So in that sense, I
>> think it may make even more sense to deprecate "remote update" and
>> teach "fetch" how to do that.

...and it would probably help if I had read your footnotes before
responding.

-Peff

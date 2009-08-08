From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to 
 significantly speed up packing/walking
Date: Fri, 07 Aug 2009 20:11:14 -0700
Message-ID: <7vfxc3ov8t.fsf@alter.siamese.dyndns.org>
References: <op.ux8i6hrbtdk399@sirnot.private>
 <alpine.DEB.1.00.0908061645470.8306@pacific.mpi-cbg.de>
 <4A7AEFA8.5010001@drmicha.warpmail.net>
 <c77435a80908061039p30b83511qb7c378cfd68a6cf6@mail.gmail.com>
 <alpine.DEB.1.00.0908062030340.8306@pacific.mpi-cbg.de>
 <4A7B95A8.2010000@vilain.net>
 <alpine.DEB.1.00.0908070808340.8306@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0908071029580.16073@xanadu.home>
 <c77435a80908071502y48d14a38h79eec14a1be8c6fb@mail.gmail.com>
 <7vzlabp7e4.fsf@alter.siamese.dyndns.org>
 <c77435a80908071553m6f7d5298p5ea68b9386198b3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 05:11:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZcLJ-0000tl-1r
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 05:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932931AbZHHDL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 23:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932900AbZHHDL2
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 23:11:28 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49396 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932893AbZHHDL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 23:11:27 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 42DF02C55;
	Fri,  7 Aug 2009 23:11:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2E112C52; Fri,  7 Aug
 2009 23:11:15 -0400 (EDT)
In-Reply-To: <c77435a80908071553m6f7d5298p5ea68b9386198b3f@mail.gmail.com>
 (Nick Edelen's message of "Sat\, 8 Aug 2009 00\:53\:12 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 29526AEC-83C9-11DE-9A49-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125238>

Nick Edelen <sirnot@gmail.com> writes:

> By the way, what would be the best way of posting a revised patchset?
> Should I just reply to my older posts, or make new ones?

That depends primarily on how heavily the patches needed to change in
response to review comments, but until the series lands in 'next', you
would typically send updated series as a replacement, not incremental.

Many people seemed to be interested in the series and had a volume of
comments on it.  I suspect the updated series would be quite different
from the original, so for the next round I would suspect it would be best
to start anew, marking them as [PATCH N/M (v2)], in a fresh thread.  It
would help reviewers if you said "this corresponds to [PATCH 3/5] in the
original series, with the following improvements based on X and Y's
comments" after the three-dash line.

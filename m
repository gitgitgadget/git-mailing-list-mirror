From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH 1/5] argv-array: Add argv_array_pop function [v2]
Date: Fri, 6 Apr 2012 14:02:11 -0400
Message-ID: <20120406180211.GA11939@hmsreliant.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-2-git-send-email-nhorman@tuxdriver.com>
 <7vd37m5458.fsf@alter.siamese.dyndns.org>
 <20120405232429.GA8654@hmsreliant.think-freely.org>
 <7vobr53bbe.fsf@alter.siamese.dyndns.org>
 <20120406022058.GA16264@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Phil Hord <phil.hord@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 20:02:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGDUS-0001YJ-HS
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 20:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757584Ab2DFSCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 14:02:24 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:40739 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757575Ab2DFSCX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 14:02:23 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SGDUD-0001q8-W1; Fri, 06 Apr 2012 14:02:15 -0400
Content-Disposition: inline
In-Reply-To: <20120406022058.GA16264@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194889>

On Thu, Apr 05, 2012 at 10:20:58PM -0400, Jeff King wrote:
> On Thu, Apr 05, 2012 at 06:20:53PM -0700, Junio C Hamano wrote:
> 
> > >> > CC: Jeff King <peff@peff.net>
> > >> > CC: Phil Hord <phil.hord@gmail.com>
> > >> > CC: Junio C Hamano <gitster@pobox.com>
> > >> > ---
> > >> 
> > >> Please don't do "Cc:" here; they belong to your e-mail header.
> > >> 
> > > You mean place them below the snip line?  I can do that.
> > 
> > No.  When you review and fix typo in format-patch output, you can add
> > these to the e-mail header part and git-send-email will pick them up just
> > fine.
> 
> I think there is a legitimate conflict of interest here.
> 
> It's not clear exactly what "cc" tags in a commit message mean, because
> it is really a per-project thing. I don't work on the kernel, but I
> always took their cc tag to mean "these are people interested in this
> topic area". Send-email helpfully picks up that hint and cc's them on
> the emailed patch. And when the patch is applied, those cc lines remain,
> because people reading "git log" much later may find a bug in the patch,
> and it is helpful to tell them the people interested in the area.
> 
Thats more or less what its for.  Mostly CC's on a patch on lkml are meant to
direct peoples attention to patches for subsystems their interested in.  teh
kernels get_maintainers script generates these typically.  With the volume of
traffic on lkml its often easy for patches to get misplaced by individual
maintainers.  Recording that info in the commit message, while possibly useful,
is most often seen as a harmless side effect.

The major advantage of CC's in the commit log is that it lets you skip the
format-patch stage. I.E. you can just git-send-email directly and have all the
right people CC-ed. Thats very handy when you have a large changeset and the CC
list differs for individual patches.

Neil

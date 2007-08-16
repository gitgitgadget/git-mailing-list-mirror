From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] git-apply: apply submodule changes
Date: Wed, 15 Aug 2007 17:02:58 -0700
Message-ID: <7vmywsmjm5.fsf@gitster.siamese.dyndns.org>
References: <20070812142340.GA10399MdfPADPa@greensroom.kotnet.org>
	<7vwsw0ipp2.fsf@assigned-by-dhcp.cox.net>
	<20070812185006.GG999MdfPADPa@greensroom.kotnet.org>
	<7vr6m8imj6.fsf@assigned-by-dhcp.cox.net>
	<20070813093740.GA4684@liacs.nl>
	<20070813171349.GL999MdfPADPa@greensroom.kotnet.org>
	<7vmywvfag3.fsf@assigned-by-dhcp.cox.net>
	<7vd4xqeilh.fsf@assigned-by-dhcp.cox.net>
	<20070814083940.GN999MdfPADPa@greensroom.kotnet.org>
	<7vps1qcwj4.fsf@assigned-by-dhcp.cox.net>
	<20070815172209.GD1070MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Johannes.Schindelin@gmx.de
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Thu Aug 16 02:03:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILSpU-0002ab-7K
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 02:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757967AbXHPADI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 20:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757766AbXHPADI
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 20:03:08 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:47461 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731AbXHPADG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 20:03:06 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 15806121D3D;
	Wed, 15 Aug 2007 20:03:21 -0400 (EDT)
In-Reply-To: <20070815172209.GD1070MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Wed, 15 Aug 2007 19:22:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55971>

Sven Verdoolaege <skimo@kotnet.org> writes:

> I agree that the TYPE_CHANGED thing may have been confusing,
> so I kept your version (although I switched the tests around,
> since there is no point in checking if the stat info matches
> if you're going to ignore the result anyway).
>
> Other than that, the only change wrt to your version is that
> I added back the creation and (attempt at) removal of the
> corresponding subdirectory.

Makes much more sense than what I wrote.  Thanks.

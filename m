From: Junio C Hamano <gitster@pobox.com>
Subject: Re: On pathnames
Date: Thu, 24 Jan 2008 20:21:04 -0800
Message-ID: <7vprvq7cy7.fsf@gitster.siamese.dyndns.org>
References: <34103945-2078-4983-B409-2D01EF071A8B@sb.org>
	<alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org>
	<E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org>
	<20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu>
	<alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org>
	<20080123013325.GB1320@mit.edu> <20080123064139.GC16297@glandium.org>
	<4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org>
	<20080123094052.GB6969@glandium.org> <20080123133802.GC7415@mit.edu>
	<alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org>
	<98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org>
	<alpine.LFD.1.00.0801230930390.1741@woody.linux-foundation.org>
	<7vprvr7x8h.fsf@gitster.siamese.dyndns.org>
	<alpine.LNX.1.00.0801242227250.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Ballard <kevin@sb.org>, Theodore Tso <tytso@MIT.EDU>,
	Mike Hommey <mh@glandium.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Jan 25 05:21:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIG4b-0003lG-BE
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 05:21:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106AbYAYEVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 23:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753108AbYAYEVT
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 23:21:19 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46068 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbYAYEVS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 23:21:18 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EAFBE1112;
	Thu, 24 Jan 2008 23:21:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 08C9E110D;
	Thu, 24 Jan 2008 23:21:06 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0801242227250.13593@iabervon.org> (Daniel
	Barkalow's message of "Thu, 24 Jan 2008 23:00:44 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71680>

Daniel Barkalow <barkalow@iabervon.org> writes:

> $ git checkout branch
> Warning: xt_CONNMARK.c conflicts with xt_connmark.c; not checking it out
> $ git checkout xt_CONNMARK.c --as xt_CONNMARK_caps.c
> $ edit xt_CONNMARK_caps.c
> $ git add xt_CONNMARK_caps.c

Heh, I like that very much.

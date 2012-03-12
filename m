From: Willy Tarreau <w@1wt.eu>
Subject: Re: stripping [PATCH] without losing later tags from mailed patches (Re: [ 02/12] Remove COMPAT_IA32 support)
Date: Mon, 12 Mar 2012 19:50:08 +0100
Message-ID: <20120312185008.GH12405@1wt.eu>
References: <1331514446.3022.140.camel@deadeye> <20120312024948.GB4650@kroah.com> <20120312063027.GB8971@1wt.eu> <20120312064855.GB16820@burratino> <20120312085820.GA11569@1wt.eu> <20120312152004.GB9380@kroah.com> <20120312152453.GB12405@1wt.eu> <87aa3l4vqq.fsf@thomas.inf.ethz.ch> <20120312165703.GB18791@burratino> <7vvcm9snko.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>, Greg KH <greg@kroah.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Mon Mar 12 19:50:40 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1S7AKL-0004tC-Fd
	for glk-linux-kernel-3@plane.gmane.org; Mon, 12 Mar 2012 19:50:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756464Ab2CLSu2 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 12 Mar 2012 14:50:28 -0400
Received: from 1wt.eu ([62.212.114.60]:63206 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756410Ab2CLSu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Mar 2012 14:50:27 -0400
Received: (from willy@localhost)
	by mail.home.local (8.14.4/8.14.4/Submit) id q2CIo8qU014728;
	Mon, 12 Mar 2012 19:50:08 +0100
Content-Disposition: inline
In-Reply-To: <7vvcm9snko.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192921>

On Mon, Mar 12, 2012 at 11:04:23AM -0700, Junio C Hamano wrote:
> >> So perhaps we can safely claim -b for --keep-non-patch, like so:
> 
> We can delete "git am -b" (as it was deprecated long time ago), wait
> for a cycle or two, and then repurpose it.  I do not mind starting
> the first step (delete, but do not say anything about repurposing)
> before 1.7.10-rc1 happens.

>From my user experience and what I see on a number of coworkers, users
tend to make big jumps when they need a new feature, so in practice,
not offering the option in a version or two would probably not affect
most users, especially the ones still relying on the old behaviour. So
I don't see much benefit in waiting for repurposing the option.

Just my 2 cents,
Willy

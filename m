From: Willy Tarreau <w@1wt.eu>
Subject: Re: stripping [PATCH] without losing later tags from mailed patches (Re: [ 02/12] Remove COMPAT_IA32 support)
Date: Mon, 12 Mar 2012 20:17:27 +0100
Message-ID: <20120312191727.GI12405@1wt.eu>
References: <20120312063027.GB8971@1wt.eu> <20120312064855.GB16820@burratino> <20120312085820.GA11569@1wt.eu> <20120312152004.GB9380@kroah.com> <20120312152453.GB12405@1wt.eu> <87aa3l4vqq.fsf@thomas.inf.ethz.ch> <20120312165703.GB18791@burratino> <7vvcm9snko.fsf@alter.siamese.dyndns.org> <20120312185008.GH12405@1wt.eu> <20120312185440.GA21817@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>, Greg KH <greg@kroah.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: linux-kernel-owner@vger.kernel.org Mon Mar 12 20:17:57 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1S7Akl-0003aK-MX
	for glk-linux-kernel-3@plane.gmane.org; Mon, 12 Mar 2012 20:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756678Ab2CLTRq (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 12 Mar 2012 15:17:46 -0400
Received: from 1wt.eu ([62.212.114.60]:63213 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756637Ab2CLTRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Mar 2012 15:17:45 -0400
Received: (from willy@localhost)
	by mail.home.local (8.14.4/8.14.4/Submit) id q2CJHR3G014898;
	Mon, 12 Mar 2012 20:17:27 +0100
Content-Disposition: inline
In-Reply-To: <20120312185440.GA21817@burratino>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192928>

On Mon, Mar 12, 2012 at 01:54:40PM -0500, Jonathan Nieder wrote:
> Willy Tarreau wrote:
> 
> > From my user experience and what I see on a number of coworkers, users
> > tend to make big jumps when they need a new feature, so in practice,
> > not offering the option in a version or two would probably not affect
> > most users, especially the ones still relying on the old behaviour. So
> > I don't see much benefit in waiting for repurposing the option.
> 
> The benefit is that if it does turn out to be a regression, early
> adopters will complain to us because their scripts have stopped
> working and we get a chance to back out the change without having to
> worry about others who have started to rely on the option.

Indeed you're right. I forgot the case of the old script relying
on the silently ignored parameter!

Regards,
Willy

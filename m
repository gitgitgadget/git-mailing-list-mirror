From: Willy Tarreau <w@1wt.eu>
Subject: Re: stripping [PATCH] without losing later tags from mailed patches (Re: [ 02/12] Remove COMPAT_IA32 support)
Date: Mon, 12 Mar 2012 19:45:49 +0100
Message-ID: <20120312184549.GG12405@1wt.eu>
References: <20120312002046.041448832@1wt.eu> <1331514446.3022.140.camel@deadeye> <20120312024948.GB4650@kroah.com> <20120312063027.GB8971@1wt.eu> <20120312064855.GB16820@burratino> <20120312085820.GA11569@1wt.eu> <20120312152004.GB9380@kroah.com> <7vfwddu60f.fsf@alter.siamese.dyndns.org> <20120312164812.GC12405@1wt.eu> <7v4nttu2gf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg KH <greg@kroah.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Mon Mar 12 19:46:18 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1S7AG7-0002WT-MB
	for glk-linux-kernel-3@plane.gmane.org; Mon, 12 Mar 2012 19:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756404Ab2CLSqG (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 12 Mar 2012 14:46:06 -0400
Received: from 1wt.eu ([62.212.114.60]:63199 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952Ab2CLSqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Mar 2012 14:46:04 -0400
Received: (from willy@localhost)
	by mail.home.local (8.14.4/8.14.4/Submit) id q2CIjnrN014691;
	Mon, 12 Mar 2012 19:45:49 +0100
Content-Disposition: inline
In-Reply-To: <7v4nttu2gf.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192920>

On Mon, Mar 12, 2012 at 10:57:36AM -0700, Junio C Hamano wrote:
> > I've just backported it to 1.7.9.3 (I'm not keen on living on the bleeding
> > edge with my everyday tools), and it works nicely as expected.
> 
> This topic will be backported in later versions of 1.7.9.x track,
> but living on the maintenance track does not have much smaller
> chance of breakage than living on the tip of 'master' these days,
> unless you are using distro packaged version. The usual rule of
> thumb if you are compiling from the source is that the tip of
> 'master' is more stable than any tagged version, including the
> maintenance track.  See
> 
> http://thread.gmane.org/gmane.comp.version-control.git/189657/focus=190814
> 
> for details.

I know, but you see I was running on 1.7.2.3. Generally if one version
works for me, I don't upgrade it for a year or two. I've been hit a few
times in the past by some quite annoying bugs (as is to be expected from
any software in the development branch), and lost a lot of time on this.
Rest assured that I don't feel comfortable on 1.7.9 either, that's a big
jump for me but I know that most often it works quite well :-)

Willy

From: Willy Tarreau <w@1wt.eu>
Subject: Re: stripping [PATCH] without losing later tags from mailed patches (Re: [ 02/12] Remove COMPAT_IA32 support)
Date: Mon, 12 Mar 2012 09:58:20 +0100
Message-ID: <20120312085820.GA11569@1wt.eu>
References: <20120312002046.041448832@1wt.eu> <1331514446.3022.140.camel@deadeye> <20120312024948.GB4650@kroah.com> <20120312063027.GB8971@1wt.eu> <20120312064855.GB16820@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg KH <greg@kroah.com>, Ben Hutchings <ben@decadent.org.uk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: linux-kernel-owner@vger.kernel.org Mon Mar 12 09:59:01 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1S715o-0007ml-FV
	for glk-linux-kernel-3@plane.gmane.org; Mon, 12 Mar 2012 09:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275Ab2CLI6p (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 12 Mar 2012 04:58:45 -0400
Received: from 1wt.eu ([62.212.114.60]:63155 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752793Ab2CLI6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Mar 2012 04:58:41 -0400
Received: (from willy@localhost)
	by mail.home.local (8.14.4/8.14.4/Submit) id q2C8wKKP011585;
	Mon, 12 Mar 2012 09:58:20 +0100
Content-Disposition: inline
In-Reply-To: <20120312064855.GB16820@burratino>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192848>

Hi Jonathan,

On Mon, Mar 12, 2012 at 01:48:55AM -0500, Jonathan Nieder wrote:
> > Indeed, and I've even changed my patch formats in haproxy to avoid brackets
> > due to this issue. The cause is that many patches are sent with a [PATCH]
> > prefix and that with Git, either you keep the subject line intact or you
> > remove everything that is between brackets. There's the -b option to only
> > remove remove tags looking like [PATCH], but my general experience with it
> > was not satisfying (I don't remind why).
> 
> Maybe the problem was as simple as "git am" not knowing about "-b".

I think you're quite right.

> Two relevant patches:
> 
>   f7e5ea17 (am: learn passing -b to mailinfo, 2012-01-16)
>   ee2d1cb4 (mailinfo: with -b, keep space after [foo], 2012-01-16)
> 
> are in "master" and 1.7.10-rc0 and were not part of any earlier release.
>
> Kudos to Thomas for writing them.

Ah, thank you very much for this useful info, I'll update my version !

Cheers,
Willy

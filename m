From: Greg KH <greg@kroah.com>
Subject: Re: stripping [PATCH] without losing later tags from mailed patches
 (Re: [ 02/12] Remove COMPAT_IA32 support)
Date: Mon, 12 Mar 2012 10:12:57 -0700
Message-ID: <20120312171257.GA25347@kroah.com>
References: <20120312002046.041448832@1wt.eu>
 <1331514446.3022.140.camel@deadeye>
 <20120312024948.GB4650@kroah.com>
 <20120312063027.GB8971@1wt.eu>
 <20120312064855.GB16820@burratino>
 <20120312085820.GA11569@1wt.eu>
 <20120312152004.GB9380@kroah.com>
 <7vfwddu60f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Willy Tarreau <w@1wt.eu>, Jonathan Nieder <jrnieder@gmail.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Mon Mar 12 18:13:18 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1S78o6-0007F9-Eq
	for glk-linux-kernel-3@plane.gmane.org; Mon, 12 Mar 2012 18:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754662Ab2CLRNB (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 12 Mar 2012 13:13:01 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36981 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753185Ab2CLRM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Mar 2012 13:12:59 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 31728213E7
	for <linux-kernel@vger.kernel.org>; Mon, 12 Mar 2012 13:12:59 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Mon, 12 Mar 2012 13:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=smtpout;
	 bh=6gR29mF3vkZijbDdUntZHKfvRtc=; b=SUrF0zNr6Ao2WDhz//OYX/F0jL5H
	jRy6KLJ7QltGvH8s/2ieegsNU/hhvW+X9+WZjlTQgPKq1IaIqJKikhBtX5VxNLes
	4BhhVaKxMsiMPj28EMamHn26fdsJh1ESqH/QsmU1BMkz5zSi88y0eJZEoOFzEp4i
	tcE4DTXbc86+Qts=
X-Sasl-enc: 1s/OHC/aXfWIplQzdjCWp8rKi6WCFr5NZ/JZylV0IeAV 1331572378
Received: from localhost (c-76-121-69-168.hsd1.wa.comcast.net [76.121.69.168])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9EE0B48249F;
	Mon, 12 Mar 2012 13:12:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vfwddu60f.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192909>

On Mon, Mar 12, 2012 at 09:40:48AM -0700, Junio C Hamano wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > I don't see a -b option to 'git am' in the manpage, am I missing
> > something here?
> 
> As this is a recent enhancement, it is very much appreciated if you
> try out 1.7.10-rc0 (or 'master').

Nice, I'll go do that now.

Does the flag propagate from 'git quiltimport'?  That's how I import
patches that would need this option most of the time.

thanks,

greg k-h

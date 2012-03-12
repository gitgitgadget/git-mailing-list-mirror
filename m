From: Greg KH <greg@kroah.com>
Subject: Re: stripping [PATCH] without losing later tags from mailed patches
 (Re: [ 02/12] Remove COMPAT_IA32 support)
Date: Mon, 12 Mar 2012 12:26:27 -0700
Message-ID: <20120312192627.GA24873@kroah.com>
References: <20120312002046.041448832@1wt.eu>
 <1331514446.3022.140.camel@deadeye>
 <20120312024948.GB4650@kroah.com>
 <20120312063027.GB8971@1wt.eu>
 <20120312064855.GB16820@burratino>
 <20120312085820.GA11569@1wt.eu>
 <20120312152004.GB9380@kroah.com>
 <7vfwddu60f.fsf@alter.siamese.dyndns.org>
 <20120312171257.GA25347@kroah.com>
 <7vzkblsnos.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Willy Tarreau <w@1wt.eu>, Jonathan Nieder <jrnieder@gmail.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 20:26:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7AtO-0008Tc-Hn
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 20:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756683Ab2CLT0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 15:26:31 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34912 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756586Ab2CLT0a (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Mar 2012 15:26:30 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4874C20745
	for <git@vger.kernel.org>; Mon, 12 Mar 2012 15:26:29 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Mon, 12 Mar 2012 15:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=smtpout;
	 bh=UdzOyW2+PO3m1E4H0BN8kON4UPA=; b=BLPV4qvuApt9sueoU46neRnSJMdV
	jHqr3XUUAK5oSUP2MNjobjvUwBcau0t4g4tWQFsktI1IFmPSEO+dLsE9HEUk3uq2
	oo/2OfxDHJi6d6iN0XLvzeYObYhUYCRTYXqy5FogXgeN36LNg7p3WYGS3qi7cUcV
	uZuei5FCdmSuZ5Q=
X-Sasl-enc: siAL/JBS/MGfrzVwl9i0lY7VEjYKiHw61AirTzWIll+c 1331580388
Received: from localhost (c-76-121-69-168.hsd1.wa.comcast.net [76.121.69.168])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B38DF8E00C5;
	Mon, 12 Mar 2012 15:26:28 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vzkblsnos.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192929>

On Mon, Mar 12, 2012 at 11:01:55AM -0700, Junio C Hamano wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > Does the flag propagate from 'git quiltimport'?
> 
> I didn't even know the script was shipped as part of the main
> Porcelain until I looked.  I do not think anybody is maintaining it;
> the last update was from the 1.6.2 era.

Ah, so my feeling that I'm the only one using it is true :)

> A tested patch from quilt stakeholders is very much welcomed.

I'll be glad to maintain this if you need me to.  I'll poke around with
it tomorrow to see what needs to be done here.

thanks,

greg k-h

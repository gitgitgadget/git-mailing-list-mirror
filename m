From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [RFC/PATCH] add update to branch support for "floating
 submodules"
Date: Tue, 29 Nov 2011 23:08:55 +0100
Message-ID: <20111129220854.GB2812@sandbox-rc.fritz.box>
References: <20111109174027.GA28825@book.fritz.box>
 <7vr51htbsy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 29 23:09:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVVrJ-00062W-Ml
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 23:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754352Ab1K2WI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 17:08:57 -0500
Received: from darksea.de ([83.133.111.250]:55254 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751310Ab1K2WI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 17:08:56 -0500
Received: (qmail 3045 invoked from network); 29 Nov 2011 23:08:55 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 29 Nov 2011 23:08:55 +0100
Content-Disposition: inline
In-Reply-To: <7vr51htbsy.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186093>

Hi,

On Wed, Nov 09, 2011 at 10:01:33AM -0800, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > This is almost ready but I would like to know what users of the
> > "floating submodule" think about this.
> 
> Thanks for working on this.
> 
> I do like to hear from potential users as well, because the general
> impression we got was that floating submodules is not a real need of
> anybody, but it is merely an inertia of people who (perhaps mistakenly)
> thought svn externals that are not anchored to a particular revision is a
> feature when it is just a limitation in reality. During the GitTogether'11
> we learned that Android that uses floating model does not really have to.

Since we did not get any reply from potential floating submodule users I
do not mind to drop this patch for now. It is archived in the mailing list
and it should be easy to revive once there is real world need for it.

Once we have the "exact" model support for checkout and friends this
might be a handy tool to update submodules before releases and such. But
currently I would like to focus on the "exact" front first.

Cheers Heiko

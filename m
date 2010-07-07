From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH v2 3/4] extent setup_revisions() so it works with
	submodules
Date: Wed, 7 Jul 2010 15:37:23 +0200
Message-ID: <20100707133723.GB35678@book.hvoigt.net>
References: <cover.1278444110.git.hvoigt@hvoigt.net> <cover.1278444110.git.hvoigt@hvoigt.net> <ab9c0f88b30060401d99735cb78eec7cc1e95b86.1278444110.git.hvoigt@hvoigt.net> <7veiff274b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jens.lehmann@web.de, jherland@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 07 15:37:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWUof-0006mX-Ea
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 15:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755982Ab0GGNh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 09:37:26 -0400
Received: from darksea.de ([83.133.111.250]:52755 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755953Ab0GGNhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 09:37:25 -0400
Received: (qmail 17276 invoked from network); 7 Jul 2010 15:37:23 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 7 Jul 2010 15:37:23 +0200
Content-Disposition: inline
In-Reply-To: <7veiff274b.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150471>

Hi,

On Tue, Jul 06, 2010 at 10:28:20PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> 
> This needs a bit more explanation.  "Exten_d_ setup_revisions()" is fine,
> but "works with submodules"???  How? and what do the caller need to do?
> 
> Something like...
> 
>     Subject: setup_revisions(): allow walking history in a submodule
> 
>     By passing the path to a submodule in opt->submodule, the function can
>     be used to walk history in the named submodule repository, instead of
>     the toplevel repository.

Will take that. Thanks.

cheers Heiko

From: Alberto Bertogli <albertito@blitiri.com.ar>
Subject: Re: [ANN] git-arr 0.11
Date: Fri, 15 Mar 2013 01:16:25 +0000
Message-ID: <20130315011625.GE14686@blitiri.com.ar>
References: <20130313234143.GD14686@blitiri.com.ar>
 <vpqppz22luj.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 15 02:17:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGJHH-0006hl-Cy
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 02:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376Ab3COBRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 21:17:21 -0400
Received: from alerce.vps.bitfolk.com ([85.119.82.134]:49190 "EHLO
	alerce.vps.bitfolk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799Ab3COBRU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 21:17:20 -0400
Received: from 85-91-26-102.ptr.magnet.ie ([85.91.26.102] helo=blitiri.com.ar)
	by alerce.vps.bitfolk.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.76)
	(envelope-from <albertito@blitiri.com.ar>)
	id 1UGJGp-0004Tb-GM; Thu, 14 Mar 2013 22:17:19 -0300
Content-Disposition: inline
In-Reply-To: <vpqppz22luj.fsf@grenoble-inp.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218183>

On Thu, Mar 14, 2013 at 01:43:16PM +0100, Matthieu Moy wrote:
> Alberto Bertogli <albertito@blitiri.com.ar> writes:
> 
> > I wanted to let you know about git-arr, which is a git repository
> > browser that can generate static HTML instead of having to run
> > dynamically.
> 
> Can it run incrementally? I mean, if you have launched it for one
> revision, does re-running it on the next revision regenerate the whole
> set of pages, or does it only generate new pages?

Yes, you can run it incrementally, and it will only generate new pages.


> If so, that could be a nice way to replace dynamic browsers for people
> who do not have/want dynamic webpages, by just setting a hook or cron
> job that generate the new pages when an update is made.

That's my main intended use. I'm using a hook
(http://blitiri.com.ar/git/r/git-arr/b/master/t/hooks/f=post-receive.html)
to update repos when I push to them and it's been working fine for me so
far. I never tried the cron approach but it should work well too.

Thanks!
		Alberto

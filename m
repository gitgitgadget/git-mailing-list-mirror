From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: [PATCH v3] Add core.mode configuration
Date: Mon, 14 Oct 2013 22:59:08 +0200
Message-ID: <20131014205908.GA17089@shrek.podlesie.net>
References: <1381561485-20252-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 14 23:05:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVpKI-0002vg-H6
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 23:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757742Ab3JNVFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 17:05:12 -0400
Received: from shrek-wifi.podlesie.net ([93.179.225.50]:51101 "EHLO
	shrek.podlesie.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757648Ab3JNVFL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 17:05:11 -0400
X-Greylist: delayed 358 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Oct 2013 17:05:11 EDT
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id EE7B178; Mon, 14 Oct 2013 22:59:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1381561485-20252-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236119>

On Sat, Oct 12, 2013 at 02:04:45AM -0500, Felipe Contreras wrote:
> So that we can specify general modes of operation, specifically, add the
> 'next' mode, which makes Git pre v2.0 behave as Git v2.0.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

I don't think that single option it's a good idea. From the user's
point of view I think that the way push.default was introduced and
will be changed is much better. So maybe it's better to just add
"core.addremove" option instead?

Krzysiek

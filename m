From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH v4 0/4] git-submodule add: Add --local-branch option
Date: Tue, 27 Nov 2012 20:16:28 +0100
Message-ID: <20121127191628.GC4185@book.hvoigt.net>
References: <20121123175402.GH2806@odin.tremily.us> <cover.1353962698.git.wking@tremily.us> <20121127183125.GA4185@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Tue Nov 27 20:19:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdQgT-0006H0-EJ
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 20:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211Ab2K0TSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 14:18:50 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.24]:53277 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742Ab2K0TSu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 14:18:50 -0500
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1TdQdx-0007Ae-4T; Tue, 27 Nov 2012 20:16:29 +0100
Content-Disposition: inline
In-Reply-To: <20121127183125.GA4185@book.hvoigt.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210587>

Hi,

I just realized that I gave you an confusing suggestion.

On Tue, Nov 27, 2012 at 07:31:25PM +0100, Heiko Voigt wrote:
> 	if test "$subsha1" != "$sha1"
> 	then
> 		handle_on_demand_fetch_update ...
> 	else
> 		handle_tracked_branch_update ...
> 	fi

That obviously does not work. Here I meant of course something like:

 	if test "$update_module" = "branch"
 	then
 		handle_tracked_branch_update ...
 	else
 		handle_on_demand_fetch_update ...
 	fi

Cheers Heiko

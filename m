From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v8 0/3] submodule update: add --remote for submodule's
	upstream changes
Date: Fri, 21 Dec 2012 09:18:03 +0100
Message-ID: <20121221081803.GA560@book.hvoigt.net>
References: <20121212230217.GB7729@odin.tremily.us> <cover.1355932282.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: wking@tremily.us
X-From: git-owner@vger.kernel.org Fri Dec 21 09:19:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlxpI-0000YJ-05
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 09:19:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105Ab2LUITL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 03:19:11 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.25]:36018 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812Ab2LUITI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 03:19:08 -0500
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Tlxnx-0004gg-1I; Fri, 21 Dec 2012 09:18:05 +0100
Content-Disposition: inline
In-Reply-To: <cover.1355932282.git.wking@tremily.us>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211959>

Hi,

On Wed, Dec 19, 2012 at 11:03:30AM -0500, wking@tremily.us wrote:
> From: "W. Trevor King" <wking@tremily.us>
> 
> Comments on v7 seem to have petered out, so here's v8.  Changes since
> v7:
> 
> * Series based on gitster/master instead of v1.8.0.
> * In Documentation/config.txt, restored trailing line of
>   submodule.<name>.update documentation, which I had accidentally
>   removed in v7.
> * In Documentation/git-submodule.txt, make --no-fetch example in the
>   --remote description more general, following Phil's suggestion.
> * In git-submodule.sh:
>   * Remove accidental "ges" line.
>   * Use the submodule's default remote to determine which tracking
>     branch to fetch.  In v7 I'd been using the superproject's default
>     remote.
>   * In cmd_add(), use sm_name instead of sm_path to store the --branch
>     option (catching up with 73b0898).

Sorry, I was not able to follow the discussion that closely lately but I
like the outcome. For me there is nothing to change or add functionality
wise. Thanks.

Cheers Heiko

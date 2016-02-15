From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 2/3] config: add 'type' to config_source struct that
 identifies config type
Date: Mon, 15 Feb 2016 12:42:18 -0500
Message-ID: <20160215174218.GB26443@sigill.intra.peff.net>
References: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com>
 <1455531466-16617-3-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sschuberth@gmail.com,
	ramsay@ramsayjones.plus.com, sunshine@sunshineco.com,
	hvoigt@hvoigt.net, sbeller@google.com, Johannes.Schindelin@gmx.de,
	gitster@pobox.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 15 18:42:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVNAG-0000R3-Nw
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 18:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbcBORmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 12:42:21 -0500
Received: from cloud.peff.net ([50.56.180.127]:42219 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750918AbcBORmU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 12:42:20 -0500
Received: (qmail 23271 invoked by uid 102); 15 Feb 2016 17:42:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 12:42:20 -0500
Received: (qmail 9578 invoked by uid 107); 15 Feb 2016 17:42:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 12:42:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 12:42:18 -0500
Content-Disposition: inline
In-Reply-To: <1455531466-16617-3-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286213>

On Mon, Feb 15, 2016 at 11:17:45AM +0100, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Use the config type to print more detailed error messages that inform
> the user about the origin of a config error (file, stdin, blob).
> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  cache.h                |  6 ++++--
>  config.c               | 36 +++++++++++++++++++++++++-----------
>  submodule-config.c     |  4 ++--
>  t/t1300-repo-config.sh |  8 +++++++-
>  t/t1308-config-set.sh  |  4 ++--
>  5 files changed, 40 insertions(+), 18 deletions(-)

Looks good to me.

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 3/3] config: add '--show-origin' option to print the
 origin of a config value
Date: Mon, 15 Feb 2016 13:06:44 -0500
Message-ID: <20160215180644.GD26443@sigill.intra.peff.net>
References: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com>
 <1455531466-16617-4-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sschuberth@gmail.com,
	ramsay@ramsayjones.plus.com, sunshine@sunshineco.com,
	hvoigt@hvoigt.net, sbeller@google.com, Johannes.Schindelin@gmx.de,
	gitster@pobox.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 15 19:06:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVNY1-0005IU-Gu
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 19:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbcBOSGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 13:06:48 -0500
Received: from cloud.peff.net ([50.56.180.127]:42259 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751972AbcBOSGr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 13:06:47 -0500
Received: (qmail 24470 invoked by uid 102); 15 Feb 2016 18:06:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 13:06:46 -0500
Received: (qmail 9908 invoked by uid 107); 15 Feb 2016 18:06:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 13:06:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 13:06:44 -0500
Content-Disposition: inline
In-Reply-To: <1455531466-16617-4-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286221>

On Mon, Feb 15, 2016 at 11:17:46AM +0100, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> If config values are queried using 'git config' (e.g. via --get,
> --get-all, --get-regexp, or --list flag) then it is sometimes hard to
> find the configuration file where the values were defined.
> 
> Teach 'git config' the '--show-origin' option to print the source
> configuration file for every printed value.
> 
> Based-on-patch-by: Jeff King <peff@peff.net>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  Documentation/git-config.txt |  15 +++--
>  builtin/config.c             |  33 ++++++++++
>  t/t1300-repo-config.sh       | 153 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 196 insertions(+), 5 deletions(-)

I packed all of my thoughts on test tear-down into my response to the
cover letter. :)

Other than that minor point, this version looks good to me.

-Peff

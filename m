From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v8 4/4] config: allow http.<url>.* any user matching
Date: Wed, 24 Jul 2013 02:44:48 -0400
Message-ID: <20130724064447.GB30074@sigill.intra.peff.net>
References: <3c7fc982841069ce79faf227e007815@f74d39fa044aa309eaea14b9f57fe79>
 <7dfaadb69accede33b88ae2d9e47a48@f74d39fa044aa309eaea14b9f57fe79>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>, Junio C Hamano <gitster@pobox.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 08:44:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1soi-0002tv-Gy
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 08:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133Ab3GXGow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 02:44:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:36422 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751637Ab3GXGov (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 02:44:51 -0400
Received: (qmail 19701 invoked by uid 102); 24 Jul 2013 06:44:51 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 24 Jul 2013 01:44:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jul 2013 02:44:48 -0400
Content-Disposition: inline
In-Reply-To: <7dfaadb69accede33b88ae2d9e47a48@f74d39fa044aa309eaea14b9f57fe79>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231079>

On Mon, Jul 22, 2013 at 05:56:44AM -0700, Kyle J. McKay wrote:

> +	matches a url if it refers to the same scheme, host and port and the
> +	path portion is an exact match or a prefix that matches at a "/"
> +	boundary.  If <url> does not include a user name, it will match a url
> +	with any username otherwise the user name must match as well (the
> +	password part, if present in the url, is always ignored).  Longer <url>
> +	path matches take precedence over shorter matches no matter what order
> +	they occur in.  For example, if both "https://user@example.com/path" and
> +	"https://example.com/path/name" are used as a config <url> value and
> +	then "https://user@example.com/path/name/here" is passed to a git
> +	command, the settings in the "https://example.com/path/name" section

These "https://..." should probably be `https://...`, to mark them in
asciidoc as literals.

-Peff

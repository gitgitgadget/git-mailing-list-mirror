From: Jeff King <peff@peff.net>
Subject: Re: [Patch 1/1] Wire html for all files in ./technical and ./howto
 in Makefile
Date: Thu, 25 Oct 2012 05:42:05 -0400
Message-ID: <20121025094205.GI8390@sigill.intra.peff.net>
References: <139737172.296334.1351014913982.JavaMail.ngmail@webmail16.arcor-online.net>
 <1531209463.296427.1351015084181.JavaMail.ngmail@webmail16.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Thomas Ackermann <th.acker66@arcor.de>
X-From: git-owner@vger.kernel.org Thu Oct 25 11:42:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRJxG-0002UI-JP
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 11:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161057Ab2JYJmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 05:42:10 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56036 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934900Ab2JYJmI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 05:42:08 -0400
Received: (qmail 6961 invoked by uid 107); 25 Oct 2012 09:42:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Oct 2012 05:42:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2012 05:42:05 -0400
Content-Disposition: inline
In-Reply-To: <1531209463.296427.1351015084181.JavaMail.ngmail@webmail16.arcor-online.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208376>

On Tue, Oct 23, 2012 at 07:58:04PM +0200, Thomas Ackermann wrote:

> - target "html" creates html for all files in Documentation/howto and
> Documentation/technical

Thanks.

> +TECH_DOCS = technical/index-format
> +TECH_DOCS += technical/pack-format
> +TECH_DOCS += technical/pack-heuristics
> +TECH_DOCS += technical/pack-protocol
> +TECH_DOCS += technical/protocol-capabilities
> +TECH_DOCS += technical/protocol-common
> +TECH_DOCS += technical/racy-git
> +TECH_DOCS += technical/send-pack-pipeline
> +TECH_DOCS += technical/shallow
> +TECH_DOCS += technical/trivial-merge
> +SP_ARTICLES += $(TECH_DOCS)

I wonder if these could even be part of the generated api-index.html
(that is, if somebody is reading about the API, they just as well may
want to see these format documents). But I do not overly care much, as I
(and I suspect most other developers) just read the technical
documentation in its original txt format.

If somebody cares, we can easily build it on top.

-Peff

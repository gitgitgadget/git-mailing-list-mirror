From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Color support added to git-add--interactive.
Date: Sat, 13 Oct 2007 17:38:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710131737010.25221@racer.site>
References: <471045DA.5050902@gmail.com> <19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dan Zwell <dzwell@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan del Strother <maillist@steelskies.com>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Oct 13 18:39:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Igk0k-0001dk-8Y
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 18:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756648AbXJMQic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 12:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756260AbXJMQic
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 12:38:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:33931 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756103AbXJMQia (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 12:38:30 -0400
Received: (qmail invoked by alias); 13 Oct 2007 16:38:28 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 13 Oct 2007 18:38:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18FvgFtM/kFvh9JU8fBMECu7jxJghFPN5eAmuksbY
	hdtn+Zrdd6RM3K
X-X-Sender: gene099@racer.site
In-Reply-To: <19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 13 Oct 2007, Wincent Colaiuta wrote:

> Didn't even think about implementing user-settable colors.

FWIW, this is what Documentation/config.txt has to say about it:

color.diff.<slot>::
        Use customized color for diff colorization.  `<slot>` specifies
        which part of the patch to use the specified color, and is one
        of `plain` (context text), `meta` (metainformation), `frag`
        (hunk header), `old` (removed lines), `new` (added lines),
        `commit` (commit headers), or `whitespace` (highlighting dubious
        whitespace).  The values of these variables may be specified as
        in color.branch.<slot>.

Hth,
Dscho

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] pre-commit hook should ignore carriage returns at
	EOL
Date: Fri, 27 Jun 2008 00:24:46 -0400
Message-ID: <20080627042446.GD7144@sigill.intra.peff.net>
References: <3BA781AD-4C44-4F43-902A-07580B6CA075@gmail.com> <20080625181422.GC4039@steel.home> <5B163827-204D-4F76-88C9-8F0C93E60AF3@gmail.com> <7vhcbh1g4e.fsf@gitster.siamese.dyndns.org> <635350D7-2CC0-4FA6-BB74-CE9ED930ECE8@gmail.com> <7vk5gbq10p.fsf@gitster.siamese.dyndns.org> <7vprq3ol63.fsf@gitster.siamese.dyndns.org> <7vlk0rokxb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Holtje <docwhat@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 06:25:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC5Ws-0005QA-Ib
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 06:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbYF0EYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 00:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbYF0EYt
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 00:24:49 -0400
Received: from peff.net ([208.65.91.99]:4939 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993AbYF0EYs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 00:24:48 -0400
Received: (qmail 31616 invoked by uid 111); 27 Jun 2008 04:24:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 27 Jun 2008 00:24:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jun 2008 00:24:46 -0400
Content-Disposition: inline
In-Reply-To: <7vlk0rokxb.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86522>

On Thu, Jun 26, 2008 at 04:06:56PM -0700, Junio C Hamano wrote:

> +if git-rev-parse --verify HEAD 2>/dev/null
> +then
> +	against=
> +else
> +	# Initial commit: diff against an empty tree object
> +	against=4b825dc642cb6eb9a060e54bf8d69288fbee4904
> +fi

Heh, I am happy that the virtual empty tree object is coming in handy
again.

>From quick review, the series looks good to me (and it was, btw, very
easy to read -- I think that you, as somebody who reviews a lot of
patches, have gotten very good at splitting up your own sensibly. :) ).

-Peff

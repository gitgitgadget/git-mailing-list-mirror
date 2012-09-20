From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] completion: fix shell expansion of items
Date: Wed, 19 Sep 2012 21:46:08 -0400
Message-ID: <20120920014608.GA27782@sigill.intra.peff.net>
References: <1348107315-25095-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 03:46:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEVql-0000dR-CU
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 03:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557Ab2ITBqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 21:46:32 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50350 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753011Ab2ITBqL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 21:46:11 -0400
Received: (qmail 10168 invoked by uid 107); 20 Sep 2012 01:46:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Sep 2012 21:46:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Sep 2012 21:46:08 -0400
Content-Disposition: inline
In-Reply-To: <1348107315-25095-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206025>

On Thu, Sep 20, 2012 at 04:15:15AM +0200, Felipe Contreras wrote:

> As reported by Jeroen Meijer[1]; the current code doesn't deal properly
> with items (tags, branches, etc.) that have ${} in them because they get
> expaned by bash while using compgen.
> 
> A simple solution is to quote the items so they get expanded properly
> (\$\{\}).
> 
> In order to achieve that I took bash-completion's quote() function,
> which is rather simple, and renamed it to __git_quote() as per Jeff
> King's suggestion.
> 
> Solves the original problem for me.

Me too. Thanks.

-Peff

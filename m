From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] branch: colour upstream branches
Date: Sun, 14 Apr 2013 20:47:46 -0400
Message-ID: <20130415004746.GA6477@sigill.intra.peff.net>
References: <1365982707-25455-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 02:47:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URXaO-0002yq-TX
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 02:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507Ab3DOArw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 20:47:52 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45829 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159Ab3DOArw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 20:47:52 -0400
Received: (qmail 18428 invoked by uid 107); 15 Apr 2013 00:49:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 14 Apr 2013 20:49:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Apr 2013 20:47:46 -0400
Content-Disposition: inline
In-Reply-To: <1365982707-25455-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221170>

On Sun, Apr 14, 2013 at 06:38:27PM -0500, Felipe Contreras wrote:

> +		if (want_color(branch_use_color))
> +			snprintf(fancy, sizeof(fancy), "%s%s%s",
> +					branch_get_color(BRANCH_COLOR_UPSTREAM),
> +					ref, branch_get_color(BRANCH_COLOR_RESET));
> +		else
> +			strncpy(fancy, ref, sizeof(fancy));

  $ man strncpy | grep -C1 Warning
  The strncpy() function is similar, except that at most n bytes of src are
  copied.  Warning: If there is no null byte among the first n bytes of src,
  the string placed in dest will not be null-terminated.

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] Document ls-files -t as semi-obsolete.
Date: Wed, 28 Jul 2010 00:00:47 -0400
Message-ID: <20100728040047.GA17614@coredump.intra.peff.net>
References: <vpqaapcy6xq.fsf@bauges.imag.fr>
 <1280265073-23037-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jul 28 06:01:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdxpB-00079U-OO
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 06:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757Ab0G1EAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 00:00:53 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:43090 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705Ab0G1EAw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 00:00:52 -0400
Received: (qmail 20145 invoked by uid 111); 28 Jul 2010 04:00:49 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Wed, 28 Jul 2010 04:00:49 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jul 2010 00:00:47 -0400
Content-Disposition: inline
In-Reply-To: <1280265073-23037-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152037>

On Tue, Jul 27, 2010 at 11:11:13PM +0200, Matthieu Moy wrote:

>  -t::
> -	Identify the file status with the following tags (followed by
> -	a space) at the start of each line:
> +	This feature is semi-deprecated. For scripting purpose,
> +	linkgit:git-status[1] `--porcelain` and
> +	linkgit:git-diff-tree[1] `--name-status` are almost always
> +	superior alternatives, and users should look at
> +	linkgit:git-status[1] `--short` or linkgit:git-diff[1]
> +	`--name-status` for more user-friendly alternatives.

Shouldn't it be diff-files and not diff-tree?

-Peff

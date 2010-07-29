From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4 v2] Allow detached form for --glob, --branches,
	--tags and --remote.
Date: Wed, 28 Jul 2010 21:48:34 -0500
Message-ID: <20100729024834.GN29156@dert.cs.uchicago.edu>
References: <vpqr5ioukca.fsf@bauges.imag.fr> <1280310062-16793-4-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Jul 29 04:48:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeJAm-0004ny-KC
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 04:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886Ab0G2Csg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 22:48:36 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:57440 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194Ab0G2Csf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 22:48:35 -0400
Received: from dert.cs.uchicago.edu (dert.cs.uchicago.edu [128.135.11.157])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id 6506BA1F4;
	Wed, 28 Jul 2010 21:48:35 -0500 (CDT)
Received: by dert.cs.uchicago.edu (Postfix, from userid 10442)
	id 2F9AF9A185; Wed, 28 Jul 2010 21:48:35 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <1280310062-16793-4-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152154>

Matthieu Moy wrote:

> -			if (!prefixcmp(arg, "--branches=")) {
> +			if ((argcount = diff_long_opt("branches", argv + i, &optarg))) {
> +				i += argcount - 1;
>  				struct all_refs_cb cb;

As before: is this the right change where the argument is
optional?

Thanks for a pleasant read.
Jonathan

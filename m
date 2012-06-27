From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH 2/3] Allow help.htmlpath to be an http: URL
Date: Wed, 27 Jun 2012 22:41:21 +0100
Message-ID: <20120627214120.GE11498@arachsys.com>
References: <8d3c71d21710c66e4d5560cec958552b69a22338.1340830514.git.chris@arachsys.com>
 <233b27a14d16a2a1cb38b9f3e07a3a79b09a3256.1340830514.git.chris@arachsys.com>
 <20120627210502.GB2292@sigill.intra.peff.net>
 <7vbok4785a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 23:41:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjzzR-00039U-N0
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 23:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756634Ab2F0Vl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 17:41:28 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:45839 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581Ab2F0Vl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 17:41:28 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SjzzJ-0003PW-Ck; Wed, 27 Jun 2012 22:41:25 +0100
Content-Disposition: inline
In-Reply-To: <7vbok4785a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200761>

Junio C Hamano <gitster@pobox.com> writes:

> Which leads me to conclude that it is the right thing to do if
> html_path came from the configuration, not from the compiled-in
> default, to always ask browser to do its thing, and let it fail if
> it has to fail---it is not Git's problem anymore at that point.
>
> It also is the simplest.

Yes, indeed! Okay, I'll re-roll it that way and go for the super-simple
approach.

Cheers,

Chris.

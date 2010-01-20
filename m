From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] @{u} updates
Date: Wed, 20 Jan 2010 14:08:24 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001201408100.31129@intel-tinevez-2-302>
References: <1263980322-4142-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 14:08:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXaIU-0007vk-Aq
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 14:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660Ab0ATNIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 08:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166Ab0ATNIa
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 08:08:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:40314 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751524Ab0ATNIa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 08:08:30 -0500
Received: (qmail invoked by alias); 20 Jan 2010 13:08:26 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp007) with SMTP; 20 Jan 2010 14:08:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/fL94VMbTf8yPDZ8SsDotzFlpiMHodxGtlZ6lbZK
	UsD1u3u/5p3sgU
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1263980322-4142-1-git-send-email-gitster@pobox.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68999999999999995
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137549>

Hi,

On Wed, 20 Jan 2010, Junio C Hamano wrote:

> Earlier I wondered if the approach Dscho's patch takes to teach the new
> @{upstream} syntax to substitute_branch_name() (hence dwim_ref()) without
> teaching it to interpret_branch_name() (hence strbuf_branchname()) was a
> bad idea.  I thought about this a bit more; there are some downsides for
> not doing so.
> 
> The first patch adds a handful of tests that show why strbuf_branchname()
> callers may also want to learn about the new syntax.  The second patch
> moves the logic to interpret_branch_name() to make them happier.

Looks good to me.

Ciao,
Dscho

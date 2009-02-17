From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use DIFF_XDL_SET/DIFF_OPT_SET instead of raw
 bit-masking
Date: Tue, 17 Feb 2009 13:05:26 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902171304130.6185@intel-tinevez-2-302>
References: <1234841209-3960-1-git-send-email-keith@cs.ucla.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@madism.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Keith Cascio <keith@cs.ucla.edu>
X-From: git-owner@vger.kernel.org Tue Feb 17 13:07:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZOj3-0003nM-FX
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 13:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbZBQMFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 07:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbZBQMF3
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 07:05:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:49423 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751047AbZBQMF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 07:05:29 -0500
Received: (qmail invoked by alias); 17 Feb 2009 12:05:27 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 17 Feb 2009 13:05:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18tNF8n0hgt0DTT1xXQbIyA3TQ3XsZF+U8B8YfuW5
	0XGvmJR2yyghTd
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1234841209-3960-1-git-send-email-keith@cs.ucla.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110365>

Hi,

On Mon, 16 Feb 2009, Keith Cascio wrote:

> 
> Signed-off-by: Keith Cascio <keith@cs.ucla.edu>
> ---

Rationale?

If you are going to add something on top of that, I can understand that, 
but this patch is not labeled [1/n].  And...

>  diff.h |    3 +++
>  diff.c |   17 ++++++++++-------
>  2 files changed, 13 insertions(+), 7 deletions(-)

... this does not look good to me, without a compelling reason why we want 
to have the patch nevertheless.

Ciao,
Dscho

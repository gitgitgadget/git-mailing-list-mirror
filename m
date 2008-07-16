From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] rebase-i: keep old parents when preserving merges
Date: Wed, 16 Jul 2008 11:43:01 +0200
Message-ID: <20080716094301.GA25087@leksak.fem-net>
References: <1216173109-11155-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807160432480.2841@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 16 11:44:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ3YV-0000wh-67
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 11:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426AbYGPJnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 05:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755135AbYGPJnO
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 05:43:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:53047 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752960AbYGPJnK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 05:43:10 -0400
Received: (qmail invoked by alias); 16 Jul 2008 09:43:07 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp045) with SMTP; 16 Jul 2008 11:43:07 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19jBOMhxl5j0Bm4nn154tpecj/Z4gNnEgW6EBExlS
	Wm28Vo6JP5B3OB
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KJ3XJ-0006XN-7h; Wed, 16 Jul 2008 11:43:01 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807160432480.2841@eeepc-johanness>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88653>

Hi,

Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 16 Jul 2008, Stephan Beyer wrote:
> 
> > This patch fixes two issues for rebase -i with preserving
> > merges of unrelated branches.
> 
> Two?  What's the second?

Oh, eh, well ;)
It's only one bug, but it results in two different behaviors...
If you have a merge with more than two parents and not all are lost,
then it merges with too few parents.
If you have a merge with exactly two parents and one is lost, then
it tries to cherry-pick (with an error).
"Two" "issues" :)

Regards.
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F

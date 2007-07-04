From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch: make output nicer
Date: Wed, 4 Jul 2007 14:25:34 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707041421190.4071@racer.site>
References: <Pine.LNX.4.64.0707041345230.4071@racer.site>
 <Pine.LNX.4.64.0707041349330.4071@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 04 15:27:10 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I64sv-0003YD-3Q
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 15:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761975AbXGDNZr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 09:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761570AbXGDNZr
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 09:25:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:60246 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760261AbXGDNZp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 09:25:45 -0400
Received: (qmail invoked by alias); 04 Jul 2007 13:25:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 04 Jul 2007 15:25:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ZVQU34g4Znf7qPpBTZQA+Xav/XAz5G3vFuwSVNB
	Kmn8rYFv+StvXH
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707041349330.4071@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51609>

Hi,

On Wed, 4 Jul 2007, Johannes Schindelin wrote:

> -		sh -c "$filter_commit" "git commit-tree" $(git write-tree) $parentstr | \
> -		tee ../map/$commit
> +		(sh -c "$filter_commit" "git commit-tree" $(git write-tree)
> +			$parentstr) 2> /dev/null > ../map/$commit

Aargh! I seem to be unable to get anything right today. This should be

+		sh -c "$filter_commit" "git commit-tree" $(git write-tree) \
+			$parentstr > ../map/$commit

Ah well. I think I play a little more with it, and resubmit the patch. 
Please ignore.

Ciao,
Dscho

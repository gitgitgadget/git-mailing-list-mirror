From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/v2] git-basis, a script to manage bases for git-bundle
Date: Fri, 4 Jul 2008 14:22:57 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807041420330.9925@racer>
References: <1214272713-7808-1-git-send-email-adambrewster@gmail.com> <c376da900806301549r6044cd35r5a23baa405570808@mail.gmail.com> <7vzlp1jh1o.fsf@gitster.siamese.dyndns.org> <486AC8E0.60002@verizon.net> <c376da900807031613pc63639du356946f8daeabb29@mail.gmail.com>
 <486E2245.6040404@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Adam Brewster <adambrewster@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 15:26:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KElIL-0007A3-V7
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 15:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876AbYGDNYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 09:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841AbYGDNYw
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 09:24:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:43829 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752500AbYGDNYv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 09:24:51 -0400
Received: (qmail invoked by alias); 04 Jul 2008 13:24:49 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp015) with SMTP; 04 Jul 2008 15:24:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19nzks5tElnIv5fOCia6VgxEf7N7WIfamBhXj7eZY
	eYQh75274czsap
X-X-Sender: gene099@racer
In-Reply-To: <486E2245.6040404@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87385>

Hi,

On Fri, 4 Jul 2008, Mark Levedahl wrote:

> I'm using this for sneaker-netting, so I know the bundles are being 
> applied - clearly the create bundle and update in-tree basis steps could 
> be separated, but I don't use this for cases where I'm not sure the 
> bundle will be applied.

/me wonders if it would not make sense to support "git push <bundle>", 
then.  Maybe with a running counter, i.e.

	$ git push the-bundle-5.bundle master

would create the-bundle-6.bundle with everything needed in addition to 
the-bundle-5.bundle to have the current "master".

Just an idea,
Dscho

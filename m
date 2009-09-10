From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCHv5 00/14] git notes
Date: Thu, 10 Sep 2009 08:23:11 +0200
Message-ID: <20090910062311.GA27466@cuci.nl>
References: <1252376822-6138-1-git-send-email-johan@herland.net> <200909081436.30761.johan@herland.net> <alpine.DEB.1.00.0909081741590.4330@intel-tinevez-2-302> <200909090046.45213.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Sep 10 08:30:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MldBF-0001HX-Ma
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 08:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755149AbZIJGaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 02:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755144AbZIJGaO
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 02:30:14 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:43228 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755140AbZIJGaK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 02:30:10 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Sep 2009 02:30:10 EDT
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 377E65420; Thu, 10 Sep 2009 08:23:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200909090046.45213.johan@herland.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128096>

Johan Herland wrote:
>I was, however, naive enough to assume that when git.git decided on using 
>2/38 fanout for its loose objects, then some performance-related thoughts
>went into that decision. If there are indications that multiple-of-2-type 

I presume that that choice was based on the fact that on a typical filesystem
(e.g. ext2 old-style) without directory indexing, the sort-of optimal fanout
should aim for no more than 100-200 directory entries per directory.
-- 
Sincerely,
           Stephen R. van den Berg.

Mommy, what happens to your files when you die?

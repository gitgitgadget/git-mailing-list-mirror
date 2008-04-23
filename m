From: Johan Herland <johan@herland.net>
Subject: Re: Git on Windows, CRLF issues
Date: Wed, 23 Apr 2008 16:24:09 +0200
Message-ID: <200804231624.09465.johan@herland.net>
References: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se> <20080423081025.GB11935@sigill.intra.peff.net> <Pine.LNX.4.64.0804231445550.18401@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Apr 23 16:26:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JofuW-0000bJ-61
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 16:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174AbYDWOYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 10:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753962AbYDWOYh
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 10:24:37 -0400
Received: from sam.opera.com ([213.236.208.81]:47260 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753715AbYDWOYg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 10:24:36 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m3NEO9Kg021926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 Apr 2008 14:24:10 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <Pine.LNX.4.64.0804231445550.18401@ds9.cixit.se>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.92.1/6902/Wed Apr 23 09:30:49 2008 on smtp.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80221>

On Wednesday 23 April 2008, Peter Karlsson wrote:
> Jeff King:
> > Sure, but that is quite slow on a larger tree, since it has to do a
> > full checkout for each commit.
>
> Indeed. That's why I would welcome a script such as the one you
> mentioned :-) Fortunately, the repositories I worked on were small
> enough to not suffer too much (even when using Git on Windows, which
> is a bit slower than on Linux).
>
> [Not seeing any unreachable objects]
>
> > Did you remove refs/original/ ?
>
> That, and cloned the repository to a new location after the
> conversion, and removing the references to "origin" there. It does
> seem that the objects are still there, but I can't see them with
> "gitk --all".

Maybe they are kept alive by reflogs?


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

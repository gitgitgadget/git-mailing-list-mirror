From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Introduce <branch>@{tracked} as shortcut to the tracked branch
Date: Thu, 10 Sep 2009 12:18:06 +0200
Message-ID: <200909101218.06789.johan@herland.net>
References: <20090904135414.GA3728@honk.padd.com> <alpine.DEB.1.00.0909101135590.8306@pacific.mpi-cbg.de> <4AA8CA88.9060802@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Pete Wyckoff <pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 10 12:18:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mlgjf-0007gF-Nc
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 12:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755347AbZIJKSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 06:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755336AbZIJKSa
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 06:18:30 -0400
Received: from sam.opera.com ([213.236.208.81]:40549 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753053AbZIJKSa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 06:18:30 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id n8AAI6Ok008488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 10 Sep 2009 10:18:12 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <4AA8CA88.9060802@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128106>

On Thursday 10 September 2009, Michael J Gruber wrote:
> Johannes Schindelin venit, vidit, dixit 10.09.2009 11:36:
> > Often, it is quite interesting to inspect the branch tracked by a
> > given branch.  This patch introduces a nice notation to get at the
> > tracked branch: '<branch>@{tracked}' can be used to access that
> > tracked branch.
> >
> > A special shortcut '@{tracked}' refers to the branch tracked by the
> > current branch.
>
> Sorry, I didn't know the name of the long form was up for discussion.
> But it should certainly coincide with the key which for-each-ref
> uses, shouldn't it? I don't care whether tracked or upstream, but
> for-each-ref's "upstream" has set the precedent.

...and 'git branch --track' set an even earlier precedent...


...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net

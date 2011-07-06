From: Ted Ts'o <tytso@mit.edu>
Subject: Re: generation numbers (was: [PATCH 0/4] Speed up git tag
 --contains)
Date: Wed, 6 Jul 2011 11:01:03 -0400
Message-ID: <20110706150103.GA2693@thunk.org>
References: <1307819051-25748-1-git-send-email-avarab@gmail.com>
 <20110706064012.GA927@sigill.intra.peff.net>
 <20110706065623.GB14164@elie>
 <20110706070311.GA3790@sigill.intra.peff.net>
 <m3mxgr4has.fsf_-_@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 17:01:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeTbI-0004nx-Qu
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 17:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896Ab1GFPBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 11:01:12 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:55841 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752067Ab1GFPBL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 11:01:11 -0400
Received: from root (helo=tytso-glaptop)
	by test.thunk.org with local-esmtp (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1QeTb7-0004jj-0m; Wed, 06 Jul 2011 15:01:05 +0000
Received: from tytso by tytso-glaptop with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1QeTb5-0000qJ-JP; Wed, 06 Jul 2011 11:01:03 -0400
Content-Disposition: inline
In-Reply-To: <m3mxgr4has.fsf_-_@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on test.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176707>

Is it worth it to try to replicate this information across repositories?

Why not just simply have a cache file in the git directory which is
managed somewhat like gitk.cache; call it generation.cache?

						- Ted

From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: [PATCH 2/2] archive: support gzipped tar files
Date: Tue, 14 Jun 2011 12:25:17 -0700
Message-ID: <4DF7B59D.30306@eaglescrag.net>
References: <20110614181732.GA31635@sigill.intra.peff.net> <20110614181821.GA32685@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>,
	git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 21:25:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWZF3-0007uN-V9
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 21:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987Ab1FNTZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 15:25:32 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:32980 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509Ab1FNTZc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 15:25:32 -0400
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id p5EJPHKi003593
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Tue, 14 Jun 2011 12:25:18 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <20110614181821.GA32685@sigill.intra.peff.net>
X-Enigmail-Version: 1.1.2
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Tue, 14 Jun 2011 12:25:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175790>

On 06/14/2011 11:18 AM, Jeff King wrote:
> git-archive already supports the creation of tar files. For
> local cases, one can simply pipe the output to gzip, and
> having git-archive do the gzip is a minor convenience.
> 
> However, when running git-archive against a remote site,
> having the remote side do the compression can save
> considerable bandwidth. Service providers could always wrap
> git-archive to provide that functionality, but this makes it
> much simpler.
> 
> Creating gzipped archives is of course more expensive than
> regular tar archives; however, the amount of work should be
> comparable to that of creating a zip file, which is already
> possible. So there should be no new security implications
> with respect to creating load on a remote server.

Would it make sense to make this a little more generic and support bz2
and xz as well?

- John 'Warthog9' Hawley

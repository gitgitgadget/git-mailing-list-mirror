From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: mirror git repos: rsync vs. --mirror
Date: Wed, 31 Mar 2010 03:05:53 +0000
Message-ID: <robbat2-20100331T030517-069108593Z@orbis-terrarum.net>
References: <robbat2-20100330T205331-531407911Z@orbis-terrarum.net>
 <3a75d1efc7cf125d84b8e02b7dabf7aa@212.159.54.234>
 <t2r2e24e5b91003301844i6ea98c92j6dba55d916c841f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 31 05:06:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwoGT-0003B9-Ej
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 05:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754623Ab0CaDGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 23:06:39 -0400
Received: from [208.71.112.51] ([208.71.112.51]:45136 "EHLO mail.isohunt.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751629Ab0CaDGi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 23:06:38 -0400
Received: (qmail 30078 invoked from network); 31 Mar 2010 03:05:56 -0000
Received: from tsi-static.orbis-terrarum.net (HELO grubbs.orbis-terrarum.net) (76.10.188.108)
    by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (CAMELLIA256-SHA encrypted) ESMTPS; Wed, 31 Mar 2010 03:05:56 +0000
Received: (qmail 2665 invoked by uid 10000); 31 Mar 2010 03:05:53 -0000
Content-Disposition: inline
In-Reply-To: <t2r2e24e5b91003301844i6ea98c92j6dba55d916c841f5@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143640>

On Wed, Mar 31, 2010 at 07:14:46AM +0530, Sitaram Chamarty wrote:
> On Wed, Mar 31, 2010 at 3:30 AM, Julian Phillips
> <julian@quantumfyre.co.uk> wrote:
> > On Tue, 30 Mar 2010 20:54:09 +0000, "Robin H. Johnson"
> > <robbat2@gentoo.org>
> 
> >> git clone --mirror && git fetch:
> 
> >> Caveats:
> >> - Branches and tags deleted in master persist in slaves :-(
> 
> > I don't think that fetch can do it, but "git remote prune origin" will.
> as of 1.7 at least, fetch has --prune, and I tested it yesterday when
> someone (same person?) asked this on #git
Wasn't me asking, but thanks, that helps lots!

Looks like it was added for v1.6.6.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

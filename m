From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: merge smart enough to adapt to renames?
Date: Thu, 19 Feb 2009 14:25:30 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngpqquq.j03.sitaramc@sitaramc.homelinux.net>
References: <81bfc67a0902182212h578e677ck6029c56cb86f7bce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 15:27:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La9rt-0008IJ-Kg
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 15:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbZBSOZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 09:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbZBSOZq
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 09:25:46 -0500
Received: from main.gmane.org ([80.91.229.2]:50093 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbZBSOZp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 09:25:45 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1La9qP-0002we-8t
	for git@vger.kernel.org; Thu, 19 Feb 2009 14:25:41 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 14:25:41 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 14:25:41 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110707>

On 2009-02-19, Caleb Cushing <xenoterracide@gmail.com> wrote:
> branch gentoo.org has a file profiles/package.mask
>
> the software that uses this supports having this be a directory as well.
>
> I'm thinking of mv-ing this file in branch regen2.org to
> profiles/package.mask/gentoo.org
>
> since I can't change the location in gentoo.org (for mostly
> non-technical reasons) when I run git merge gentoo.org from regen2.org
> will git be smart enough to try to merge an updated
> profiles/package.mask into profiles/package.mask/gentoo.org in the
> future?

Yes.  I maintain two copies of something (in different
repos) like this...

From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 2/2] clone: use computed length in guess_dir_name
Date: Wed, 5 Aug 2015 10:49:11 +0200
Message-ID: <55C1CE07.9010602@gmail.com>
References: <20150805083526.GA22325@sigill.intra.peff.net>
 <20150805083945.GB28212@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Git Mailing List <git@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 10:49:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMuOC-0004IY-3o
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 10:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752358AbbHEItV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 04:49:21 -0400
Received: from plane.gmane.org ([80.91.229.3]:45332 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752340AbbHEItT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 04:49:19 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZMuNx-0004BW-0M
	for git@vger.kernel.org; Wed, 05 Aug 2015 10:49:17 +0200
Received: from 131.228.216.134 ([131.228.216.134])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 10:49:16 +0200
Received: from sschuberth by 131.228.216.134 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 10:49:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 131.228.216.134
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <20150805083945.GB28212@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275357>

On 8/5/2015 10:39, Jeff King wrote:

> Commit 7e837c6 (clone: simplify string handling in
> guess_dir_name(), 2015-07-09) changed clone to use
> strip_suffix instead of hand-rolled pointer manipulation.
> However, strip_suffix will strip from the end of a
> NUL-terminated string, and we may have already stripped some
> characters (like directory separators, or "/.git"). This
> leads to commands like:
> 
>    git clone host:foo.git/
> 
> failing to strip the ".git".

Thanks a lot Peff for fixing my bugs, I should have known that you'll be able to come up with something much sooner than I would ;-)

This all looks good to me!

Regards,
Sebastian

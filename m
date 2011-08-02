From: Pete Wyckoff <pw@padd.com>
Subject: Re: refs/replace advice
Date: Tue, 2 Aug 2011 17:54:15 -0400
Message-ID: <20110802215415.GA13327@arf.padd.com>
References: <20110729153122.GA4535@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 02 23:54:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoMuv-0002Gb-2w
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 23:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755415Ab1HBVyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 17:54:20 -0400
Received: from honk.padd.com ([74.3.171.149]:58472 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755479Ab1HBVyT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 17:54:19 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id 7F95620D8;
	Tue,  2 Aug 2011 14:54:18 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 9D33D315F8; Tue,  2 Aug 2011 17:54:15 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20110729153122.GA4535@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178513>

pw@padd.com wrote on Fri, 29 Jul 2011 08:31 -0700:
> I've got two near-identical git repos, both imported from
> gigantic upstream p4 repos.  They started at slightly different
> times so have different commit SHA1s, even though the tree
> contents are the same.  I can't filter-branch either of them; too
> many users already.
>
> I'm trying to use "git replace" to avoid cloning the entire set
> of duplicate commits across a slow inter-site link.  Like this:

To follow-up, I decided this was not the right approach.
Instead, for future git-p4 repo creation, I've patched git-p4
to make sure the timestamps and hence the initial SHA1s are
identical.

Thanks, Hannes, for your suggestion, though.

		-- Pete

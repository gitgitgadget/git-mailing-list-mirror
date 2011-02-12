From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] Obey p4 views when using client spec
Date: Sat, 12 Feb 2011 16:51:33 -0500
Message-ID: <20110212215133.GA21494@mew.padd.com>
References: <4D55D56C.6050207@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Tor Arvid Lund <torarvid@gmail.com>
To: Ian Wienand <ianw@vmware.com>
X-From: git-owner@vger.kernel.org Sat Feb 12 22:52:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoNNn-0001VQ-NA
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 22:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972Ab1BLVvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 16:51:46 -0500
Received: from honk.padd.com ([74.3.171.149]:54491 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752910Ab1BLVvp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 16:51:45 -0500
Received: from mew.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id EF962BC;
	Sat, 12 Feb 2011 13:51:43 -0800 (PST)
Received: by mew.padd.com (Postfix, from userid 7770)
	id D02E826ABA; Sat, 12 Feb 2011 16:51:33 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4D55D56C.6050207@vmware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166624>

ianw@vmware.com wrote on Fri, 11 Feb 2011 16:33 -0800:
> When using the p4 client spec, this attempts to obey the client's
> output preferences.
> 
> For example, a view like
> 
> //depot/foo/branch/... //client/branch/foo/...
> //depot/bar/branch/... //client/branch/bar/...
> 
> will result in a directory layout in the git tree of
> 
> branch/
> branch/foo
> branch/bar
> 
> p4 can do various other reordering that this change doesn't support,
> but we should detect it and at least fail nicely.
> 
> Signed-off-by: Ian Wienand <ianw@vmware.com>

Nice, thanks for making the changes.

Acked-by: Pete Wyckoff <pw@padd.com>

From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] t9157-git-svn-fetch-merge.sh: remove dependency on
	subversion 1.5
Date: Thu, 25 Nov 2010 23:39:22 +0000
Message-ID: <20101125233922.GA3317@dcvr.yhbt.net>
References: <1287737937.3785.15.camel@balanced-tree> <1287798958-22549-1-git-send-email-stevenrwalter@gmail.com> <alpine.DEB.2.02.1011181606340.14285@dr-wily.mit.edu> <alpine.DEB.2.02.1011181826560.14285@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anders Kaseorg <andersk@MIT.EDU>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 00:45:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLlVU-0002CY-Id
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 00:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694Ab0KYXpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 18:45:16 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:49688 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752671Ab0KYXpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 18:45:16 -0500
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Nov 2010 18:45:16 EST
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC9971F7B3;
	Thu, 25 Nov 2010 23:39:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1011181826560.14285@dr-wily.mit.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162158>

Anders Kaseorg <andersk@MIT.EDU> wrote:
> On Thu, 18 Nov 2010, Anders Kaseorg wrote:
> > Junio: Did this get lost?  It fixes a test suite regression between 
> > v1.7.3.1 and v1.7.3.2 on systems with Subversion 1.4.
> 
> Hmm, perhaps I spoke too soon; when I actually run the patched test on an 
> Ubuntu 8.04 system, I still get a failure.  Apparently Subversion 1.4 
> thinks the manually set svn:mergeinfo properties cause conflicts:

Perhaps the test (and feature) should just be disabled with older SVN?

-- 
Eric Wong

From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [JGIT PATCH 00/14] TreeWalk D/F conflict detection
Date: Tue, 19 Aug 2008 09:52:11 +0100
Message-ID: <1219135931.3184.473.camel@pmac.infradead.org>
References: <1219103602-32222-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 10:53:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVMxr-0007gw-Ul
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 10:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbYHSIwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 04:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbYHSIwQ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 04:52:16 -0400
Received: from bombadil.infradead.org ([18.85.46.34]:41825 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbYHSIwP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 04:52:15 -0400
Received: from pmac.infradead.org ([2001:8b0:10b:1:20d:93ff:fe7a:3f2c])
	by bombadil.infradead.org with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1KVMwn-0005Sb-GE; Tue, 19 Aug 2008 08:52:13 +0000
In-Reply-To: <1219103602-32222-1-git-send-email-spearce@spearce.org>
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by bombadil.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92834>

On Mon, 2008-08-18 at 16:53 -0700, Shawn O. Pearce wrote:
> This series is about fixing the "mistake" in Git trees where
> subtrees sort as through their name is "path/" and not "path".

Er, really? Does that mean this commit is broken, then?

http://git.kernel.org/?p=linux/kernel/git/dwmw2/misc-git-hacks.git;a=commitdiff;h=fc1b73da

I shouldn't need to know that -- I'd _really_ like a version of
'git-hash-object -t tree' which validates and sorts its input for me.
And maybe even takes input in _text_ form, so I don't have to convert
the sha1 to binary.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation

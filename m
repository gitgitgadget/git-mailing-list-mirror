From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Synchronize highlighting in file view when
 scrolling diff
Date: Wed, 19 Sep 2012 09:46:11 +1000
Message-ID: <20120918234611.GA5544@bloggs.ozlabs.ibm.com>
References: <1347947874-38597-1-git-send-email-stefan@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Haller <stefan@haller-berlin.de>
X-From: git-owner@vger.kernel.org Wed Sep 19 02:02:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE7kf-0004HX-7c
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 02:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755349Ab2ISACj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 20:02:39 -0400
Received: from ozlabs.org ([203.10.76.45]:58685 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753721Ab2ISACi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 20:02:38 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 85F412C0084; Wed, 19 Sep 2012 10:02:37 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <1347947874-38597-1-git-send-email-stefan@haller-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205898>

On Tue, Sep 18, 2012 at 07:57:54AM +0200, Stefan Haller wrote:
> Whenever the diff pane scrolls, highlight the corresponding file in the
> file list on the right. For a large commit with many files and long
> per-file diffs, this makes it easier to keep track of what you're looking
> at.

I like this as far as it goes, but the one criticism I would have is
that when you find a string (using the "Search" button), the filename
that gets highlighted is often not the file in which the string was
found (because the highlighting is based on the top line visible in
the text window), which could be confusing.

Can you think of a way to solve that too?  Perhaps make the
highlighting based on the currently highlighted instance of the search
string, if there is one, otherwise based on the top line visible?

Paul.

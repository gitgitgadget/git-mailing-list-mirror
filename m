From: Max Nanasy <max.nanasy@gmail.com>
Subject: Re: git merge <tag> behavior
Date: Thu, 21 Mar 2013 20:31:30 +0000 (UTC)
Message-ID: <loom.20130321T212911-611@post.gmane.org>
References: <1363704914.6289.39.camel@test.quest-ce.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 21 21:35:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UImCe-0008RX-3o
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 21:35:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782Ab3CUUeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 16:34:44 -0400
Received: from plane.gmane.org ([80.91.229.3]:44339 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752769Ab3CUUeo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 16:34:44 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UImCW-0008Jr-Ji
	for git@vger.kernel.org; Thu, 21 Mar 2013 21:35:04 +0100
Received: from inet-rmmc09-o.oracle.com ([148.87.67.204])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Mar 2013 21:35:04 +0100
Received: from max.nanasy by inet-rmmc09-o.oracle.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Mar 2013 21:35:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 148.87.67.204 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218755>

Yann Droneaud <ydroneaud <at> opteya.com> writes:

> 
> 3) Merge options can't be overridden.
> 
> If I modify .git/config to set a merge option, for example forcing
> fast-forward merge, this option cannot be overridden on command line:
> 

(git merge --no-ff-only --no-ff) should work.  The --no-ff-only overrides
the --ff-only configuration setting, and the --no-ff ensures that the merge
is not a fast-forward.

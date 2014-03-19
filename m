From: Sylvestre Ledru <sylvestre@mozilla.com>
Subject: Re: [BUG] Segfault on git describe
Date: Wed, 19 Mar 2014 12:03:06 +0000 (UTC)
Message-ID: <loom.20140319T130131-192@post.gmane.org>
References: <532975FB.9030803@mozilla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 13:05:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQbim-0007XE-MH
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 13:05:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758085AbaCTMFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 08:05:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:58379 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757428AbaCTMFG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 08:05:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WQbiZ-0007Fo-OM
	for git@vger.kernel.org; Thu, 20 Mar 2014 13:05:03 +0100
Received: from 89.202.203.51 ([89.202.203.51])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 13:05:03 +0100
Received: from sylvestre by 89.202.203.51 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 13:05:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 89.202.203.51 (Mozilla/5.0 (X11; Linux x86_64; rv:29.0) Gecko/20100101 Firefox/29.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244544>

Sylvestre Ledru <sylvestre <at> mozilla.com> writes:


> As attachment, the backtrace. I removed about 87250 calls to the
> name_rev function. I guess that is a potential source of problem.
FYI, ulimit -s 100000 (increase the stack size) fixes the issue.

Sylvestre

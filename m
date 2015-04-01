From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH] git-common-dir: make submodule related variables
 worktree specific
Date: Thu, 2 Apr 2015 00:45:25 +0300
Message-ID: <20150401214525.GC8771@wheezy.local>
References: <1427923407-7939-1-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 01 23:45:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdQRu-0003w0-SF
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 23:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbbDAVpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2015 17:45:17 -0400
Received: from p3plsmtpa08-10.prod.phx3.secureserver.net ([173.201.193.111]:57493
	"EHLO p3plsmtpa08-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751149AbbDAVpR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Apr 2015 17:45:17 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa08-10.prod.phx3.secureserver.net with 
	id AllC1q00G5B68XE01llEZr; Wed, 01 Apr 2015 14:45:16 -0700
Content-Disposition: inline
In-Reply-To: <1427923407-7939-1-git-send-email-max@max630.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266622>

On Thu, Apr 02, 2015 at 12:23:27AM +0300, Max Kirillov wrote:
> Then submodules in different worktrees will be fully independent.
> They can, and should, be initialised and updated separately.
> 
> Update t7410-submodule-checkout-to.sh to consider this.
> 
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
> Now when there is implementation for worktree-specific module it is possible
> to make submodules in different worktrees fully independent.
> 
> Should be applied over current next (111ea16e53) with merged $gmane/266520 and $gmane/266614

I mean $gmane/266520 and $gmane/265762

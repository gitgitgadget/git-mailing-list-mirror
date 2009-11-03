From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: determine if the tree is dirty
Date: Tue, 3 Nov 2009 13:06:19 -0600
Message-ID: <20091103190619.GC30171@unpythonic.net>
References: <799406d60911031057l5dcb4d4fi3705cc66997ff7f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Mercer <ramercer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 20:06:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5OiC-0001u4-57
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 20:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbZKCTG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 14:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbZKCTG1
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 14:06:27 -0500
Received: from dsl.unpythonic.net ([206.222.212.217]:40705 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750879AbZKCTG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 14:06:26 -0500
Received: by unpythonic.net (Postfix, from userid 1000)
	id 5C55A11456C; Tue,  3 Nov 2009 13:06:19 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <799406d60911031057l5dcb4d4fi3705cc66997ff7f7@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131988>

On Tue, Nov 03, 2009 at 12:57:37PM -0600, Adam Mercer wrote:
> As part of a python script I need to determine if a tree has any
> uncommitted changes

GIT-VERSION-GEN uses something like this (shell script):
        git update-index -q --refresh
        test -z "$(git diff-index --name-only HEAD --)" || VN="$VN-dirty" ;;

Jeff

From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 1/3] gitweb: Move 'lineno' id from link to row element
	in git_blame
Date: Wed, 17 Dec 2008 09:13:00 +0100
Message-ID: <20081217081300.GB3640@machine.or.cz>
References: <20081209223703.28106.29198.stgit@localhost.localdomain> <20081209224330.28106.18301.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 09:14:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCrXy-0001V6-H6
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 09:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbYLQINF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 03:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbYLQIND
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 03:13:03 -0500
Received: from w241.dkm.cz ([62.24.88.241]:49247 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834AbYLQIND (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 03:13:03 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 69489244C024; Wed, 17 Dec 2008 09:13:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081209224330.28106.18301.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103313>

On Tue, Dec 09, 2008 at 11:46:16PM +0100, Jakub Narebski wrote:
> Move l<line number> ID from <a> link element inside table row (inside
> cell element for column with line numbers), to encompassing <tr> table
> row element.  It was done to make it easier to manipulate result HTML
> with DOM, and to be able write 'blame_incremental' view with the same,
> or nearly the same result.
> 
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>

Acked-by: Petr Baudis <pasky@suse.cz>

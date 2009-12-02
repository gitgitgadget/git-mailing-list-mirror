From: Alex Vandiver <alex@chmrr.net>
Subject: Re: [PATCH 2/5] git-svn: Make merge metadata accessible to make_log_entry
Date: Wed, 02 Dec 2009 15:46:41 -0500
Message-ID: <1259786690-sup-8337@utwig>
References: <1259780874-14706-1-git-send-email-alex@chmrr.net> <1259780874-14706-3-git-send-email-alex@chmrr.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 02 21:46:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFw64-0004IH-6e
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 21:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788AbZLBUqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 15:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754536AbZLBUqf
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 15:46:35 -0500
Received: from chmrr.net ([209.67.253.66]:52222 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754530AbZLBUqe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 15:46:34 -0500
Received: from chmrr by utwig.chmrr.net with local (Exim 4.69)
	(envelope-from <chmrr@chmrr.net>)
	id 1NFw5x-0004bZ-49
	for git@vger.kernel.org; Wed, 02 Dec 2009 15:46:41 -0500
In-reply-to: <1259780874-14706-3-git-send-email-alex@chmrr.net>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134397>

At Wed Dec 02 14:07:51 -0500 2009, Alex Vandiver wrote:
> @@ -2944,14 +2944,15 @@ sub find_extra_svk_parents {
>                  # wahey!  we found it, but it might be
>                  # an old one (!)
>                  push @known_parents, [ $rev, $commit ];
> +                push @known_parents, [ $rev, $path, $commit ];
>              }
>          }
>      }

This hunk is wrong due to a mis-merge on my part -- the first 'push'
line should have been removed, obviously.  I'll wait for other
comments before I push a v2, however.

 - Alex
-- 
Networking -- only one letter away from not working

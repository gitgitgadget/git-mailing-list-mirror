From: <dag@cray.com>
Subject: Re: git-svn: cloning an SVN repo with sub-branches and sub-tags
Date: Thu, 29 Mar 2012 10:56:25 -0500
Message-ID: <nngbonfz9hy.fsf@transit.us.cray.com>
References: <4F7467E1.3090004@pocock.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Daniel Pocock <daniel@pocock.com.au>
X-From: git-owner@vger.kernel.org Thu Mar 29 17:56:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDHiM-000852-Nc
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 17:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759527Ab2C2P4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 11:56:38 -0400
Received: from exprod6og102.obsmtp.com ([64.18.1.183]:36499 "EHLO
	exprod6og102.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759504Ab2C2P4h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 11:56:37 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob102.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT3SGMK7lR1+7IvVjhS1OJkDyBeslKScN@postini.com; Thu, 29 Mar 2012 08:56:36 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 29 Mar
 2012 10:56:32 -0500
In-Reply-To: <4F7467E1.3090004@pocock.com.au> (Daniel Pocock's message of
	"Thu, 29 Mar 2012 14:47:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194263>

Daniel Pocock <daniel@pocock.com.au> writes:

> branches/user1/workitem1
> branches/user1/workitem2
> branches/user2/workitem1
> branches/user2/workitem2
> git svn clone \
>   -T trunk \
>   -t tags \
>   -b branches \
>   https://flactag.svn.sourceforge.net/svnroot/flactag \
>   flactag-git1

I think you need to add --branches=branches/user1/workitem1
--branches=branches/user1/workitem1, etc.  Ditto for tags.

                               -Dave

From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: git-kill: rewrite history removing a commit
Date: Thu, 01 Feb 2007 12:41:05 +0000
Message-ID: <tnxzm7yhwym.fsf@arm.com>
References: <20070131195533.GE21097@mellanox.co.il>
	<20070131202204.GB5362@nan92-1-81-57-214-146.fbx.proxad.net>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Thu Feb 01 13:41:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCbG4-0003VZ-OM
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 13:41:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422838AbXBAMlj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 07:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422839AbXBAMlj
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 07:41:39 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:40136 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422838AbXBAMli (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Feb 2007 07:41:38 -0500
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id l11Cf6Yo011766;
	Thu, 1 Feb 2007 12:41:10 GMT
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Thu, 1 Feb 2007 12:41:56 +0000
In-Reply-To: <20070131202204.GB5362@nan92-1-81-57-214-146.fbx.proxad.net> (Yann
 Dirson's message of "Wed, 31 Jan 2007 21:22:04 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 01 Feb 2007 12:41:56.0323 (UTC) FILETIME=[5B8B8B30:01C745FE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38347>

Yann Dirson <ydirson@altern.org> wrote:
> I'd suggest to use stgit to prepare commits before publication.  Even
> if you don't feel the need for it in everyday life, you can have a
> one-shot use for this particular problem, by turning your latest
> commits into an stgit stack, use stgit facilities to handle posible
> conflicts, and turn them into commits again:
>
> The nominal case goes:
>
>   stg init
>   stg uncommit -n <ncommits>
>   stg float <patch-to-kill>
>   stg delete <patch-to-kill>

or "stg pop <patch-to-kill>" instead of 'float'. Recently, I changed the
'pop' command to accept individual patches and patch ranges (for
symmetry with 'push').

-- 
Catalin

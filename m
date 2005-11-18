From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Remove all old packfiles when doing "git repack -a -d"
Date: Fri, 18 Nov 2005 13:15:35 -0800
Message-ID: <7vek5dhd3c.fsf@assigned-by-dhcp.cox.net>
References: <437E3B3C.9000409@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 22:26:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdDa8-0000ue-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 22:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbVKRVPh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 18 Nov 2005 16:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbVKRVPh
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 16:15:37 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:50343 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750934AbVKRVPg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 16:15:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051118211419.UEO20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Nov 2005 16:14:19 -0500
To: Lukas =?iso-8859-1?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>
In-Reply-To: <437E3B3C.9000409@etek.chalmers.se> (Lukas =?iso-8859-1?Q?San?=
 =?iso-8859-1?Q?dstr=F6m's?= message
	of "Fri, 18 Nov 2005 21:36:12 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12266>

Lukas Sandstr=F6m <lukass@etek.chalmers.se> writes:

> No point in running git-pack-redundant if we already know=20
> which packs are redundant.
>
> Signed-off-by: Lukas Sandstr=F6m <lukass@etek.chalmers.se>

This makes sense and makes me feel safer somehow.  Thanks.

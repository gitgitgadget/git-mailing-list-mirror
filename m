From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fixed two bugs in git-cvsimport-script.
Date: Wed, 17 Aug 2005 02:22:56 -0700
Message-ID: <7v3bp829zj.fsf@assigned-by-dhcp.cox.net>
References: <u5tacjjdpxq.fsf@lysator.liu.se> <u5tiry50ywy.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 11:24:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5K8T-0003wO-7z
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 11:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbVHQJW6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 05:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbVHQJW6
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 05:22:58 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:11225 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751021AbVHQJW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 05:22:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050817092256.MWJP12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 Aug 2005 05:22:56 -0400
To: David =?iso-2022-jp-2?B?SxsuQRtOZWdlZGFs?= <davidk@lysator.liu.se>
In-Reply-To: <u5tiry50ywy.fsf@lysator.liu.se> (David
 =?iso-2022-jp-2?B?SxsuQRtOZWdlZGFsJ3M=?= message of
	"Wed, 17 Aug 2005 10:07:25 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> Apparently, my mail was encoded as QP, which is not very popular
> around here.  But it seems that the diff part was decoded properly
> before applying.  Was that done manually?

Yes, the patch had some context conflicts with some other patch
so the patch application was done by hand, and I did a quick and
dirty cut & paste of the commit message from "cat mbox" output.

I will probably drop future patches encoded in QP.

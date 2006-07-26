From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make git-mv a builtin
Date: Tue, 25 Jul 2006 22:47:20 -0700
Message-ID: <7vk660udcn.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607260348130.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 26 07:47:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5cEv-0002b0-Kr
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 07:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWGZFrV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 01:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbWGZFrV
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 01:47:21 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:12718 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1030222AbWGZFrV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 01:47:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060726054720.ZECC18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Jul 2006 01:47:20 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24207>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This also moves add_file_to_index() to read-cache.c. Oh, and while
> touching builtin-add.c, it also removes a duplicate git_config() call.

I'd have preferred to see this not depend on uncooked
merge-recur infrastructure, since it is very likely that this
would be ready to graduate to "master" before merge-recur.

I've branched from "master" and placed the path-list stuff which
was split out of the merge-recur WIP, and applied this patch
with some trivial adjustment, and will place it on "pu", so I'd
appreciate if you can double check the result.

> diff --git a/builtin.h b/builtin.h
> index 5339d86..6f3a439 100755

Huh -- 100755?

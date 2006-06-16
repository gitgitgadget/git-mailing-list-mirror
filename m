From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-rebase nukes multiline comments
Date: Fri, 16 Jun 2006 14:25:58 -0700
Message-ID: <7v7j3gdc7t.fsf@assigned-by-dhcp.cox.net>
References: <20060616171251.GA29820@suse.de> <4492E8F9.4000106@shlrm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 16 23:26:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrLpL-0007ly-R4
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 23:26:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWFPV0A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 17:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWFPV0A
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 17:26:00 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:9642 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751453AbWFPVZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 17:25:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060616212559.KZKX23482.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Jun 2006 17:25:59 -0400
To: David Kowis <dkowis@shlrm.org>
In-Reply-To: <4492E8F9.4000106@shlrm.org> (David Kowis's message of "Fri, 16
	Jun 2006 12:23:05 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21972>

David Kowis <dkowis@shlrm.org> writes:

> commit c846bea8c61bec7cf0f7688c48abc42577b9ac7f
> Author: David Kowis <dkowis@kain.org>
> Date:   Fri Jun 16 12:20:08 2006 -0500
>
>     this is a multi
>
>     line comment
>     with three lines
>
>
> I'm using git 1.4.0. It added a blank line in there...

Actually, this is an odd but intended behaviour ;-).

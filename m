From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG?] git-clone fails on .git/refs/foo
Date: Sat, 10 Jun 2006 19:08:56 -0700
Message-ID: <7v7j3oh29z.fsf@assigned-by-dhcp.cox.net>
References: <20060610225040.GA7766@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 11 04:09:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpFNu-0002jC-Bs
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 04:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbWFKCI7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 22:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWFKCI6
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 22:08:58 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:19436 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751554AbWFKCI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jun 2006 22:08:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060611020857.ZZOS18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 10 Jun 2006 22:08:57 -0400
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20060610225040.GA7766@nowhere.earth> (Yann Dirson's message of
	"Sun, 11 Jun 2006 00:50:40 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21630>

Yann Dirson <ydirson@altern.org> writes:

> Could it be that git-clone has a problem when a ref is not inside a
> subdir of .git/refs ?
>
> Both 1.3.3 and 1.4.0 show the following problem, which prevents
> cloning from this repo:

I think it always has been like that, not that I consider it is
not a bug.

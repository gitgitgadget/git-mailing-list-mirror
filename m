From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] compress output of `cd' when installing templates
Date: Sun, 21 May 2006 11:23:44 -0700
Message-ID: <7vy7wvi6dr.fsf@assigned-by-dhcp.cox.net>
References: <83mzdbjshd.fsf@skypiea.yi.org>
	<20060521185421.a91bf118.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Gang Chen <goncha.ml@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 21 20:23:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fhsaj-0008AT-Ba
	for gcvg-git@gmane.org; Sun, 21 May 2006 20:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWEUSXq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 14:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWEUSXq
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 14:23:46 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:54437 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932414AbWEUSXq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 May 2006 14:23:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060521182345.HCVK27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 21 May 2006 14:23:45 -0400
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060521185421.a91bf118.tihirvon@gmail.com> (Timo Hirvonen's
	message of "Sun, 21 May 2006 18:54:21 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20457>

Timo Hirvonen <tihirvon@gmail.com> writes:

> Gang Chen <goncha.ml@gmail.com> wrote:
>
>> When CDPATH is set in Bash, `cd' writes new working directory to
>> stdout, which corrupts output of `tar cf - .'.
>
> Fix bash instead, or just don't export CDPATH.  It is used by bash only
> so exporting it is unnecessary.

Thanks.

It is not just unnecessary, but "export CDPATH" anywhere in your
rc scripts is actively *WRONG*.

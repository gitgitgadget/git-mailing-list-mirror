From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-pack-redundant: speed and memory usage improvements
Date: Tue, 20 Dec 2005 13:02:50 -0800
Message-ID: <7virtjh479.fsf@assigned-by-dhcp.cox.net>
References: <43A86422.3090909@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 20 22:05:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoodL-0007Qq-HO
	for gcvg-git@gmane.org; Tue, 20 Dec 2005 22:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbVLTVCx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 20 Dec 2005 16:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbVLTVCx
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Dec 2005 16:02:53 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:31638 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932110AbVLTVCw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Dec 2005 16:02:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051220210122.IXXN17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 20 Dec 2005 16:01:22 -0500
To: Lukas =?iso-8859-1?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>
In-Reply-To: <43A86422.3090909@etek.chalmers.se> (Lukas =?iso-8859-1?Q?San?=
 =?iso-8859-1?Q?dstr=F6m's?= message
	of "Tue, 20 Dec 2005 21:05:54 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13854>

Lukas Sandstr=F6m <lukass@etek.chalmers.se> writes:

> This might be post-1.0 material, but I have tested it on a couple of
> different repositories and it appears to work as before, only faster
> and using less memory.

Thanks.

I had an impression that somehow we already had this slabbish
allocation but apparently we didn't.

Any particular area you have worries/uncertainty about, that
makes you mark this post-1.0?

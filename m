From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsimport - streamline temp index file creation and avoid creating empty tmpfiles
Date: Fri, 23 Jun 2006 23:59:28 -0700
Message-ID: <7vk67711kf.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0606231811200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<11511257501323-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Sat Jun 24 08:59:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu27C-0001pD-JB
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 08:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932927AbWFXG7b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 02:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932931AbWFXG7b
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 02:59:31 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:33435 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932927AbWFXG73 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 02:59:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060624065929.QWHI11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Jun 2006 02:59:29 -0400
To: Martin Langhoff <martin@catalyst.net.nz>
In-Reply-To: <11511257501323-git-send-email-martin@catalyst.net.nz> (Martin
	Langhoff's message of "Sat, 24 Jun 2006 17:09:10 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22488>

Martin Langhoff <martin@catalyst.net.nz> writes:

> On 6/24/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> It seems that git-cvsimport makes a temporary file of size 0, which cannot
>> get mmap()ed, because it has size 0.
>
> This switch to tmpnam() avoids creating the tmpfile in the first place and
> streamlines the code. This handling of tmpfiles is slightly safer, but there
> is an inherent race condition.
>
> ---
> NOTE: (a) I cannot reproduce the problem and (b) this is only lightly tested,
> if trivial.

Thanks both.

I'd take this to "next" after I hear from somebody, most likely
Johannes, who had trouble with the code earlier that the problem
is fixed.

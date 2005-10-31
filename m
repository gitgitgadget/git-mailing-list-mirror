From: Junio C Hamano <junkio@cox.net>
Subject: Re: Another problem with not existing directories
Date: Mon, 31 Oct 2005 10:43:07 -0800
Message-ID: <7vk6ftil38.fsf@assigned-by-dhcp.cox.net>
References: <1130779234.5848.15.camel@blade>
	<Pine.LNX.4.64.0510310929361.27915@g5.osdl.org>
	<1130780772.5848.32.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 19:44:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWecr-0006NI-8M
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 19:43:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbVJaSnM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 13:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbVJaSnM
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 13:43:12 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:11512 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932436AbVJaSnM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 13:43:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051031184249.CMSB4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 31 Oct 2005 13:42:49 -0500
To: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1130780772.5848.32.camel@blade> (Marcel Holtmann's message of
	"Mon, 31 Oct 2005 18:46:12 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10871>

Marcel Holtmann <marcel@holtmann.org> writes:

>> Are you sure you just don't have an old version of git on the other end?
>
> this might be possible, but then it is an old git on kernel.org. I never
> installed any git by myself on it.

I just tried this myself; master.kernel.org seems to have
0.99.8f in /usr/bin/, which explains this symptom.

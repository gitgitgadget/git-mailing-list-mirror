From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] git --help COMMAND brings up the git-COMMAND man-page., take two
Date: Tue, 15 Nov 2005 23:29:52 -0800
Message-ID: <7vbr0law3z.fsf@assigned-by-dhcp.cox.net>
References: <20051116002318.A46C55BF97@nox.op5.se>
	<437AAB48.7090904@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 08:31:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcHkD-00087p-TR
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 08:30:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbVKPH3z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 02:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbVKPH3y
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 02:29:54 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:32448 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030202AbVKPH3y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 02:29:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051116072843.CDRJ17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Nov 2005 02:28:43 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <437AAB48.7090904@zytor.com> (H. Peter Anvin's message of "Tue,
	15 Nov 2005 19:45:12 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12009>

"H. Peter Anvin" <hpa@zytor.com> writes:

> The way this made it into the actual tree was to call /usr/bin/man, but 
> still using execlp().  This is clearly bogus.  There *ARE* good reasons 
> to use PATH resolutions for this, since man is one of the interactive 
> commands the user may want to wrapper.

Oh, that was my call, so please do not blame Andreas.
I just sent out a proposed patch to address all the points
discussed on the list for the last several hours.

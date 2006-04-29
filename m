From: Junio C Hamano <junkio@cox.net>
Subject: Re: Do not use zlib 1.1.3 with git packs!
Date: Fri, 28 Apr 2006 23:36:26 -0700
Message-ID: <7vvessanx1.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0604290245510.30565@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0604290341380.22696@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0604282316520.18816@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 29 08:36:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZj4G-0005ky-40
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 08:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWD2Gga (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Apr 2006 02:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWD2Gga
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 02:36:30 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:54447 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751465AbWD2Gg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Apr 2006 02:36:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060429063629.THYP9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 29 Apr 2006 02:36:29 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0604282316520.18816@localhost.localdomain>
	(Nicolas Pitre's message of "Fri, 28 Apr 2006 23:20:29 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19294>

Nicolas Pitre <nico@cam.org> writes:

> On Sat, 29 Apr 2006, Johannes Schindelin wrote:
>
>> I gather that close to the end, adler32() tries to read 15 bytes after the 
>> end of the allocated target buffer.
>> 
>> Am I wrong?
>
> You're not.  My bad.

Thanks both, for catching this while still in "next".

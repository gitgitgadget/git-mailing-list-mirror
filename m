From: Junio C Hamano <junkio@cox.net>
Subject: Re: Usage of isspace and friends
Date: Thu, 13 Oct 2005 08:44:14 -0700
Message-ID: <7vbr1t4e29.fsf@assigned-by-dhcp.cox.net>
References: <118833cc0510111840k715e1190l54ad65f821c77848@mail.gmail.com>
	<7vachd6hdx.fsf@assigned-by-dhcp.cox.net> <434E60AB.8030607@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 17:48:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQ5Gz-0007vH-G5
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 17:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbVJMPoW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 11:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbVJMPoW
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 11:44:22 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:33748 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751214AbVJMPoV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2005 11:44:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051013154355.SOYT11356.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Oct 2005 11:43:55 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <434E60AB.8030607@zytor.com> (H. Peter Anvin's message of "Thu,
	13 Oct 2005 06:27:07 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10076>

"H. Peter Anvin" <hpa@zytor.com> writes:

> The problem is that isspace() is defined to operate on an integer which 
> can be an unsigned char value promoted to int or EOF (-1).

Ah, thanks.

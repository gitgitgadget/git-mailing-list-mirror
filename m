From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC/PATCH] date parsing: be friendlier to our European
	friends.
Date: Fri, 14 Jul 2006 11:26:07 +0100
Message-ID: <1152872768.3191.58.camel@pmac.infradead.org>
References: <7vodzg4l5n.fsf@assigned-by-dhcp.cox.net>
	 <20060404231606.219a4cc5.akpm@osdl.org>
	 <7virpo4jxf.fsf@assigned-by-dhcp.cox.net>
	 <7vlkujzly0.fsf_-_@assigned-by-dhcp.cox.net>
	 <7vhd57zl9x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 12:26:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1KsP-00031J-Dz
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 12:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161027AbWGNK00 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 06:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161028AbWGNK00
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 06:26:26 -0400
Received: from canuck.infradead.org ([205.233.218.70]:57240 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1161027AbWGNK0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jul 2006 06:26:25 -0400
Received: from pmac.infradead.org ([81.187.2.168])
	by canuck.infradead.org with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1G1KsJ-0007tb-Ai; Fri, 14 Jul 2006 06:26:23 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd57zl9x.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23886>

On Wed, 2006-04-05 at 15:54 -0700, Junio C Hamano wrote:
> Before the list gets useless comments, the code prefer to accept
> more sensible and/or unambiguous forms, such as ISO or RFC2822.
> The issue this addresses is what to do when we get other forms.

Rejecting them and demanding unambiguous forms is better than silently
getting it wrong.

-- 
dwmw2

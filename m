From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: git-send-email w/ headers
Date: Fri, 06 Oct 2006 17:52:10 +0100
Message-ID: <1160153530.4795.51.camel@pmac.infradead.org>
References: <200610041250.50272.len.brown@intel.com>
	 <7viriy9w1q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Len Brown <lenb@kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 18:52:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVswA-0005sw-7N
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 18:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422715AbWJFQwf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 12:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422716AbWJFQwf
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 12:52:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62387 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422715AbWJFQwe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 12:52:34 -0400
Received: from pmac.infradead.org ([81.187.2.168])
	by pentafluge.infradead.org with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1GVsvj-0006wO-EI; Fri, 06 Oct 2006 17:52:11 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7viriy9w1q.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6.dwmw2.2) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28418>

On Thu, 2006-10-05 at 16:34 -0700, Junio C Hamano wrote:
> Len Brown <len.brown@intel.com> writes:
> 
> > git-send-email seems to strip out my custom headers.
> 
> It seems to not care about anything but a selected few.
> 
> Could you give this a try, please? 

It also needs to preserve (and indeed to provide by default)
Content-Type headers to specify the character set.

-- 
dwmw2

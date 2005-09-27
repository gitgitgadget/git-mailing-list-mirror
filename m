From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [PATCH 2/3] Support for partial HTTP transfers
Date: Tue, 27 Sep 2005 10:19:12 -0700
Message-ID: <20050927171912.GC1377@reactrix.com>
References: <20050926175204.GC9410@reactrix.com> <7vd5mvedcs.fsf@assigned-by-dhcp.cox.net> <20050927000931.GA15615@reactrix.com> <7vfyrr3vwp.fsf@assigned-by-dhcp.cox.net> <20050927153636.GA1377@reactrix.com> <7v1x3a309u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 19:22:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKJ70-0002Eu-Ow
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 19:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbVI0RTX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 13:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbVI0RTX
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 13:19:23 -0400
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:31220 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S965016AbVI0RTW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 13:19:22 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j8RHJCRJ004526;
	Tue, 27 Sep 2005 10:19:12 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j8RHJC5A004524;
	Tue, 27 Sep 2005 10:19:12 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1x3a309u.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9408>

On Tue, Sep 27, 2005 at 10:09:49AM -0700, Junio C Hamano wrote:

> True.  What I meant by "interesting" is that two is reading from
> what one is writing.

Excellent point.  Given the potential for problems related to this
issue or to compressed representation, would it make sense to enable
partial transfers via a command-line option and leave the feature
disabled by default?

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.

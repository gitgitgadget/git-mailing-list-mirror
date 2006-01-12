From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [RFD] what should "git push remote.host:path" do?
Date: Thu, 12 Jan 2006 08:31:57 -0800
Message-ID: <20060112163157.GB3873@reactrix.com>
References: <7vslrtq05h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 17:32:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ex5My-00061B-0Y
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 17:32:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030464AbWALQcI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 11:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030461AbWALQcH
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 11:32:07 -0500
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:49105 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1030464AbWALQcF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 11:32:05 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k0CGVvci007562;
	Thu, 12 Jan 2006 08:31:57 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k0CGVvPe007560;
	Thu, 12 Jan 2006 08:31:57 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vslrtq05h.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14569>

On Thu, Jan 12, 2006 at 01:13:30AM -0800, Junio C Hamano wrote:

> BTW, Nick, what does http-push do with "git push http://foo"
> without refspecs?

It won't push anything unless refspecs are specified.  If there are
none, it will still verify remote DAV locking is available and then
exit quietly.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.

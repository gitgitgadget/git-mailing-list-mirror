From: Tim O'Callaghan <timo@dspsrv.com>
Subject: Re: Cygwin test failure in t6021-merge-criss-cross.sh
Date: Tue, 6 Dec 2005 18:10:38 +0100
Message-ID: <20051206171037.GH2364@ELSAMSW37164>
References: <20051206124032.GC2364@ELSAMSW37164> <7v1x0q419j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Dec 06 18:17:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjgKw-0007kg-Sm
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 18:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbVLFRKk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 12:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbVLFRKk
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 12:10:40 -0500
Received: from ns.dspsrv.com ([193.120.211.34]:41910 "EHLO dspsrv.com")
	by vger.kernel.org with ESMTP id S932377AbVLFRKj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2005 12:10:39 -0500
Received: from [145.36.48.101] (helo=localhost)
	by dspsrv.com with asmtp (Exim 3.36 #1)
	id 1EjgKs-0005ul-00
	for git@vger.kernel.org; Tue, 06 Dec 2005 17:10:38 +0000
To: git@vger.kernel.org
Mail-Followup-To: Tim O'Callaghan <timo@dspsrv.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v1x0q419j.fsf@assigned-by-dhcp.cox.net>
User-Agent: mutt-ng/devel-r655 (CYGWIN_NT-5.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13281>

On Tue, Dec 06, 2005 at 08:51:36AM -0800, Junio C Hamano wrote:
> I have this strange feeling that you do not have "merge"
> installed on your cygwin box.  It is part of "rcs".
> 

Thanks, that was it. Another dependency to add to git-core :)

> When you see a test failure, it sometimes useful to try running:
> 
>     $ cd t
>     $ sh ./t6021-*.sh -i -v
> 
> manually.
> 

Duly noted.

Tim.
"I've worked myself up from nothing to a state of supreme poverty."
-- Groucho Marx

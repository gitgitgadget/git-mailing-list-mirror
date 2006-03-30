From: Christopher Faylor <me@cgf.cx>
Subject: Re: [PATCH] gitk: Use git wrapper to run git-ls-remote.
Date: Thu, 30 Mar 2006 15:13:43 -0500
Message-ID: <20060330201343.GH28682@trixie.casa.cgf.cx>
References: <20060330123151.25779.73775.stgit@metalzone.distorted.org.uk> <7v8xqr3iwt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Mar 30 22:13:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FP3Wi-0008GZ-5A
	for gcvg-git@gmane.org; Thu, 30 Mar 2006 22:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWC3UNq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Mar 2006 15:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWC3UNq
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Mar 2006 15:13:46 -0500
Received: from pool-71-248-179-247.bstnma.fios.verizon.net ([71.248.179.247]:58496
	"EHLO cgf.cx") by vger.kernel.org with ESMTP id S1750790AbWC3UNq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Mar 2006 15:13:46 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id 9B71A13C08F; Thu, 30 Mar 2006 15:13:43 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>,
	Mark Wooding <mdw@distorted.org.uk>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v8xqr3iwt.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18204>

On Thu, Mar 30, 2006 at 10:08:02AM -0800, Junio C Hamano wrote:
>Mark Wooding <mdw@distorted.org.uk> writes:
>
>> From: Mark Wooding <mdw@distorted.org.uk>
>>
>> For some reason, the Cygwin Tcl's `exec' command has trouble running
>> scripts...
>
>Yup, I've seen this and have a "personal edition" workaround
>exactly like yours.  I haven't bothered to put it in even "pu",
>because I am reluctant to add an workaround to a problem I do
>not understand (and I haven't bothered to try understanding the
>problem which happens only on Windows ;-).
>
>Does anybody know what is going on?

Currently, Cygwin's tcl is a pure windows version which uses
CreateProcess to run stuff.  It doesn't know about scripts and possibly
doesn't even know about cygwin paths.

cgf

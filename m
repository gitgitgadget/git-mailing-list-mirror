From: wa1ter@myrealbox.com
Subject: Re: Real-life kernel debugging scenario
Date: Wed, 9 Nov 2005 09:40:06 -0800
Organization: none
Message-ID: <Pine.LNX.4.64.0511090901370.6744@x2.ybpnyarg>
References: <dkosr7$f4s$1@sea.gmane.org> <Pine.LNX.4.64.0511071721200.3247@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Nov 09 19:12:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZuEb-0006RZ-0P
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 18:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654AbVKIR7l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 12:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932675AbVKIR7l
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 12:59:41 -0500
Received: from main.gmane.org ([80.91.229.2]:64145 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932654AbVKIR7k (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 12:59:40 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EZu6D-0001wc-Tx
	for git@vger.kernel.org; Wed, 09 Nov 2005 18:51:08 +0100
Received: from adsl-69-234-197-18.dsl.irvnca.pacbell.net ([69.234.197.18])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Nov 2005 18:51:05 +0100
Received: from wa1ter by adsl-69-234-197-18.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Nov 2005 18:51:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-197-18.dsl.irvnca.pacbell.net
In-Reply-To: <Pine.LNX.4.64.0511071721200.3247@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11405>



On Mon, 7 Nov 2005, Linus Torvalds wrote:

[...]
> The way to use "git bisect" couldn't be easier.

I see that Junio just added your entire response to Documentation/howto/
isolate-bugs-with-bisect.txt where even I could manage to find it :o)

> Also, figure out the most recent known-good commit (usually the _previous_
> kernel you ran: and if you've only done a single "pull" in between, it
> will be ORIG_HEAD).

The built-in variable ORIG_HEAD isn't explained anywhere AFAICT, or at
least it wasn't until today.  Are there other such magic variables which
might be useful for us to know about?

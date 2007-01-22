From: Bill Lear <rael@zopyra.com>
Subject: Re: Meaning of "fatal: protocol error: bad line length character"?
Date: Mon, 22 Jan 2007 13:55:25 -0600
Message-ID: <17845.5805.290668.552757@lisa.zopyra.com>
References: <17842.1385.366750.915767@lisa.zopyra.com>
	<7vk5zh7b7d.fsf@assigned-by-dhcp.cox.net>
	<7vfya57ast.fsf@assigned-by-dhcp.cox.net>
	<17842.29542.229557.460473@lisa.zopyra.com>
	<7vbqkt78n7.fsf@assigned-by-dhcp.cox.net>
	<7v7ivh77md.fsf@assigned-by-dhcp.cox.net>
	<17845.2402.105688.56648@lisa.zopyra.com>
	<7vy7nusv52.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 20:56:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H95GT-0001hw-Vq
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 20:55:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbXAVTzf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 14:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbXAVTze
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 14:55:34 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61552 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963AbXAVTze (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 14:55:34 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0MJtVM26534;
	Mon, 22 Jan 2007 13:55:31 -0600
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7nusv52.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37442>

On Monday, January 22, 2007 at 11:45:29 (-0800) Junio C Hamano writes:
>Bill Lear <rael@zopyra.com> writes:
>
>> He has an active update hook in his public repo, to send notices to
>> his collaborators when his work is ready for them to pull, but we
>> looked through it and don't see any printing to stdout.
>
>Just a hunch.
>
>Does the bash start-up sequence for the user emit something to
>stdout?

Not that I can see.  I logged into his machine, su root, su - <his id>,
and nothing but a prompt came up.

>The attached patch on the local side (i.e. the one that pushes)
>dumps "garbage" you are getting on the line from the remote
>side, to help diagnosing the problem. ...

I have asked the developer to install this and hopefully we'll
get some feedback soon.

Thank you.


Bill

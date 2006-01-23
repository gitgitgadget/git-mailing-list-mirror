From: Junio C Hamano <junkio@cox.net>
Subject: Re: Notes on Subproject Support
Date: Mon, 23 Jan 2006 11:30:02 -0800
Message-ID: <7vk6cqyc79.fsf@assigned-by-dhcp.cox.net>
References: <7v3bjfafql.fsf@assigned-by-dhcp.cox.net>
	<20060123125013.GA4472@igloo.ds.co.ug>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 23 20:31:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F17OP-0001MU-F8
	for gcvg-git@gmane.org; Mon, 23 Jan 2006 20:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWAWTaK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jan 2006 14:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbWAWTaJ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jan 2006 14:30:09 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:34191 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964911AbWAWTaH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2006 14:30:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060123192720.WVNS17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 23 Jan 2006 14:27:20 -0500
To: Martin Atukunda <matlads@dsmagic.com>
In-Reply-To: <20060123125013.GA4472@igloo.ds.co.ug> (Martin Atukunda's message
	of "Mon, 23 Jan 2006 15:50:13 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15088>

Martin Atukunda <matlads@dsmagic.com> writes:

> This proposal doesn't seem to cator for the event when a directory is
> renamed or moved to a different location, or am I missing something?

First of all, please do not top post.

Second of all, please do not quote the whole thing.

Third of all, if you quote, please read the parts you quote.

>> Merging
>> -------
>> ...
>> Such renaming can be handled by first moving the bind points in
>> our branch, and redoing the merge (this is a rare operation
>> anyway).  It might go like this:
>> ...

This step describes how bind-point might be relocated prior to a
merge.

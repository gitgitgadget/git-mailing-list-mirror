From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] replace reference to git-rm with git-reset in git-commit doc
Date: Sun, 11 Nov 2007 18:27:57 -0800
Message-ID: <7vsl3c8afm.fsf@gitster.siamese.dyndns.org>
References: <20071102021711.GA28703@fawkes.hq.digizenstudio.com>
	<20071111140518.GA3847@efreet.light.src>
	<20071112003845.GA7595@fawkes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Jing Xue <jingxue@digizenstudio.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 03:29:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrP2m-0005k8-MJ
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 03:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308AbXKLC2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 21:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754253AbXKLC2G
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 21:28:06 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:57419 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023AbXKLC2C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 21:28:02 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id A0D882F9;
	Sun, 11 Nov 2007 21:28:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 2A3B7948E5;
	Sun, 11 Nov 2007 21:28:21 -0500 (EST)
In-Reply-To: <20071112003845.GA7595@fawkes> (Jing Xue's message of "Sun, 11
	Nov 2007 19:38:45 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64552>

Jing Xue <jingxue@digizenstudio.com> writes:

> On Sun, Nov 11, 2007 at 03:05:18PM +0100, Jan Hudec wrote:
>> 
>> The message in git-commit suggesting to use 'git rm --cached' to unstage is
>> just plain wrong. It really should mention 'git reset'.
>
> Hopefully this makes it clearer. I have also updated the faq in wiki to
> clarify.
>
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index e54fb12..7c63dd8 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -154,12 +154,12 @@ EXAMPLES
>  --------
>  When recording your own work, the contents of modified files in
>  your working tree are temporarily stored to a staging area
> +called the "index" with gitlink:git-add[1].  File changes
> +previously staged can be removed with `git-reset
> +HEAD -- <file>`.

I think "changes ... can be removed" risks to give a confused
mental model that somehow git tracks changes.  "A file can be
reverted back to that of the last commit with ..."  would be
less risky.

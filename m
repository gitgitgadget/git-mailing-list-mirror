From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Deprecate git-fetch-pack?
Date: Sun, 11 Nov 2007 13:16:09 -0800
Message-ID: <7vd4ugcwkm.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711101752490.29952@iabervon.org>
	<7v4pftip42.fsf@gitster.siamese.dyndns.org>
	<74415967-7F49-426C-8BF5-1A0210C337AB@develooper.com>
	<Pine.LNX.4.64.0711111103240.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ask =?utf-8?Q?Bj=C3=B8rn?= Hansen <ask@develooper.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 11 22:16:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrKAS-0001Eu-Kt
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 22:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279AbXKKVQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 16:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752748AbXKKVQR
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 16:16:17 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:60721 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961AbXKKVQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 16:16:16 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 6A9B42F0;
	Sun, 11 Nov 2007 16:16:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E09E294753;
	Sun, 11 Nov 2007 16:16:32 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711111103240.4362@racer.site> (Johannes
	Schindelin's message of "Sun, 11 Nov 2007 11:05:34 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64514>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Sat, 10 Nov 2007, Ask Bj?rn Hansen wrote:
>
>> For new users the superfluous programs are a burden making it harder to 
>> learn how everything works.
>
> This should be a non-issue.  We really should start deprecating 
> "git-<command>" in favour of "git <command>" for real.
>
> New users should not even be told that this is correct usage.
>
> My reason?  We have plumbing, and we will always have plumbing, as 
> commands.  A regular git user does not _want_ to see that.  Without said 
> deprecation she _will_, however.

If you can write "git-commit" and "git commit" interchangeably
while you cannot say "git-cat-file" and are forced to say "git
cat-file", I suspect that would lead to a great confusion and
unhappy users.

I wonder if making the distinction between plumbing and
porcelain in the git(7) page even more cleaner would help.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/11] Support bundles in builtin-clone
Date: Sun, 09 Mar 2008 23:32:38 -0700
Message-ID: <7vtzjfks1l.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0803081804280.19665@iabervon.org>
 <alpine.LSU.1.00.0803090027570.3975@racer.site>
 <alpine.LNX.1.00.0803091447230.19665@iabervon.org>
 <alpine.LSU.1.00.0803092155450.3975@racer.site>
 <7v7igbm8cb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 10 07:33:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYbZh-0004Yr-5D
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 07:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbYCJGcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 02:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752728AbYCJGcu
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 02:32:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43445 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbYCJGcu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 02:32:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AEA7D1299;
	Mon, 10 Mar 2008 02:32:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0D0E31298; Mon, 10 Mar 2008 02:32:42 -0400 (EDT)
In-Reply-To: <7v7igbm8cb.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 09 Mar 2008 22:55:16 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76700>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Of course, I am okay with it, but I consider the From: issue a real bug in 
>> send-email (or format-patch, if you want).
>
> Format-patch is about recording the author of the patch on From: line
> (think of it a tool to reproduce an e-mail that you would have received
> and applied to your tree).  It may probably make a lot of sense to teach
> send-email not to forge From: (even though, RFC is Ok with it, as long as
> it also correctly adds Sender: pointing at the real sender).

Well, as I re-read send-email, it does put you on the From: and adds the
patch author From: at the beginning of the message.  So there is no bug
here.  Daniel did not use send-email, so of course even if there were a
bug in send-email it would not have triggered ;-)

So there is no bug to hunt here.

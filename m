From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push failing, unpacker error
Date: Fri, 09 Nov 2007 09:51:15 -0800
Message-ID: <7vtznvtii4.fsf@gitster.siamese.dyndns.org>
References: <9e4733910711082155t62df9d4by10bd3f546ffbd950@mail.gmail.com>
	<9e4733910711090637tcf7e837na863a4276578bf3f@mail.gmail.com>
	<9e4733910711090643t493b0e6fl2a18390a2f9ab842@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 18:51:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqY14-0008M1-1V
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 18:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbXKIRvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 12:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbXKIRvV
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 12:51:21 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:34272 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbXKIRvU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 12:51:20 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id A7C402FC;
	Fri,  9 Nov 2007 12:51:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 4561790EC7;
	Fri,  9 Nov 2007 12:51:39 -0500 (EST)
In-Reply-To: <9e4733910711090643t493b0e6fl2a18390a2f9ab842@mail.gmail.com>
	(Jon Smirl's message of "Fri, 9 Nov 2007 09:43:49 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64232>

"Jon Smirl" <jonsmirl@gmail.com> writes:

> On 11/9/07, Jon Smirl <jonsmirl@gmail.com> wrote:
>> I updated both sides to current git and it still fails. How do I debug this?
>> What's causing this, "error: pack-objects died with strange error"?
>
> My remote host is running 2.4.32, is git ok on that kernel?

No problem that I am aware of.  We are not *that* intimate with
the kernel.

Do "git-fsck --full" on both repositories pass?

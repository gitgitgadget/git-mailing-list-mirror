From: Junio C Hamano <gitster@pobox.com>
Subject: Re: The msysGit Herald, issue 2
Date: Mon, 24 Sep 2007 09:49:03 -0700
Message-ID: <7v1wcoau0w.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0709232153230.28395@racer.site>
	<alpine.LFD.0.999.0709240840310.3579@woody.linux-foundation.org>
	<46F7E2A5.6030202@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Sixt <j.sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 18:51:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZr9s-0006pj-V7
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 18:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764063AbXIXQtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 12:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761104AbXIXQtM
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 12:49:12 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:52829 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763732AbXIXQtL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 12:49:11 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 8357113B1FD;
	Mon, 24 Sep 2007 12:49:26 -0400 (EDT)
In-Reply-To: <46F7E2A5.6030202@eudaptics.com> (Johannes Sixt's message of
	"Mon, 24 Sep 2007 18:15:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59062>

Johannes Sixt <j.sixt@eudaptics.com> writes:

> Linus Torvalds schrieb:
>
>> ...
>> Or maybe you did fetch a tracking branch?
>
> I don't think I fetched a tracking branch. If I do:
>
>    $ mkdir foo && cd foo && git init
>    $ git fetch ../git master:refs/heads/master
>
> (where ../git is a clone of git.git with a few local changes), I get
> all the tags. Good or bad?

That's exactly Linus meant "fetching a tracking branch".  Your
refspec has non-empty string on the RHS of the colon.

	$ git fetch ../git master

is the form without tracking.  IOW, not storing into your refs
namespace.

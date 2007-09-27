From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Mergetool generating blank files (1.5.3)
Date: Thu, 27 Sep 2007 13:28:52 -0700
Message-ID: <7vd4w3ua2j.fsf@gitster.siamese.dyndns.org>
References: <94ccbe710709271131o620bf1far8893328ce98f0ba4@mail.gmail.com>
	<20070927185707.GC12427@artemis.corp>
	<94ccbe710709271224rc65b6f4k8b68419629ed5b45@mail.gmail.com>
	<7vhclfubh5.fsf@gitster.siamese.dyndns.org>
	<94ccbe710709271312k7eac8e35y353180596a0abc9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Kelvie Wong" <kelvie@ieee.org>
X-From: git-owner@vger.kernel.org Thu Sep 27 22:30:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib00N-0007rx-AE
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 22:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754104AbXI0Uac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 16:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754014AbXI0Uab
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 16:30:31 -0400
Received: from rune.pobox.com ([208.210.124.79]:57535 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753873AbXI0Uab (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 16:30:31 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 6C95D13D398;
	Thu, 27 Sep 2007 16:30:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 0AD9513A835;
	Thu, 27 Sep 2007 16:29:16 -0400 (EDT)
In-Reply-To: <94ccbe710709271312k7eac8e35y353180596a0abc9a@mail.gmail.com>
	(Kelvie Wong's message of "Thu, 27 Sep 2007 13:12:03 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59328>

"Kelvie Wong" <kelvie@ieee.org> writes:

> And then meld starts up, with the original file in the middle, and two
> blank files on the side, LOCAL and REMOTE respectively.

Wild guess.  Are you running this from a subdirectory?  I have a
mild suspicion that mergetool is not subdirectory safe.  Can you
try running it from the toplevel of the work tree?

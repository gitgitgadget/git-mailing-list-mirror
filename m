From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Mergetool generating blank files (1.5.3)
Date: Thu, 27 Sep 2007 12:58:30 -0700
Message-ID: <7vhclfubh5.fsf@gitster.siamese.dyndns.org>
References: <94ccbe710709271131o620bf1far8893328ce98f0ba4@mail.gmail.com>
	<20070927185707.GC12427@artemis.corp>
	<94ccbe710709271224rc65b6f4k8b68419629ed5b45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Pierre Habouzit" <madcoder@debian.org>, git@vger.kernel.org
To: "Kelvie Wong" <kelvie@ieee.org>
X-From: git-owner@vger.kernel.org Thu Sep 27 21:58:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IazVV-0003fN-Jb
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 21:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753347AbXI0T6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 15:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753339AbXI0T6i
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 15:58:38 -0400
Received: from rune.pobox.com ([208.210.124.79]:56124 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753221AbXI0T6i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 15:58:38 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 93A1B13D34E;
	Thu, 27 Sep 2007 15:58:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id AACFD13D328;
	Thu, 27 Sep 2007 15:58:54 -0400 (EDT)
In-Reply-To: <94ccbe710709271224rc65b6f4k8b68419629ed5b45@mail.gmail.com>
	(Kelvie Wong's message of "Thu, 27 Sep 2007 12:24:38 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59326>

"Kelvie Wong" <kelvie@ieee.org> writes:

> I've tried all of the ones that were supported, the result is the same
> -- blank files in all three windows.
>
> It is because git mergetool fails to generate these files for whatever
> reason (the filebasename.{REMOTE,LOCAL,BASE}.* files).  I don't know
> why this happens.

Can you run git-mergetool under "sh -x"?

That is,

	$ sh -x git-mergetool

around ll.160-170 these files are created.

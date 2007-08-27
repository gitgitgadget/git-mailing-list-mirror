From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] builtin-push: New long option --verbose
Date: Mon, 27 Aug 2007 16:32:47 +0300
Organization: Private
Message-ID: <lkbxdrwg.fsf@cante.net>
References: <y7fxeal4.fsf@cante.net>
	<7vtzqll7hf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 15:35:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPekG-0005ld-Td
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 15:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbXH0NfF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 09:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754245AbXH0NfF
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 09:35:05 -0400
Received: from main.gmane.org ([80.91.229.2]:44649 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752278AbXH0NfD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 09:35:03 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IPekA-00081f-3n
	for git@vger.kernel.org; Mon, 27 Aug 2007 15:35:02 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 15:35:02 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 15:35:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:uO7vhc42YWqOLpWbMZGnNkUaUic=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56834>

Junio C Hamano <gitster@pobox.com> writes:

> Why?

It complements the command set. -v was the only lonely that did not
have long option choice.

Overall, the option handling in every command could use aboot to
provide both short and long options. Now various commands have short
ones, but no long ones, or vice versa. It's like sherwood there.

Let's start unifying.
Jari

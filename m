From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone questions relating to cpio
Date: Mon, 01 Oct 2007 23:23:38 -0700
Message-ID: <7vy7emm3v9.fsf@gitster.siamese.dyndns.org>
References: <3f4fd2640710011228w61ce34b5ve47ea529eed384fd@mail.gmail.com>
	<Pine.LNX.4.64.0710020022470.28395@racer.site>
	<7vwsu6pg0v.fsf@gitster.siamese.dyndns.org>
	<4701E10C.7050405@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Reece Dunn <msclrhd@googlemail.com>, Git <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 02 08:23:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcbAi-0003tm-3T
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 08:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbXJBGXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 02:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbXJBGXr
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 02:23:47 -0400
Received: from rune.pobox.com ([208.210.124.79]:39356 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164AbXJBGXr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 02:23:47 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 7E50613EECD;
	Tue,  2 Oct 2007 02:24:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C5F5D13FD7E;
	Tue,  2 Oct 2007 02:24:03 -0400 (EDT)
In-Reply-To: <4701E10C.7050405@viscovery.net> (Johannes Sixt's message of
	"Tue, 02 Oct 2007 08:11:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59664>

Johannes Sixt <j.sixt@viscovery.net> writes:

> FWIW, I'm thinking about changing the cpio -p (passthrough) part to use
> 'cp -l --parents --target-directory=...' instead of tar; this gives us
> hard links, even on NTFS. But it needs GNU's cp, of course.

Yeah, that's the reason it is not appropriate than cpio, even if
we forget about Windows.

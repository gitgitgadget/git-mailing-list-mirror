From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Move stripspace() and launch_editor() to strbuf.c
Date: Sun, 11 Nov 2007 14:52:26 -0800
Message-ID: <7v6408bdjp.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711111728380.4362@racer.site>
	<7vtznsbgcc.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711112227420.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 11 23:52:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrLfd-0001Ik-MX
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 23:52:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757505AbXKKWwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 17:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757476AbXKKWwe
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 17:52:34 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:44455 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757426AbXKKWwd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 17:52:33 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 4739A2F2;
	Sun, 11 Nov 2007 17:52:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id DEA8F947A0;
	Sun, 11 Nov 2007 17:52:49 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711112227420.4362@racer.site> (Johannes
	Schindelin's message of "Sun, 11 Nov 2007 22:29:34 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64535>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Maybe call_editor() instead of edit_buffer()?  Since we technically read 
> the file specified by "path" into the buffer "buffer", after having called 
> the editor.

Calling $EDITOR to edit the buffer is an implementation detail
of letting the user edit the buffer.  I think the function name
should express what it does more than how it does it.

My suggested name does not convey the "letting the user" part,
though.

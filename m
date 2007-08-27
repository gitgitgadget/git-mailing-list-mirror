From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git and OpenDocument (OpenOffice.org) files
Date: Mon, 27 Aug 2007 03:08:54 -0700
Message-ID: <7vps19jnm1.fsf@gitster.siamese.dyndns.org>
References: <vpqk5rh5mp5.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Aug 27 12:09:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPbWn-00007z-IU
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 12:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbXH0KI6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 06:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbXH0KI6
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 06:08:58 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:37098 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbXH0KI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 06:08:58 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 382A5129306;
	Mon, 27 Aug 2007 06:09:18 -0400 (EDT)
In-Reply-To: <vpqk5rh5mp5.fsf@bauges.imag.fr> (Matthieu Moy's message of "Mon,
	27 Aug 2007 11:52:22 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56805>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Remarks are welcome (I'll post some remarks about Git's custom diff
> driver in a separate thread).

Good.

I think creation/deletion will get /dev/null as the temporary
file name, so as long as odt2txt knows how to deal with
/dev/null you would not have to worry much about them.

You might want to be careful about unmerged paths, though.  They
will not get anything other than $1 (name).

You would probably not care about the mode changes for oo
documents, but they are available as $4 and $6 respectively, if
you care.

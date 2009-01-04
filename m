From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cvsserver: add option to configure commit message
Date: Sun, 04 Jan 2009 02:01:27 -0800
Message-ID: <7viqovz8y0.fsf@gitster.siamese.dyndns.org>
References: <1230910814-32307-1-git-send-email-fabian.emmes@rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Lars Noschinski <lars@public.noschinski.de>
To: Fabian Emmes <fabian.emmes@rwth-aachen.de>
X-From: git-owner@vger.kernel.org Sun Jan 04 11:03:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJPp9-0001V7-T2
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 11:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbZADKBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 05:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbZADKBg
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 05:01:36 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35785 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbZADKBf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 05:01:35 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 001288DDDA;
	Sun,  4 Jan 2009 05:01:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E074C8DDD8; Sun,
  4 Jan 2009 05:01:28 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AAD8D0C4-DA46-11DD-A99E-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104502>

Fabian Emmes <fabian.emmes@rwth-aachen.de> writes:

> cvsserver annotates each commit message by "via git-CVS emulator". This is
> made configurable via gitcvs.commitmsgannotation.
>
> Signed-off-by: Fabian Emmes <fabian.emmes@rwth-aachen.de>
> Signed-off-by: Lars Noschinski <lars@public.noschinski.de>

I do not see the development history behind this and am somewhat puzzled
by these two S-o-b lines.  Is it "Fabian developed it, showed it to Lars
who cleaned it up and/or enhanced it and here is the result"?  Or is it
"Lars developed it, circulated it in his closer circle, Fabian found it
useful and worthy for inclusion and sending it to the mailing list"?

Whichever it is, I just will take it as "This is co-developed and between
the authors Fabian is the primary author" and apply.

Thanks.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: --replace-all with one argument exits properly
 with a better message.
Date: Sat, 14 Mar 2009 13:53:46 -0700
Message-ID: <7vtz5vakrp.fsf@gitster.siamese.dyndns.org>
References: <1236998552.9952.2.camel@luis-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 21:55:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Liat9-0001e1-Ry
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 21:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661AbZCNUxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2009 16:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752718AbZCNUxz
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 16:53:55 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63338 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbZCNUxy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 16:53:54 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 232AB684C;
	Sat, 14 Mar 2009 16:53:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5E3AE6849; Sat,
 14 Mar 2009 16:53:48 -0400 (EDT)
In-Reply-To: <1236998552.9952.2.camel@luis-desktop> (Carlos Rica's message of
 "Sat, 14 Mar 2009 03:42:32 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3A1913B0-10DA-11DE-A255-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113262>

Carlos Rica <jasampler@gmail.com> writes:

> 'config --replace-all ONE_ARG' was being treated as 'config NAME VALUE',
> showing the error "key does not contain a section: --replace-all".

Hmm, I am getting "error: wrong number of arguments" followed by the long
and somewhat annoying "usage" from the parseopt table dump.

Ahh, that is because I am running the version from 'next', which contains
the fc/parseopt-config topic that rewrites the option parser and error
checking almost completely.

Can you work with Felipe to see if this is still needed, or needs to be
fixed in a different way?  It could be that your tests may already pass
over there on 'next'.  I didn't check.

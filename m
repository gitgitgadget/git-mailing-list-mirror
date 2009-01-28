From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-am: emit usage when called w/o arguments and w/o
 patch on stdin
Date: Tue, 27 Jan 2009 19:01:28 -0800
Message-ID: <7v7i4gyvzr.fsf@gitster.siamese.dyndns.org>
References: <1233110338-16806-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, sverre@rabbelier.nl
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 04:03:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS0hj-0003c2-4F
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 04:03:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbZA1DBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 22:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbZA1DBh
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 22:01:37 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33323 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbZA1DBh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 22:01:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0116B94CE0;
	Tue, 27 Jan 2009 22:01:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3FD1C94CDC; Tue,
 27 Jan 2009 22:01:29 -0500 (EST)
In-Reply-To: <1233110338-16806-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Tue, 27 Jan 2009 21:38:57 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F9950A6C-ECE7-11DD-ABD1-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107456>

Jay Soffian <jaysoffian@gmail.com> writes:

> Also ensure that $dotest is cleaned up if user manages to interupt mailsplit
> while it is processing input.

I do not think this "Also ensure" part is necessary nor desirable.  If
something goes wrong, we'd like to have a way to resurrect some partial
results from the split out result.

The rest looked fine.  Perhaps a re-roll?

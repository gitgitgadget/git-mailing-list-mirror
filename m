From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/11] Fix declare variable at mid of function
Date: Mon, 17 Aug 2009 12:28:09 -0700
Message-ID: <7v1vnauto6.fsf@alter.siamese.dyndns.org>
References: <1250524872-5148-1-git-send-email-lznuaa@gmail.com>
 <1250524872-5148-2-git-send-email-lznuaa@gmail.com>
 <alpine.DEB.1.00.0908171827040.4991@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 21:28:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md7sX-0003JC-PN
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 21:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbZHQT2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 15:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752690AbZHQT2Q
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 15:28:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37035 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbZHQT2P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 15:28:15 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 500D32DD79;
	Mon, 17 Aug 2009 15:28:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A368C2DD78; Mon, 17 Aug 2009
 15:28:11 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0908171827040.4991@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Mon\, 17 Aug 2009 18\:29\:03 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1D543EC6-8B64-11DE-81B7-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126257>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> How about this instead?
>
> 	Avoid declaration after instruction

It's called declaration-after-statement.

I always compile with "-Wall -Wdeclaration-after-statement -Werror" (among
other things; if you are interested, see "Make" script in 'todo' branch
for details) but this being in compat/mingw.c, obviously it is outside of
my coverage.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix a bunch of pointer declarations (codestyle)
Date: Fri, 01 May 2009 15:37:24 -0700
Message-ID: <7vmy9wv49n.fsf@gitster.siamese.dyndns.org>
References: <1241168796-7222-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 02 00:37:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M01MV-0007fq-Ey
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 00:37:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940AbZEAWhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 18:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753586AbZEAWhb
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 18:37:31 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49538 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbZEAWha (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 18:37:30 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 345E913D8A;
	Fri,  1 May 2009 18:37:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 898A113D89; Fri, 
 1 May 2009 18:37:26 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A6FE6002-36A0-11DE-A30C-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118103>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Essentially; s/type* /type */ as per the coding guidelines.

Nice.  The nicest part is that the resulting binary does not change with
or without this patch ;-).

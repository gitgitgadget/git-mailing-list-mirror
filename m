From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pull regression?
Date: Tue, 04 Nov 2008 15:37:03 -0800
Message-ID: <7vtzanoyg0.fsf@gitster.siamese.dyndns.org>
References: <20081104222749.GA9296@localhost.aei.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Carlos R. Mafra" <crmafra2@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 00:38:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxVTj-0001OE-9d
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 00:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353AbYKDXhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 18:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753759AbYKDXhQ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 18:37:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50183 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898AbYKDXhP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 18:37:15 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2522993DA4;
	Tue,  4 Nov 2008 18:37:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3CF9393DA3; Tue, 
 4 Nov 2008 18:37:04 -0500 (EST)
In-Reply-To: <20081104222749.GA9296@localhost.aei.mpg.de> (Carlos R. Mafra's
 message of "Tue, 4 Nov 2008 23:27:49 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 824054D6-AAC9-11DD-8AFB-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100119>

"Carlos R. Mafra" <crmafra2@gmail.com> writes:

> It looks like a regression to me. I can finish
> the bisection if people in the list say that
> I am not making a mistake somewhere :-)

Interesting, and _sounds_ like a regression, but I do not think anybody
can tell if it is without looking at what .git/config and exact command
sequence you are using for this "git pull" and where you are starting
from.

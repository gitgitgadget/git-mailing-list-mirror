From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] I don't known anyone who understands what it means when
 they do a merge and see "file.txt: needs update".  "file.txt: has changes" is
 much clearer.
Date: Sat, 03 May 2008 09:57:49 -0700
Message-ID: <7v3aozwcj6.fsf@gitster.siamese.dyndns.org>
References: <1209798522-13618-1-git-send-email-timcharper@gmail.com>
 <alpine.DEB.1.00.0805031509170.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 03 18:59:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsL4a-0006Vg-QY
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 18:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755564AbYECQ6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 12:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760128AbYECQ6H
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 12:58:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47051 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758711AbYECQ6G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 12:58:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 322A74F85;
	Sat,  3 May 2008 12:58:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9AFD64F82; Sat,  3 May 2008 12:57:57 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0805031509170.30431@racer> (Johannes
 Schindelin's message of "Sat, 3 May 2008 15:09:42 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 17F456F0-1932-11DD-AC05-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81099>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 3 May 2008, Tim Harper wrote:
>
>> -			printf("%s: needs update\n", ce->name);
>> +			printf("%s: has changes\n", ce->name);
>
> How about "local changes"?

Aren't there Porcelain and end-user scripts that relies on the output by
doing "sed -ne s'/: needs update$//p"?

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: testsuite failures in mainline...
Date: Fri, 14 Dec 2007 12:10:26 -0800
Message-ID: <7vir31qbpp.fsf@gitster.siamese.dyndns.org>
References: <20071214.104312.103638776.davem@davemloft.net>
	<7vfxy5rsui.fsf@gitster.siamese.dyndns.org>
	<20071214.111736.258936000.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Fri Dec 14 21:11:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3GsF-0002XA-S3
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 21:11:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbXLNUKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 15:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754189AbXLNUKp
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 15:10:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53954 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754181AbXLNUKo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 15:10:44 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EC1F28EAA;
	Fri, 14 Dec 2007 15:10:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 769BF8EA8;
	Fri, 14 Dec 2007 15:10:35 -0500 (EST)
In-Reply-To: <20071214.111736.258936000.davem@davemloft.net> (David Miller's
	message of "Fri, 14 Dec 2007 11:17:36 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68336>

David Miller <davem@davemloft.net> writes:

> From: Junio C Hamano <gitster@pobox.com>
> Date: Fri, 14 Dec 2007 11:15:01 -0800
>
>> When I can reproduce a breakage, in our tests, I'd run
>> 
>> 	cd t && sh -x t3200-branch.sh -i -v
>> 
>> (replace "t3200-*" with the failing test) and see which one of the steps
>> chained with && is breaking first.
>
> Looks like a malloc() failure:
> ...
> ++ git branch my3 local/master
> fatal: Out of memory, malloc failed

Do you mean this is a malloc() failure that you can reliable reproduce?
Puzzled...

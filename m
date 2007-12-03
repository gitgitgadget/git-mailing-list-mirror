From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-commit --allow-empty
Date: Mon, 03 Dec 2007 10:16:10 -0800
Message-ID: <7vhciziqz9.fsf@gitster.siamese.dyndns.org>
References: <4751A0FB.6090705@gmail.com>
	<7vd4tq41zt.fsf@gitster.siamese.dyndns.org>
	<7v63zgkw0x.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.99999.0712031255560.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Drago <markdrago@gmail.com>, stelian@popies.net,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Dec 03 19:16:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzFqP-00078U-Qy
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 19:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbXLCSQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 13:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbXLCSQR
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 13:16:17 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:34408 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbXLCSQR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 13:16:17 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 6151D2EF;
	Mon,  3 Dec 2007 13:16:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id DCAD09B94E;
	Mon,  3 Dec 2007 13:16:33 -0500 (EST)
In-Reply-To: <alpine.LFD.0.99999.0712031255560.9605@xanadu.home> (Nicolas
	Pitre's message of "Mon, 03 Dec 2007 12:58:29 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66938>

Nicolas Pitre <nico@cam.org> writes:

> On Mon, 3 Dec 2007, Junio C Hamano wrote:
>
>> +--allow-empty::
>> +	Usually recording a commit that has the exact same tree as its
>> +	sole parent commit and the command prevents you from making such
>> +	a mistake.  This option bypasses the safety, and is primarily
>> +	for use by foreign scm interface scripts.
>
> The first sentence is rather buggy I would say.

It indeed is.  Sorry.

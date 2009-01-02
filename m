From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Fri, 02 Jan 2009 03:03:41 -0800
Message-ID: <7vocyqc6lu.fsf@gitster.siamese.dyndns.org>
References: <20081104004001.GB29458@artemis.corp>
 <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de>
 <20081104083042.GB3788@artemis.corp>
 <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de>
 <20081104152351.GA21842@artemis.corp>
 <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain>
 <20090101204652.GA26128@chistera.yi.org>
 <alpine.LFD.2.00.0901011747010.5086@localhost.localdomain>
 <20090102105537.GA14691@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Adeodato =?utf-8?Q?Si?= =?utf-8?Q?m=C3=B3?= 
	<dato@net.com.org.es>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>, davidel@xmailserver.org,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Jan 02 12:06:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIhqC-0000kd-7c
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 12:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756668AbZABLD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 06:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756048AbZABLD6
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 06:03:58 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40164 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbZABLD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 06:03:57 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CA4631B97A;
	Fri,  2 Jan 2009 06:03:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id ECFCB1B977; Fri, 
 2 Jan 2009 06:03:42 -0500 (EST)
In-Reply-To: <20090102105537.GA14691@localhost> (Clemens Buchacher's message
 of "Fri, 2 Jan 2009 11:55:38 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0B21A84C-D8BD-11DD-9D04-EB51113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104373>

Clemens Buchacher <drizzd@aon.at> writes:

> But patience diff does more than that. Take a look at "git diff" and "git
> diff --patience" output below (taken from [1]).
>
> *** git diff ****************************** git diff --patience **********
>  #include <stdio.h>                   | #include <stdio.h>

I suspect you have the above labels backwards...

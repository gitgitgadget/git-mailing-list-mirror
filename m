From: Junio C Hamano <gitster@pobox.com>
Subject: Re: receive.denyCurrentBranch
Date: Sun, 08 Feb 2009 17:38:17 -0800
Message-ID: <7vtz74wfsm.fsf@gitster.siamese.dyndns.org>
References: <20090208042910.19079.qmail@science.horizon.com>
 <alpine.DEB.1.00.0902081128420.10279@pacific.mpi-cbg.de>
 <76718490902080950r798ca02es4e560da35e499046@mail.gmail.com>
 <alpine.DEB.1.00.0902082149380.10279@pacific.mpi-cbg.de>
 <76718490902081451xd953e84y33de64cc82c1da42@mail.gmail.com>
 <alpine.DEB.1.00.0902090038550.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>,
	George Spelvin <linux@horizon.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 09 02:40:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWL8F-0000XQ-3p
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 02:40:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754502AbZBIBic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 20:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754291AbZBIBic
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 20:38:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34947 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753615AbZBIBib (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 20:38:31 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 91F0A2ABAE;
	Sun,  8 Feb 2009 20:38:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 82BE22AB7F; Sun, 
 8 Feb 2009 20:38:21 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0902090038550.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Mon, 9 Feb 2009 00:41:42 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5A669674-F64A-11DD-81D8-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109032>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 8 Feb 2009, Jay Soffian wrote:
>
>> If you had paid attention, you would have noticed that Mercurial did not 
>> attempt to merge. Rather, it created a new branch head in the remote 
>> repository.
>
> So this is the "detached HEAD" idea.  Which contradicts the law of the 
> least surprise.

I do not think so.  It is "adopting the symmetric mothership-satellite
layout, when it suits the user's workflow".

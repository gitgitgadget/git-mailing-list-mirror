From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Provide pessimistic defaults for cross compilation
 tests.
Date: Mon, 19 Jan 2009 18:49:03 -0800
Message-ID: <7vab9mpu8w.fsf@gitster.siamese.dyndns.org>
References: <loom.20090115T123123-915@post.gmane.org>
 <20090116094110.GD25275@ins.uni-bonn.de>
 <20090119203400.GA3539@ins.uni-bonn.de>
 <alpine.DEB.1.00.0901200037510.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Julius Naperkowski <j.nap@gmx.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 03:50:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP6hL-0001MW-Jk
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 03:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbZATCtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 21:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752903AbZATCtO
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 21:49:14 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33371 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835AbZATCtO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 21:49:14 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 55AAB1CD6B;
	Mon, 19 Jan 2009 21:49:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8DF441CD6A; Mon,
 19 Jan 2009 21:49:05 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901200037510.3586@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Tue, 20 Jan 2009 00:39:44 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EB072CA6-E69C-11DD-B88B-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106427>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> How do you deal with the hardcoded limitation that uname_S is defined to 
> be the output of "uname -s" on the _build_ system, and that quite a large 
> part of the Makefile sets variables dependent on this?
>
> IOW are you certain that configure (with your patch) will override _all_ 
> uname_S dependent settings?

It may be a valid question but it is not limited to cross compilation, is
it?  The matter is if values the Makefile wants to default to can be
overriden by whatever is placed in config.mak, and as long as that is Ok
we won't have a problem with or without use of configure (which is a
second class citizen).

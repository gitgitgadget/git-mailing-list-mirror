From: Junio C Hamano <gitster@pobox.com>
Subject: Re: disallowing push to currently checked-out branch
Date: Mon, 16 Feb 2009 17:18:57 -0800
Message-ID: <7v7i3peu7y.fsf@gitster.siamese.dyndns.org>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org>
 <20090215232013.GA11543@zakalwe.fi>
 <20090216000443.GB3503@coredump.intra.peff.net>
 <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm>
 <alpine.DEB.1.10.0902151738450.14911@asgard.lang.hm>
 <alpine.LNX.1.00.0902160322530.19665@iabervon.org>
 <7veixybw7u.fsf@gitster.siamese.dyndns.org>
 <loom.20090216T101457-231@post.gmane.org>
 <20090216135812.GA20377@coredump.intra.peff.net> <49999ED6.7010608@gmail.com>
 <alpine.DEB.1.00.0902161839120.6289@intel-tinevez-2-302>
 <4999BD54.8090805@gmail.com>
 <alpine.DEB.1.00.0902162103580.6289@intel-tinevez-2-302>
 <4999FFCE.3060605@gmail.com>
 <alpine.DEB.1.00.0902170112580.10279@pacific.mpi-cbg.de>
 <499A07C4.5000908@gmail.com>
 <alpine.DEB.1.00.0902170154330.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 17 02:20:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZEdX-0006jT-Hd
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 02:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbZBQBTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 20:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbZBQBTI
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 20:19:08 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48148 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbZBQBTG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 20:19:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2167C989D8;
	Mon, 16 Feb 2009 20:19:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6E85F989CB; Mon,
 16 Feb 2009 20:18:59 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0902170154330.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Tue, 17 Feb 2009 01:56:29 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F7A3168C-FC90-11DD-9710-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110290>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Nope.  There was code flying around at some stage to record in the index 
> what commit it was based on.
>
> I forgot why it was thrown out again; you'll have to look up the 
> discussion yourself.

A good starting point may be:

    http://article.gmane.org/gmane.comp.version-control.git/67089/
    http://thread.gmane.org/gmane.comp.version-control.git/44360/focus=44508

It is frustrating that I cannot seem to find a way to tell gmane to "jump
to approximately this timeperiod", but right now, the thread appears at
around 635th page from the tip.  By the time you read this message you may
have to flip a bit more pages, though ;-)

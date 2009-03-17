From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Local clone checks out wrong branch based on remote HEAD
Date: Tue, 17 Mar 2009 16:40:26 -0700
Message-ID: <7viqm7pvkl.fsf@gitster.siamese.dyndns.org>
References: <b97024a40903171219k8841508p774d9dc4295a09bc@mail.gmail.com>
 <alpine.LNX.1.00.0903171530160.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Preston-Werner <tom@github.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 18 00:42:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljiv8-0008WL-N6
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 00:42:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353AbZCQXkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 19:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbZCQXkf
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 19:40:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbZCQXke (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 19:40:34 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5071EA2608;
	Tue, 17 Mar 2009 19:40:32 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1B884A2605; Tue,
 17 Mar 2009 19:40:27 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0903171530160.19665@iabervon.org> (Daniel
 Barkalow's message of "Tue, 17 Mar 2009 15:39:55 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 014F17A8-134D-11DE-86F3-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113537>

Daniel Barkalow <barkalow@iabervon.org> writes:

> ... I think there's also been discussion of a 
> protocol extension to transmit the information, although I don't know 
> where that ended up.

You can find them in the list of threads posted nearby.

The first round's protocol extension was not quite backward compatible
but in a benign way, in that it did not break anything but induced a
harmless warning from older ls-remote.  The second round did not have such
flaw but it got a "Yuck". 

    From: Jeff King <peff@peff.net>
    Date: Mon, 1 Dec 2008 12:44:15 -0500
    Message-ID: <20081201174414.GA22185@coredump.intra.peff.net>
    Subject: Re: [PATCH 5/6 (v2)] upload-pack: send the HEAD information

I somehow feel that the "Yuck" was addressed not to the patches but to the
problem the patch needs to address.

We could resurrect it if somebody is interested.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-push: push <remote> :<branch> deletes remote branch
Date: Tue, 19 Feb 2008 13:35:19 -0800
Message-ID: <7v4pc4iq94.fsf@gitster.siamese.dyndns.org>
References: <20080218130726.GA26854@localhost>
 <alpine.LSU.1.00.0802181339470.30505@racer.site>
 <20080218155546.GA8934@localhost>
 <alpine.LSU.1.00.0802181733400.30505@racer.site>
 <20080219125840.GA14049@localhost>
 <alpine.LSU.1.00.0802191313290.30505@racer.site>
 <20080219132410.GA6553@glandium.org>
 <alpine.LSU.1.00.0802191328040.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>, Clemens Buchacher <drizzd@aon.at>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 19 22:36:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRa8J-0005lB-Ix
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 22:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541AbYBSVff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 16:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754488AbYBSVff
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 16:35:35 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65146 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929AbYBSVfe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 16:35:34 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C19D57D05;
	Tue, 19 Feb 2008 16:35:32 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 E87D67D01; Tue, 19 Feb 2008 16:35:25 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74459>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I think this would not be too much of a hassle.  These days, an Apache2 is 
> installed on many machines, and it is better to have tests, than to have 
> no tests, even if they are not exercised everywhere, right?

I think a sensible guideline would be:

 - the core tools are tested by default everywhere;

 - i18n bits and foreign SCM interface are tested by default,
   but should allow opting-out;

 - networking test that needs to open listening ports should be
   off by default but should allow opting-in.

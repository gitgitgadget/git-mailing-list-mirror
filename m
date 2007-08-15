From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 1.5.3-rc5 regression on OS X?
Date: Wed, 15 Aug 2007 15:05:18 -0700
Message-ID: <7vodh8o3mp.fsf@gitster.siamese.dyndns.org>
References: <375487.35999.qm@web52802.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Perrin Meyer <perrinmeyer@yahoo.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 00:05:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILQzs-0000qQ-NN
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 00:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758706AbXHOWFZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 18:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758650AbXHOWFZ
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 18:05:25 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:45937 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758588AbXHOWFY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 18:05:24 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id BAADE121D98;
	Wed, 15 Aug 2007 18:05:41 -0400 (EDT)
In-Reply-To: <375487.35999.qm@web52802.mail.re2.yahoo.com> (Perrin Meyer's
	message of "Wed, 15 Aug 2007 15:01:20 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55957>

Perrin Meyer <perrinmeyer@yahoo.com> writes:

> Nothing has changed,, I just did a git checkout v1.5.2.4; make clean; make ; make test, and that same test passes. Then I did a git checkout v1.5.3-rc5 ; make clean ; make ; make test, and the same test fails. 
>
> I'll try updating to a newer version of Xcode and see if that helps. 

Before doing so, perhaps bisect between v1.5.2.4 and v1.5.3-rc5
woudl be very helpful.

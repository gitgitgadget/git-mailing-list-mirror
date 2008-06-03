From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Octopus merge: unique (?) to git, but is it useful?
Date: Mon, 02 Jun 2008 22:42:26 -0700
Message-ID: <7vod6j3whp.fsf@gitster.siamese.dyndns.org>
References: <200806030314.03252.jnareb@gmail.com>
 <alpine.LFD.1.10.0806021845210.3473@woody.linux-foundation.org>
 <7v3anv5fy3.fsf@gitster.siamese.dyndns.org>
 <7vskvv3xmx.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806030627440.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 03 07:43:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3PIu-00046a-MY
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 07:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbYFCFmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 01:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752162AbYFCFmg
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 01:42:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64661 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbYFCFmf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 01:42:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B5A9D32E4;
	Tue,  3 Jun 2008 01:42:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2089F32E2; Tue,  3 Jun 2008 01:42:30 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806030627440.13507@racer.site.net> (Johannes
 Schindelin's message of "Tue, 3 Jun 2008 06:28:49 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DDEA1DE4-312F-11DD-B499-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83618>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Would it not be better (simpler, cleaner) to just use an object flag?

No.  Can you tell which flag is safe to use in this context without
digging around too much?

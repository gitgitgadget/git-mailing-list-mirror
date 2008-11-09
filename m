From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Cached the git configuration, which is now noticibly
 faster on windows.
Date: Sun, 09 Nov 2008 10:33:49 -0800
Message-ID: <7vr65kagvm.fsf@gitster.siamese.dyndns.org>
References: <1226114569-8506-1-git-send-email-thestar@fussycoder.id.au>
 <1226114569-8506-2-git-send-email-thestar@fussycoder.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Chapman <thestar@fussycoder.id.au>, git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>, Han-Wen Nienhuys <hanwen@google.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 19:35:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzF88-0008Go-WF
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 19:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755564AbYKISeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 13:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755548AbYKISeI
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 13:34:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36603 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755514AbYKISeI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 13:34:08 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6D39495601;
	Sun,  9 Nov 2008 13:34:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2AD3A95600; Sun, 
 9 Nov 2008 13:33:52 -0500 (EST)
In-Reply-To: <1226114569-8506-2-git-send-email-thestar@fussycoder.id.au>
 (John Chapman's message of "Sat, 8 Nov 2008 14:22:49 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FCFE7880-AE8C-11DD-933C-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100459>

These are patches to fast-import/git-p4, which you two seem to in charge
of.

    From:	John Chapman <thestar@fussycoder.id.au>
    Subject: [PATCH 1/2] Added support for purged files and also optimised memory usage.
    Date:	Sat,  8 Nov 2008 14:22:48 +1100
    Message-Id: <1226114569-8506-1-git-send-email-thestar@fussycoder.id.au>

    From:	John Chapman <thestar@fussycoder.id.au>
    Subject: [PATCH 2/2] Cached the git configuration, which is now noticibly faster on windows.
    Date:	Sat,  8 Nov 2008 14:22:49 +1100
    Message-Id: <1226114569-8506-2-git-send-email-thestar@fussycoder.id.au>

It was unfortunately not immediately obvious from the Subject: line what
these patches are about, and I am guessing you missed them because of that.

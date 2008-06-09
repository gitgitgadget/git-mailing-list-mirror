From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] cat-file --batch / --batch-check: do not exit if
 hashes are missing
Date: Mon, 09 Jun 2008 13:37:13 -0700
Message-ID: <7v8wxegxae.fsf@gitster.siamese.dyndns.org>
References: <1212967717-5165-1-git-send-email-LeWiemann@gmail.com>
 <1212969741-24899-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 22:38:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5o89-0000EW-9J
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 22:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973AbYFIUhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 16:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753552AbYFIUhY
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 16:37:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251AbYFIUhX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 16:37:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 20B7F267F;
	Mon,  9 Jun 2008 16:37:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 90FDA267B; Mon,  9 Jun 2008 16:37:19 -0400 (EDT)
In-Reply-To: <1212969741-24899-1-git-send-email-LeWiemann@gmail.com> (Lea
 Wiemann's message of "Mon, 9 Jun 2008 02:02:21 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DC9220CA-3663-11DD-830A-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84422>

Lea Wiemann <lewiemann@gmail.com> writes:

> Previously, cat-file --batch / --batch-check would silently exit if it
> was passed a non-existent SHA1 on stdin.  Now it prints "<SHA1>
> missing" as in all other cases (and as advertised in the
> documentation).

I think this change makes sense, given that --batch is about having an
object server a read-only process can drive over bi-di pipe.

Thanks.

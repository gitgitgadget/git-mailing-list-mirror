From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] check return code of prepare_revision_walk
Date: Mon, 18 Feb 2008 00:40:11 -0800
Message-ID: <7vr6far72s.fsf@gitster.siamese.dyndns.org>
References: <12033199162949-git-send-email-mkoegler@auto.tuwien.ac.at>
 <1203319916670-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033199168-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Feb 18 09:41:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR1Ya-00073J-0G
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 09:41:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386AbYBRIkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 03:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754888AbYBRIkY
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 03:40:24 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49501 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754263AbYBRIkX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 03:40:23 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 508FB79A4;
	Mon, 18 Feb 2008 03:40:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 B778F79A3; Mon, 18 Feb 2008 03:40:18 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74246>

Thanks.

It makes me wonder if it is cleaner to simply die() inside
prepare_revision_walk() if all the callers are to do so
anyway, though.

But we can do that easily later if that turns out to be
desired.

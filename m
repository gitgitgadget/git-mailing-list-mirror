From: Junio C Hamano <gitster@pobox.com>
Subject: Puzzled by a t9500 test failure
Date: Mon, 13 Oct 2008 16:40:54 -0700
Message-ID: <7vljws83nd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 14 01:42:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpX3F-0000AM-Ko
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 01:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757180AbYJMXlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 19:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756951AbYJMXlA
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 19:41:00 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59993 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756667AbYJMXk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 19:40:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DB3DF8AABD;
	Mon, 13 Oct 2008 19:40:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6ED1E8AABC; Mon, 13 Oct 2008 19:40:56 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 62873CC2-9980-11DD-ADBF-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98163>

With recent tip of 'master':

    $ make
    $ mkdir t/trash
    $ cd t && sh t9500-*.sh -i

fails at the very first test.  Can anybody figure out why?

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] system_path(): simplify using
 strip_path_suffix(), and add suffix "git"
Date: Fri, 20 Feb 2009 00:35:56 -0800
Message-ID: <7vy6w1ec9f.fsf@gitster.siamese.dyndns.org>
References: <499C63E7.5040306@kdbg.org>
 <b91ca090ef4eed9e457b579df2e3fbede3d26299.1235070304u.git.johannes.schindelin@gmx.de> <499DC375.60105@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Feb 20 09:38:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaQtV-0006or-LY
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 09:38:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757862AbZBTIgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 03:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757784AbZBTIgG
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 03:36:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59408 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757711AbZBTIgF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 03:36:05 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C7D9A2B871;
	Fri, 20 Feb 2009 03:36:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D11802B87F; Fri,
 20 Feb 2009 03:35:58 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 83077CE6-FF29-11DD-8684-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110820>

Thanks; both patches applied.

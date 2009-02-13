From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] builtin-branch: improve output when displaying remote
 branches
Date: Thu, 12 Feb 2009 23:52:48 -0800
Message-ID: <7veiy2eptb.fsf@gitster.siamese.dyndns.org>
References: <7vhc30qki2.fsf@gitster.siamese.dyndns.org>
 <1234503271-78569-1-git-send-email-jaysoffian@gmail.com>
 <7v7i3ug7y9.fsf@gitster.siamese.dyndns.org>
 <76718490902122245q6f530bb5sc85a65e065966eda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 08:54:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXssT-0002yj-A0
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 08:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbZBMHw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 02:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752470AbZBMHw5
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 02:52:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45814 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbZBMHw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 02:52:56 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8A9D52B078;
	Fri, 13 Feb 2009 02:52:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DFC402B076; Fri,
 13 Feb 2009 02:52:49 -0500 (EST)
In-Reply-To: <76718490902122245q6f530bb5sc85a65e065966eda@mail.gmail.com>
 (Jay Soffian's message of "Fri, 13 Feb 2009 01:45:33 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5235B514-F9A3-11DD-B67E-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109723>

Jay Soffian <jaysoffian@gmail.com> writes:

> This strikes me as premature optimization.

It is *not* an optimization.  It is reduction of code duplication to
improve maintainability before copy-and-paste gets out of hand.

The proper adjective for it is not "premature" but "preemptive".

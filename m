From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] Removed unused variables prev and next.
Date: Thu, 27 Nov 2008 17:28:44 -0800
Message-ID: <7vabbkabar.fsf@gitster.siamese.dyndns.org>
References: <492F0CBF.3010202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 28 02:30:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5sBQ-0000rt-Ju
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 02:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053AbYK1B27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 20:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752792AbYK1B27
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 20:28:59 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39954 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbYK1B26 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 20:28:58 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DBBD582DCB;
	Thu, 27 Nov 2008 20:28:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5E85982DCA; Thu,
 27 Nov 2008 20:28:46 -0500 (EST)
In-Reply-To: <492F0CBF.3010202@gmail.com> (William Pursell's message of "Thu,
 27 Nov 2008 21:10:23 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ECE6AA9A-BCEB-11DD-89AA-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101855>

Hmm, I was hoping that use of these instead of $other =~ /,k/ might be
more efficient some day, but Ok.

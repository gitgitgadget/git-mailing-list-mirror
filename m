From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC3.5 05/12] send-email: Improve redability and
 error-handling in send_message's sendmail code
Date: Sun, 19 Apr 2009 18:38:00 -0700
Message-ID: <7vljpwp0jr.fsf@gitster.siamese.dyndns.org>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-6-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 03:39:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LviU2-0007yl-38
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 03:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022AbZDTBiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 21:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753469AbZDTBiM
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 21:38:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59155 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187AbZDTBiK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 21:38:10 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B4B12ACDD6;
	Sun, 19 Apr 2009 21:38:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B8257ACDD5; Sun,
 19 Apr 2009 21:38:05 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E6E3A8D4-2D4B-11DE-99C1-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116920>

Michael Witten <mfwitten@gmail.com> writes:

> +
> +		(my $pid = open my $pipe, '|-')
> +			// die "Could not fork to run '$smtp_server': $!\n";

Have I already rejected this "5.10 or later" construct in the previous
round?  If I haven't, please consider now I have.

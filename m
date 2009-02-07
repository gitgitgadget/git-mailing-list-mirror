From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] give exclude mechanism a debug option
Date: Fri, 06 Feb 2009 23:42:45 -0800
Message-ID: <7vhc36zo96.fsf@gitster.siamese.dyndns.org>
References: <20090207064221.GA14856@coredump.intra.peff.net>
 <20090207064454.GB14906@coredump.intra.peff.net>
 <7vljsizog1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 07 08:44:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVhrQ-00064i-Dw
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 08:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463AbZBGHmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 02:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753359AbZBGHmw
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 02:42:52 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62128 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308AbZBGHmw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 02:42:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 834EB97220;
	Sat,  7 Feb 2009 02:42:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 124929721F; Sat,
  7 Feb 2009 02:42:46 -0500 (EST)
In-Reply-To: <7vljsizog1.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 06 Feb 2009 23:38:38 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EC3EA9F8-F4EA-11DD-937E-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108823>

Junio C Hamano <gitster@pobox.com> writes:

>>   1. Doing it as a debug environment variable is hack-ish.
>>      A nicer interface would be a .gitignore equivalent of
>>      "git check-attr".
>
> Correct.

I suspect that ls-files would be the good match for it.  Wasn't the
exclude mechanism originally done for that command to begin with?

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC3 INTRO] I hope this will do it!
Date: Tue, 14 Apr 2009 02:02:46 -0700
Message-ID: <7vy6u36215.fsf@gitster.siamese.dyndns.org>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 11:06:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LteZc-0007FW-Om
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 11:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753519AbZDNJCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 05:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752565AbZDNJCy
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 05:02:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34851 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbZDNJCx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 05:02:53 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0F8A0AADFB;
	Tue, 14 Apr 2009 05:02:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AC20DAADFA; Tue,
 14 Apr 2009 05:02:48 -0400 (EDT)
In-Reply-To: <1239647037-15381-1-git-send-email-mfwitten@gmail.com> (Michael
 Witten's message of "Mon, 13 Apr 2009 13:23:44 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 08E8E976-28D3-11DE-A29E-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116530>

Michael Witten <mfwitten@gmail.com> writes:

> Here is the list of notable improvements:

I've picked up pieces that I think cannot possibly be controversial to
reduce the size of the remaining patch series still in flight.

Michael Witten (6):
      Docs: send-email: Put options back into alphabetical order
      Docs: send-email: Refer to CONFIGURATION section for sendemail.multiedit
      Docs: send-email: --smtp-server-port can take symbolic ports
      send-email: Handle "GIT:" rather than "GIT: " during --compose
      send-email: 'References:' should only reference what is sent
      send-email: Remove superfluous `my $editor = ...'

I've reworded the description in "symbolic port names" one a bit.

It is unfortunate that the interesting ones begin at 10th in the series,
which are beind the 9th one that is a "churn in the middle".

Thanks.

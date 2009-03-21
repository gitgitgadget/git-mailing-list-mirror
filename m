From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Invoke "git gc --auto" when a commit is successful.
Date: Sat, 21 Mar 2009 16:26:57 -0700
Message-ID: <7viqm2bgou.fsf@gitster.siamese.dyndns.org>
References: <1237674894-8151-1-git-send-email-dmellor@whistlingcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David J. Mellor" <dmellor@whistlingcat.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 00:30:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlAe5-0000r6-3Q
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 00:30:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738AbZCUX1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 19:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752928AbZCUX1I
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 19:27:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64312 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790AbZCUX1F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 19:27:05 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8C45BA3513;
	Sat, 21 Mar 2009 19:27:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9AD97A3511; Sat,
 21 Mar 2009 19:26:59 -0400 (EDT)
In-Reply-To: <1237674894-8151-1-git-send-email-dmellor@whistlingcat.com>
 (David J. Mellor's message of "Sat, 21 Mar 2009 15:34:54 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C84F4C0E-166F-11DE-AA2A-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114096>

I do not think situation has changed since the previous round:

    http://thread.gmane.org/gmane.comp.version-control.git/78524/focus=82130

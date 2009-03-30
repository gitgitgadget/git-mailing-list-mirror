From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] mergetool: use tabs consistently
Date: Mon, 30 Mar 2009 01:44:01 -0700
Message-ID: <7vzlf3flim.fsf@gitster.siamese.dyndns.org>
References: <1238389428-69328-1-git-send-email-davvid@gmail.com>
 <1238389428-69328-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 10:45:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoD7v-0002Nl-2O
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 10:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755837AbZC3IoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 04:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754704AbZC3IoL
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 04:44:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64624 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755410AbZC3IoK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 04:44:10 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BCCBFAFCD;
	Mon, 30 Mar 2009 04:44:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 248FEAFCA; Mon,
 30 Mar 2009 04:44:02 -0400 (EDT)
In-Reply-To: <1238389428-69328-2-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Sun, 29 Mar 2009 22:03:41 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EDFF5CA8-1D06-11DE-A59B-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115106>

Thanks.

Even though this [1/8] is obviously regression free, and I think the
overall direction in which the series is going is good, I'll wait until I
hear Acks from Charles Bailey for the parts that involve mergetool.  I do
not use either mergetool nor difftool myself, and going over every single
line of this series to spot potential regression is beyond my bandwidth
right now.

I do not think bits only common between mergetool and difftool should be
called with a very generic name "sh-tools".  We didn't call the result of
a similar refactoring for launching web browser from help and instaweb
context with such a generic name (it is called git-web--browse).

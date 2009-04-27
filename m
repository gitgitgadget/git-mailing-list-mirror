From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 (resend)] graph API: Use horizontal lines for more
 compact graphs
Date: Mon, 27 Apr 2009 09:35:18 -0700
Message-ID: <7veive6omx.fsf@gitster.siamese.dyndns.org>
References: <20090422212812.GA30830@linux.vnet>
 <20090427154341.GA9818@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Allan Caffee <allan.caffee@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 18:35:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyTnr-0006eA-9X
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 18:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbZD0Qf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 12:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752563AbZD0QfZ
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 12:35:25 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64771 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbZD0QfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 12:35:25 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3E91312CA4;
	Mon, 27 Apr 2009 12:35:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 83CF612CA2; Mon,
 27 Apr 2009 12:35:20 -0400 (EDT)
In-Reply-To: <20090427154341.GA9818@linux.vnet> (Allan Caffee's message of
 "Mon, 27 Apr 2009 11:43:41 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 683F7842-3349-11DE-AE91-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117689>

Allan Caffee <allan.caffee@gmail.com> writes:

> Junio, is this patch acceptable for inclusion?

I think your patch is an improvement, and it is queued as part of the
first batch post 1.6.3.

As a general guideline:

 - after -rc0, we do not take any feature enhancement patches that has not
   been discussed on the list before -rc0 was tagged;

 - after -rc1, we only take documentation updates, trivial fixes, and
   fixes (not necessarily trivial) to issues introduced since the last
   release (i.e. regression fix);

 - after -rc2, we only take documentation updates and regression fixes;


By the way, your Mail-Followup-To seems to be misconfigured.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/9] update 'git-rm' bash completion according to the man
 page
Date: Sat, 08 Aug 2009 12:49:14 -0700
Message-ID: <7vljludr2d.fsf@alter.siamese.dyndns.org>
References: <9f50533b0908080156t7cfd05ebg3e5d29f7d2260c25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Emmanuel Trillaud <etrillaud@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 21:49:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZrvM-0000BV-2P
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 21:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091AbZHHTto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 15:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753081AbZHHTto
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 15:49:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42882 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077AbZHHTto (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 15:49:44 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E57F022E8E;
	Sat,  8 Aug 2009 15:49:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6753422E8D; Sat,  8 Aug 2009
 15:49:32 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9E812688-8454-11DE-83F3-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125300>

Emmanuel Trillaud <etrillaud@gmail.com> writes:

> Signed-off-by: Emmanuel Trillaud <etrillaud@gmail.com>

Description of what you did?

> -		__gitcomp "--cached --dry-run --ignore-unmatch --quiet"
> +		__gitcomp "--force --cached --dry-run --ignore-unmatch --quiet"

I thought not completing --force to allow a dangerous operation was a
conscious decision.

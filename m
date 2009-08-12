From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: default version of the documentation tool chain (git 1.7)
Date: Tue, 11 Aug 2009 19:53:18 -0700
Message-ID: <7v8whpbv4x.fsf@alter.siamese.dyndns.org>
References: <4A8139C5.9030703@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Aug 12 04:53:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb3xz-0006My-0j
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 04:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755720AbZHLCxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 22:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755523AbZHLCxW
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 22:53:22 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59026 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754900AbZHLCxW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 22:53:22 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2D2F226853;
	Tue, 11 Aug 2009 22:53:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2260926851; Tue, 11 Aug 2009
 22:53:19 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4CCB21A6-86EB-11DE-982B-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125648>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> The current defaults for building the documentation are so that asciidoc
> up to 7.1.2 and docbook-xsl 1.69.0 and 1.71.1 need no extra settings,
> whereas all other versions need extra options (1 or more of ASCIIDOC8,
> ASCIIDOC_NO_ROFF, DOCBOOK_XSL_172, DOCBOOK_SUPPRESS_SP), see below. This
> basically means that all current distros need extra options.
>
> I suggest changing the defaults for the git-1.7 cycle.

Do you mean that people with older asciidoc would set a new option, say
ASCIIDOC7, instead of not setting ASCIIDOC8?

> Based on that, I suggest the following defaults for the git-1.7
> documentation build file:
> - ASCIIDOC8=yes. Caters for everything non-EOLed (8.0 and above)
> - ASCIIDOC_NO_ROFF=yes. Caters for everything non-EOLed (1.73 and above,
> 1.68.1 and below)

I would say that is a sensible default.

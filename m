From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] git apply: option to ignore whitespace differences
Date: Thu, 30 Jul 2009 17:48:00 -0700
Message-ID: <7v3a8d65kv.fsf@alter.siamese.dyndns.org>
References: <1248814820-25367-1-git-send-email-giuseppe.bilotta@gmail.com>
 <7vljm84htf.fsf@alter.siamese.dyndns.org>
 <cb7bb73a0907282333g26efd1d8y7d913fba8a426aa5@mail.gmail.com>
 <20090729174000.6117@nanako3.lavabit.com>
 <94a0d4530907301727h171a2581ybee2a5b2d77e7c05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 02:48:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWgIL-0001gv-Gr
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 02:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbZGaAsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 20:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbZGaAsK
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 20:48:10 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46796 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbZGaAsK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 20:48:10 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 172881A6B5;
	Thu, 30 Jul 2009 20:48:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3C8DF1A6AB; Thu,
 30 Jul 2009 20:48:02 -0400 (EDT)
In-Reply-To: <94a0d4530907301727h171a2581ybee2a5b2d77e7c05@mail.gmail.com>
 (Felipe Contreras's message of "Fri\, 31 Jul 2009 00\:27\:37 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D1B307FA-7D6B-11DE-A024-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124495>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Google:
> ignore space change: 17,300,000
> ignore white space: 181,000,000

But that is not relevant either.  "ignore white space" is a superset of
"ignore space change", iow the latter has more specific meaning than the
former.  It is not surprising to see that search engines find larger
number of references to more general terms than more specific ones.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Implement git-vcs-p4
Date: Wed, 05 Aug 2009 10:41:38 -0700
Message-ID: <7vocqu9mzx.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0908050056580.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Pete Wyckoff <pw@padd.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 19:41:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYkUt-00021Z-Dt
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 19:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbZHERls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 13:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbZHERls
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 13:41:48 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52393 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbZHERls (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 13:41:48 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3AE631EA95;
	Wed,  5 Aug 2009 13:41:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 97D3D1EA8C; Wed,  5 Aug 2009
 13:41:40 -0400 (EDT)
In-Reply-To: <alpine.LNX.2.00.0908050056580.2147@iabervon.org> (Daniel
 Barkalow's message of "Wed\, 5 Aug 2009 01\:02\:31 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3F989CA6-81E7-11DE-A01F-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124931>

Daniel Barkalow <barkalow@iabervon.org> writes:

> This is probably not particularly appropriate for mainline
> application, and is somewhat buggy, not extensively tested, and
> incomplete, but is here as an example implementation of the API and in
> case it is useful to other people.

I do not mind carrying this in the tree, at least on 'pu', for wider
exposure---giving easier access to others _might_ help you gain
contributors.

But we need to disable this in the Makefile by default and force
interested parties to explicitly ask for it if we were to do that.

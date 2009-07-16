From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.6.4.rc1
Date: Wed, 15 Jul 2009 23:31:04 -0700
Message-ID: <7v3a8xb0lz.fsf@alter.siamese.dyndns.org>
References: <7vmy75bg2f.fsf@alter.siamese.dyndns.org>
 <4A5EA598.5050801@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Thu Jul 16 08:31:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRKVB-0002tS-Et
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 08:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756613AbZGPGbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 02:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756493AbZGPGbM
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 02:31:12 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46438 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756286AbZGPGbM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 02:31:12 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4E8F48329;
	Thu, 16 Jul 2009 02:31:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D82488327; Thu, 16 Jul 2009
 02:31:05 -0400 (EDT)
In-Reply-To: <4A5EA598.5050801@garzik.org> (Jeff Garzik's message of "Wed\,
 15 Jul 2009 23\:59\:20 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4042DA2E-71D2-11DE-9740-9AE02FB70C38-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123366>

Jeff Garzik <jeff@garzik.org> writes:

> Is there some sort of guide to the new best practices for handling
> trees such as git.kernel.org, where one pushes into "foo.git"
> directly, and there is no checked-out source code at all?

I think old repositories will be helped if you add

	[core]
        	bare

to their foo.git/config files.

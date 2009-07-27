From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.6.4-rc3
Date: Sun, 26 Jul 2009 20:14:25 -0700
Message-ID: <7vk51uom0e.fsf@alter.siamese.dyndns.org>
References: <7vws5vrh93.fsf@alter.siamese.dyndns.org>
 <4A6D08D3.50404@chaz6.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Hills <chaz@chaz6.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 05:14:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVGff-0001kA-6p
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 05:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755610AbZG0DOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 23:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755576AbZG0DOa
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 23:14:30 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41153 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755456AbZG0DO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 23:14:29 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 69C1A15E9D;
	Sun, 26 Jul 2009 23:14:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DD15915E9C; Sun,
 26 Jul 2009 23:14:26 -0400 (EDT)
In-Reply-To: <4A6D08D3.50404@chaz6.com> (Chris Hills's message of "Mon\, 27
 Jul 2009 03\:54\:27 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 98F0CA96-7A5B-11DE-9EAF-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124154>

Chris Hills <chaz@chaz6.com> writes:

> It seems that running `make distclean` removes the configure
> script. Is this expected behavior?

Yes.

The users are not expected to run configure before building, and we do not
ship a configure script as part of the distribution.

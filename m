From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remove tests of always-false condition
Date: Thu, 26 May 2011 11:23:46 -0700
Message-ID: <7v39k1xqvh.fsf@alter.siamese.dyndns.org>
References: <87zkm95zt3.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Thu May 26 20:24:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPfE3-00045r-P1
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 20:24:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758301Ab1EZSXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 14:23:55 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932491Ab1EZSXx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 14:23:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 471584004;
	Thu, 26 May 2011 14:26:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ScD+j4CdnBTqR5j5ZUuBMMo2LzI=; b=HbRJe3
	/SJ+TCuT5GGER9TCQSrszIAaJGfckCwujOjksWoS1GIPl3FuuIc1egOWLo5ZsEAe
	cVZ4FDqPvJbaUY7CPOcDBOicqXqvaET5i4dRADhaz1b4Ux8iBAluxXZeb9QeaBt1
	egwQT5ALYTJ0WuyZ9txfIWJe5CmeLDTXUF8yI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AZDyfgO7e8BOTfWUI4X+KmjHAU7e7zqX
	pXsbiL+3/b/jBoC+E5LJ6iqHGomDsSHSxI4dCx1JWr5yAMKj3RoUuE+L2xUw5XZL
	8EDLn08k6IlOIrv8HMG5wG7/824zf9x4EtfJqDrCytVupf80iw6JlxTeACGva2Ks
	6NRQJYQLhxc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2428B4003;
	Thu, 26 May 2011 14:25:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4A1F34002; Thu, 26 May 2011
 14:25:55 -0400 (EDT)
In-Reply-To: <87zkm95zt3.fsf@rho.meyering.net> (Jim Meyering's message of
 "Thu, 26 May 2011 15:58:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 99DA6132-87C5-11E0-BBA3-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174555>

Jim Meyering <jim@meyering.net> writes:

> Relative to "next".

I don't appreciate this comment especially for a patch that applies
cleanly to "maint".

But other than that, fine.  Thanks.

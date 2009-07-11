From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's happening with vr41xx_giu.c?
Date: Fri, 10 Jul 2009 20:14:50 -0700
Message-ID: <7vk52frjv9.fsf@alter.siamese.dyndns.org>
References: <4A5680B5.2090405@necel.com> <4A56B060.7090106@mips.com>
 <20090710104743.GB1288@linux-mips.org>
 <7vhbxkv7ax.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Dearman <chris@mips.com>,
	Shinya Kuribayashi <shinya.kuribayashi@necel.com>,
	yuasa@linux-mips.org, linux-mips@linux-mips.org,
	git@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
X-From: git-owner@vger.kernel.org Sat Jul 11 05:15:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPT3I-0004Ri-DO
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 05:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151AbZGKDPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 23:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753045AbZGKDPB
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 23:15:01 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53233 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033AbZGKDPA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 23:15:00 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 39BF427977;
	Fri, 10 Jul 2009 23:14:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 45B4C27976; Fri,
 10 Jul 2009 23:14:52 -0400 (EDT)
In-Reply-To: <7vhbxkv7ax.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 10 Jul 2009 09\:20\:22 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0418617A-6DC9-11DE-80C8-424D1A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123094>

Junio C Hamano <gitster@pobox.com> writes:

> We _could_ add -E option to "git apply" and pass that through "git am" to
> support projects like the kernel where 0-byte files are forbidden.  A
> patch to do that shouldn't be too involved.

I ended up doing something a bit more useful.  A two-patch series follows
shortly.

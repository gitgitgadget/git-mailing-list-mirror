From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v1.8.1-rc0
Date: Wed, 05 Dec 2012 10:47:11 -0800
Message-ID: <7v1uf4l4k0.fsf@alter.siamese.dyndns.org>
References: <7vip8iq1vs.fsf@alter.siamese.dyndns.org>
 <50BF9544.7060401@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: linux-kernel-owner@vger.kernel.org Wed Dec 05 19:47:36 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1TgK0O-0007VH-3x
	for glk-linux-kernel-3@plane.gmane.org; Wed, 05 Dec 2012 19:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063Ab2LESrR (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 5 Dec 2012 13:47:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49749 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753180Ab2LESrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Dec 2012 13:47:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFCD3A77E;
	Wed,  5 Dec 2012 13:47:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nbrxgqxS62J3aiBeNAXTBeDPLHo=; b=cf2Dv7
	8I8YJzlxiV9fPel80U0jTKFVpfzWyn/xbcQBUA6yBJV0dmFNIwD1NP4qDr3ciwN3
	leeLOCJz1kUH1aK6Mc2a1ByHBckCRTUqKa0xdDcNyeNxEbuNysfPM2w21sRPj4Rs
	ypd77qv3FJ4mDBGSZGwV96iqjGs81n8EBzZwE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sn3L3SfcCEsrB90Xc1pT44c4i7y1hWp3
	l9S/yYJlLH4v1zffCm6eyWtNKfz5cR7+sHMtFQci5RwFLP2romuSrXIbdta3DovU
	+CQm3Yxcpu+CNKbKZW7eIKZobancFnIfza1lBnfMW5qy3ztD7w/qAlWu8DFvvMPs
	46cG/dDgU/4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBF1FA77D;
	Wed,  5 Dec 2012 13:47:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4CE60A77B; Wed,  5 Dec 2012
 13:47:13 -0500 (EST)
In-Reply-To: <50BF9544.7060401@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Wed, 05 Dec 2012 18:41:08 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2EE1A3F4-3F0C-11E2-B8AB-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211136>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> I fetch git from 'git://git.kernel.org/pub/scm/git/git.git' which has
> commit ee26a6e2 ("Git 1.8.1-rc0", 03-12-2012), but is missing the v1.8.1-rc0
> tag. Is this just an oversight ...

Thanks for letting me know; forgot to push out the tag.

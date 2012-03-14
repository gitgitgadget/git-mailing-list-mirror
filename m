From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] diff: refactor the word-diff setup from
 builtin_diff_cmd
Date: Wed, 14 Mar 2012 12:26:19 -0700
Message-ID: <7vobrzoug4.fsf@alter.siamese.dyndns.org>
References: <3bb99e938624ae674674b304c24c48b9dc05871b.1331749299.git.trast@student.ethz.ch> <9f2f3a870a8d88850444090318647f3c7b8c0743.1331749299.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Mar 14 20:26:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7tqP-0003q0-Qx
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 20:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461Ab2CNT0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 15:26:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59250 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932380Ab2CNT0W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 15:26:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C42016AB5;
	Wed, 14 Mar 2012 15:26:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BAs06ac31XToK9AWTB7z+crb9QE=; b=I0Ml76
	5aCUzkvNtaQbSWLqp4C1vgNYHb4BtXZXA33EBLs1sEkZ3Ep/ZJLGVEpswleIk7yI
	lnFbr8sdl+7ja12CaZALTwFTBLeXvq6Rjeduu1HVjGfUHiY/xRZDDky6A8u0/wuU
	ejdqT/PbKWUHwitAtF/ravaMJSWIpyFw0trS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tFPXL6YthN8aeYT6gbW0L9Libv2+vna/
	W6C2A94a9ET1ki6KMRjtj8cZTzWUXxVRICLC/j74WqVddzmG5TMTFpriJQBCXDG6
	A8SqUiVApI9O0vJ5Gl9rKKbH2UdxCfQbNbK0Inyjqnri5xGlWVbt504hSnsOFUqH
	akg2awYR/l0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBEFA6AB4;
	Wed, 14 Mar 2012 15:26:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52FC66AB3; Wed, 14 Mar 2012
 15:26:21 -0400 (EDT)
In-Reply-To: <9f2f3a870a8d88850444090318647f3c7b8c0743.1331749299.git.trast@student.ethz.ch> (Thomas Rast's message of "Wed, 14 Mar 2012 19:24:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9488BCCE-6E0B-11E1-86EF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193153>

Thomas Rast <trast@student.ethz.ch> writes:

> Quite a chunk of builtin_diff_cmd deals with word-diff setup, defaults
> and such.  This makes the function a bit hard to read, but is also
> asymmetric because the corresponding teardown lives in free_diff_words_data
> already.

Yay!  "A bit hard to read" is a gross understatement ;-)

Whether the series fixes a bug of not, this alone makes the patch
worthwhile to look.

Thanks.

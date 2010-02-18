From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Host refs to push are chosen (documentation error)?
Date: Wed, 17 Feb 2010 20:06:41 -0800
Message-ID: <7vocjnuqzy.fsf@alter.siamese.dyndns.org>
References: <201002171627.57599.arvidjaar@mail.ru>
 <be6fef0d1002170539v4384b355lb6be3e2f19b7b87b@mail.gmail.com>
 <32541b131002170939l261f396cpbee45f652fd96c77@mail.gmail.com>
 <20100218011620.GA15870@coredump.intra.peff.net>
 <32541b131002171751n454081a9w90f2957d7a40d87@mail.gmail.com>
 <7vaav7wb8v.fsf@alter.siamese.dyndns.org>
 <20100218021010.GA21693@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Andrey Borzenkov <arvidjaar@mail.ru>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 18 05:07:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhxfZ-0006rN-Mk
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 05:07:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537Ab0BREHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 23:07:06 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51119 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab0BREHE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 23:07:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E20349AE15;
	Wed, 17 Feb 2010 23:06:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tymkSDPujycVlx8dbHbyFSVKrfg=; b=oU01Ml
	R9PApXF1oGPJ806y6F7mL66TYTkADHhtakUsJrLt2CQQLkgThLWH8oZuIqWRf+J2
	daUCMbisnez9TE4ACA7MKIQbGyxfc8+ct36NgYjlEoSpY+PfibU8dCc5XPzf07WW
	j0eTuSpanXloYmnqe2TFVNOkNIvd0kkZ/iaB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dVCOzux/a99adxdM734l80r98YkCoRg+
	R2XzTdmwF7XbSXq20Uk9HOh88nrowa/SpAy1srSr1ZieODiCn0ouzjtRdGlEx6hr
	0+LEb2pjO3LvAczsbU7QCVBsYM/qrsFZiuB5S6RlaYWWABoG1UmtGPoqzUYj/pd0
	NtFPGhn1YvQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B8349AE14;
	Wed, 17 Feb 2010 23:06:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99FD89AE0F; Wed, 17 Feb
 2010 23:06:44 -0500 (EST)
In-Reply-To: <20100218021010.GA21693@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 17 Feb 2010 21\:10\:10 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0C1354BA-1C43-11DF-B6F7-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140293>

Jeff King <peff@peff.net> writes:

> @@ -217,10 +217,8 @@ them easily.
>  MERGE_HEAD records the commit(s) you are merging into your branch
>  when you run 'git merge'.
>  +
> -For any of the `$GIT_DIR/refs` cases above, packed refs from
> -`$GIT_DIR/packed-refs` may be substituted (e.g., a line with
> -`refs/heads/master` in the packed-refs file would have the same
> -precedence as the file `$GIT_DIR/refs/heads/master`).
> +Note that any of the `refs/*` cases above may come either from
> +the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.

This makes it much more clear.  Thanks.

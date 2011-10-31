From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] Compile fix for MSVC
Date: Mon, 31 Oct 2011 13:34:18 -0700
Message-ID: <7vd3dcq4s5.fsf@alter.siamese.dyndns.org>
References: <1320088364-25916-1-git-send-email-vfr@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, kusmabite@gmail.com,
	ramsay@ramsay1.demon.co.uk, msysgit@googlegroups.com,
	gitster@pobox.com
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Mon Oct 31 21:34:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKyYr-0002eo-Tl
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 21:34:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934083Ab1JaUeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 16:34:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34135 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933617Ab1JaUeU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 16:34:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 383515409;
	Mon, 31 Oct 2011 16:34:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DYTVUzMpawL7LmxIVCLSZzVDCak=; b=VhMzWU
	GLqqYg/OUFDykn4bN4Y7VxzvxWgfnorntKgMwA70YIQxKgimAStOovanqzdBZu7f
	ptjHXyTHPrVmjxGeZrUjIazMizgXSVcDu1FfANYpLrK51XULQVCCzY9AS4lhAC9U
	8Q/phJHSoq/S7kUupZfC2nnAOkZFVS1IsxTjE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rhn01flnN5jDkx7PaORiqef5S9repNFB
	SAdNcITTl0fEKS+7yJsNMpYR3npAZf46WKrxtFv3LKSZK5shhMNWKQdWZdQHZ8Ao
	DrRAnG10MSBqUFm/+3uSVfFwiGyE88RveKlSD5XleiKkkR4Er2LtKQdRmiduAMJ2
	iG65Kn8ZmjQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E98E5408;
	Mon, 31 Oct 2011 16:34:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A567E5407; Mon, 31 Oct 2011
 16:34:19 -0400 (EDT)
In-Reply-To: <1320088364-25916-1-git-send-email-vfr@lyx.org> (Vincent van
 Ravesteijn's message of "Mon, 31 Oct 2011 20:12:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B5A57936-03FF-11E1-8E5B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184523>

Thanks. The patch looks good from a POSIX person's point of view, and I do
not immediately see how this would break other variants of Windows build
at least from the code inspection.

So I'll queue this, but I'll leave it to you and msysgit folks to decide
if this topic should be merged to 1.7.8-rc1, as I do not have equipment,
expertise, nor time to judge it myself (other than the code inspection we
have already done here).

Please give me an Ack or two by the end of this week. Thanks.

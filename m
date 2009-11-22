From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Per file configurable eol-style transformations with Git?
Date: Sat, 21 Nov 2009 17:24:38 -0800
Message-ID: <7v6393nyg9.fsf@alter.siamese.dyndns.org>
References: <9ED0EB52C33C41209726C6F4DB7FC194@helium>
 <m3tywnbmpj.fsf@localhost.localdomain>
 <1050CAACABF64864A0CF79C957BF773B@helium>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Alexander Veit" <alexander.veit@gmx.net>
X-From: git-owner@vger.kernel.org Sun Nov 22 02:24:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NC1C9-0008LK-IP
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 02:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024AbZKVBYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2009 20:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752931AbZKVBYm
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 20:24:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65065 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbZKVBYl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2009 20:24:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BE98BA0F80;
	Sat, 21 Nov 2009 20:24:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ls2pNqXU/Z2cFPiXpe76nbr4BZo=; b=D/8ytX
	pIBplsfGkMqfGasbcBrizeVSWMhf7i1XRq8QgBskAPeDs3NCyOpioNnyr7NKyXVu
	ugVlJu4QyRQ08vUwTZg8QxLWVGe7HRjqjjC/JFAo6hqJ9cqDzNGXrqVaTKiHZnFX
	Le8zL5cMGm6KV03LGWRVIFFosvsXJQU74D8RU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bOxqXBpnl/XWgvgw0IXBT+7cS32uHQUC
	CgRnS9d53ESA8uDakZ6ap69ooWIDybrYV0bTv5Ec4wup1LaTVWU8TPRo2sgxg/9J
	Zd0e4t9loatr0jrkKHxyWqpVBpaErcY1gaC9G6mXpEOWkxT08mgXNcYRnB8jSO05
	0KlsCLCtohM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9C5B4A0F7F;
	Sat, 21 Nov 2009 20:24:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AE8BAA0F7B; Sat, 21 Nov 2009
 20:24:40 -0500 (EST)
In-Reply-To: <1050CAACABF64864A0CF79C957BF773B@helium> (Alexander Veit's
 message of "Sun\, 22 Nov 2009 00\:49\:57 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D039F160-D705-11DE-B354-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133418>

"Alexander Veit" <alexander.veit@gmx.net> writes:

> Jakub Narebski wrote:
>
>> See `crlf` attribute, which can be set, unset, unspecified, set
>> to "input", and used together with core.autocrlf ("true", "false",
>> "input") and core.safecrlf.  Attributes can be set per path (using
>> globbing patterns) in .gitattributes file in tree, or in
>> .git/info/attributes (per repository).
>
> I've already tried 
>
> [core]
>   autoCRLF = true
>
> in the global gitconfig under Windows.

That would not be per-file anyway.

What Jakub suggested makes sense.  You want to read up on
gitattributes(5).

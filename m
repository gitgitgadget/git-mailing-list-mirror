From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-difftool: allow skipping file by typing 'n' at
 prompt
Date: Tue, 04 Oct 2011 08:25:07 -0700
Message-ID: <7vbotwdbjg.fsf@alter.siamese.dyndns.org>
References: <20111004105333.GA24331@atcmail.atc.tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaram@atc.tcs.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 17:25:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB6ru-0007Mo-8g
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 17:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666Ab1JDPZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 11:25:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44361 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932494Ab1JDPZK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 11:25:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93DFA4AF4;
	Tue,  4 Oct 2011 11:25:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aZ7IflDsMNlap6of5R93Qn5wDOU=; b=GiZ6Fa
	HlVvZN5qo05N87aB1peRKM6DsJ/ixTkYpzLeiGGrop1Wi954qHNF8tJdKm7jpkvY
	qsP/7+KEgtrpLKvsG+AdYUBJFdupzaMjlwfxy57a0qyMXiyCFxKKV1/Z1xbz4LiF
	7ZEgBcOJq82XPA51QyefPzaXqizpI4VuwjE9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qvQrkv9b2FXHaGjF2k38mdn5iNVHoraT
	2THo6N6AX9F1mWL+VJmIMOMvN3lerQ+uHurnCIG6b4u2pF1G8Oh1+ELwiteoQVXj
	uvXiITK8QcYM1kh4rWtM2IXsnBvIO2PTKVSSoc2Swzbzudr/SZau+BXs98mvv8o7
	1W7GP1w2+Yg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AC534AF3;
	Tue,  4 Oct 2011 11:25:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21DEF4AF2; Tue,  4 Oct 2011
 11:25:09 -0400 (EDT)
In-Reply-To: <20111004105333.GA24331@atcmail.atc.tcs.com> (Sitaram Chamarty's
 message of "Tue, 4 Oct 2011 16:23:33 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0B829A50-EE9D-11E0-A849-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182776>

Sitaram Chamarty <sitaram@atc.tcs.com> writes:

> Signed-off-by: Sitaram Chamarty <sitaram@atc.tcs.com>
> ---
>
> I'm using what is pretty much a universal convention to
> signify that the default choice is "y"; I hope documentation
> for something so small is not needed but if it is, let me
> know and I'll do that also.
>
> -			printf "Hit return to launch '%s': " \
> +			printf "Launch '%s' [y]/n: " \

I think I've seen this done as: "do this? [Y/n]" elsewhere.

Not telling you what to do, but trying to feel what others may think.

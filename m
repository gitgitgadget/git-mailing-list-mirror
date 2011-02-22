From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-checkout.txt: improve detached HEAD documentation
Date: Mon, 21 Feb 2011 21:56:15 -0800
Message-ID: <7vd3mkfw8w.fsf@alter.siamese.dyndns.org>
References: <7v7hcy9vrk.fsf@alter.siamese.dyndns.org>
 <1298179310-46207-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 06:56:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrlEd-00040e-T7
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 06:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329Ab1BVF42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 00:56:28 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62383 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264Ab1BVF41 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 00:56:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 96FE42430;
	Tue, 22 Feb 2011 00:57:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0rB1+PVBcZkllG/j1JUiTZghynQ=; b=lzz1W3
	QC3jkKaG8fRQCSgpT1/mNyGtEH6gcRppi0W5rmC8zTvY4PSzQaNoe+vWrq3lGbEk
	buL6AiD3EnOGLG5VcDT7Y3vVaPULkU5Q/pxx/S/p1SKWOjFi/cpghVmDa8ISFYNL
	otRuAUPhj/kZjr5Fcr8zw2Tpp9PLUHArZzb5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JelI6rzhjKAshiIfy2xQr9yZutJhNmWy
	6JZPasEIvzryF8Id2ZhqV/XjmyknJEw3xzQYOWZU1qnVDp1HQsB6aCu0zbpjOHJ9
	tK3wKDmo0xdRWH0vOWhT1zuOc0SryCif1axGk8EJsB+BJBWTz7EeTmjbU2ECh8hZ
	kJIHmdsRsgs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 50AA6242E;
	Tue, 22 Feb 2011 00:57:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 383D4242D; Tue, 22 Feb 2011
 00:57:27 -0500 (EST)
In-Reply-To: <1298179310-46207-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Sun\, 20 Feb 2011 00\:21\:50 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A3828028-3E48-11E0-BAD3-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167526>

Jay Soffian <jaysoffian@gmail.com> writes:

> +It is sometimes useful to be able to checkout a commit that is not at
> +the tip of any named branch, or even to create a new commit that is not
> +referenced by a named branch. Let's look at what happens when we
> +checkout commit 'b' (here we show three ways this may be done):
>  
> +------------
> +$ git checkout v2.0  # or
> +$ git checkout b     # or
> +$ git checkout master^^

I'd drop the second one, as "b" is not something the end user would type
from the command line (you could say "b's commit ID" but the string 'b' is
not it, unless it is a tag or something, in which case the first one that
uses 'v2.0' already illustrates it), and adjust "three" accordingly.

Other than that, I think this version is a vast improvement over what we
have.

Thanks.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cherry-pick.txt: correct a small typo
Date: Sun, 29 May 2016 17:41:33 -0700
Message-ID: <xmqq4m9gpebm.fsf@gitster.mtv.corp.google.com>
References: <20160529192929.40200-1-scorphus@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Pablo Santiago Blum de Aguiar <scorphus@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 02:41:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7BH3-0007x9-Hw
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 02:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbcE3Ali (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2016 20:41:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50967 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752025AbcE3Alh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2016 20:41:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 070331F22B;
	Sun, 29 May 2016 20:41:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QHYQPOBvWMQ8LsrpeNabo4hjj/g=; b=ZtWi09
	V54t23ffu7zbuQqNaku6fhETl1Gb+I5sqeEeiry3OGD/EKU7VCLF4WhhrJgF1hDw
	ipTrpocfpWQyA9vLwucthzOOVwNcbK+5gXU6iE14OCkSKOM3YV31yER/EpnD3kB2
	ZqIUftvTvRTKnNQKrIDwLHqPuf+cCr/rZKEBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iaDwmaMF+Z/U8oykJ9THgBM6+uqE94c1
	aaHY+T8sDFwgWY2toGkfNnU7Z+smuaRKDUhnc/J+Wr283aq38G0vdf9HPfeJZW+n
	GuZ7i86s6dfQ4BNOOyPovf3uzgw8ElpzrqnNJeXDp9W+i4ukcB5wCSnrSl0D39I4
	9N6SMeTYw5A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F34481F22A;
	Sun, 29 May 2016 20:41:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6FE7E1F227;
	Sun, 29 May 2016 20:41:35 -0400 (EDT)
In-Reply-To: <20160529192929.40200-1-scorphus@gmail.com> (Pablo Santiago Blum
	de Aguiar's message of "Sun, 29 May 2016 16:29:29 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4324089C-25FF-11E6-9827-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295850>

Pablo Santiago Blum de Aguiar <scorphus@gmail.com> writes:

> Most of the document mentions `behavior` instead of the British
> variation, `behaviour`. This change makes it consistent.
>
> Signed-off-by: Pablo Santiago Blum de Aguiar <scorphus@gmail.com>
> ---

Thanks.  This line comes from an ancient 4bee9584 (cherry-pick: add
--allow-empty-message option, 2012-08-02) that happend in v1.8.0
timeframe, and nobody complained for the last 4 years ;-)

We see this in CodingGuidelines:

 The documentation liberally mixes US and UK English (en_US/UK)
 norms for spelling and grammar, which is somewhat unfortunate.
 In an ideal world, it would have been better if it consistently
 used only one and not the other, and we would have picked en_US
 (if you wish to correct the English of some of the existing
 documentation, please see the documentation-related advice in the
 Documentation/SubmittingPatches file).

and the part of SubmittingPatches it refers to is this:

 Speaking of the documentation, it is currently a liberal mixture of US
 and UK English norms for spelling and grammar, which is somewhat
 unfortunate.  A huge patch that touches the files all over the place
 only to correct the inconsistency is not welcome, though.  Potential
 clashes with other changes that can result from such a patch are not
 worth it.  We prefer to gradually reconcile the inconsistencies in
 favor of US English, with small and easily digestible patches, as a
 side effect of doing some other real work in the vicinity (e.g.
 rewriting a paragraph for clarity, while turning en_UK spelling to
 en_US).  Obvious typographical fixes are much more welcomed ("teh ->
 "the"), preferably submitted as independent patches separate from
 other documentation changes.

I wish there were some "other real work in the vicinity" I can use
as an excuse, which would have made it far easier to take this patch;
as I already took a look at it and wrote a response to it, I'll
queue it anyway ;-)

Thanks.




>  Documentation/git-cherry-pick.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> index 6154e57..c104a59 100644
> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -128,7 +128,7 @@ effect to your index in a row.
>  
>  --allow-empty-message::
>  	By default, cherry-picking a commit with an empty message will fail.
> -	This option overrides that behaviour, allowing commits with empty
> +	This option overrides that behavior, allowing commits with empty
>  	messages to be cherry picked.
>  
>  --keep-redundant-commits::

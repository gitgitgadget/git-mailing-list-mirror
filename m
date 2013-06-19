From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] glossary: add 'treeish' as a synonym for 'tree-ish'
Date: Wed, 19 Jun 2013 10:09:59 -0700
Message-ID: <7vli6610yg.fsf@alter.siamese.dyndns.org>
References: <1371607780-2966-1-git-send-email-rhansen@bbn.com>
	<1371607780-2966-2-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 19:10:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpLtY-0005YX-Su
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 19:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757142Ab3FSRKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 13:10:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56192 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756882Ab3FSRKC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 13:10:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADAAC29144;
	Wed, 19 Jun 2013 17:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u5ZOKkyQQzDwVPCbx+jyAjJyQ9Q=; b=toaJGa
	Tzrj0xb4+AHoKGGOEwa48a4ZuLZle3sOBs322/rBaZMIMWlxZuvF3KTvXGQL70Ws
	1Ydvb2ej87NCo4AzEN6+HnEpEqLVEc5TLty++ceoSViWpBDNXPv5R/GX3hKoHYOw
	s3riNnKzoCy0YcyjrxgdLmKl12UMBKCY5TSho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AfACDE4OSsRkslY8P3jCNgA2uuqgug0E
	VWQwRsEBJYWvb99RfJdHV+gfUkOOcf8kYlBtdt9yqlRsy357zw1oeXa0nnuDPPG+
	8XhiuM0TuTtJCi4ejqZcrp9uo7cyej117ML28BTHzW/SIlUTtV5r6bk/77HXCTBd
	qXBxB4TuHJE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E82229142;
	Wed, 19 Jun 2013 17:10:01 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EFA5829140;
	Wed, 19 Jun 2013 17:10:00 +0000 (UTC)
In-Reply-To: <1371607780-2966-2-git-send-email-rhansen@bbn.com> (Richard
	Hansen's message of "Tue, 18 Jun 2013 22:09:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13813E62-D903-11E2-83E7-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228402>

Richard Hansen <rhansen@bbn.com> writes:

> The documentation contains a mix of the two spellings, and including
> both makes it possible for users to search the glossary with their
> spelling of choice.

Is it an option to instead find dashless form in our documentation
and turn all of them into tree-ish form with a dash?  I personally
find it cleaner that way.

>
> Signed-off-by: Richard Hansen <rhansen@bbn.com>
> ---
>  Documentation/glossary-content.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index db2a74d..01365d9 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -486,7 +486,7 @@ should not be combined with other pathspec.
>  	with refs to the associated blob and/or tree objects. A
>  	<<def_tree,tree>> is equivalent to a <<def_directory,directory>>.
>  
> -[[def_tree-ish]]tree-ish::
> +[[def_tree-ish]]tree-ish (also treeish)::
>  	A <<def_ref,ref>> pointing to either a <<def_commit_object,commit
>  	object>>, a <<def_tree_object,tree object>>, or a <<def_tag_object,tag
>  	object>> pointing to a tag or commit or tree object.

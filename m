From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/7] glossary: mention 'treeish' as an alternative to 'tree-ish'
Date: Tue, 03 Sep 2013 15:46:17 -0700
Message-ID: <xmqq1u55plqe.fsf@gitster.dls.corp.google.com>
References: <1378100066-31889-1-git-send-email-rhansen@bbn.com>
	<1378100066-31889-2-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 00:46:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGzMi-0004To-AK
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 00:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761180Ab3ICWqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 18:46:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51657 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760755Ab3ICWqY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 18:46:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A8BFB3E2F3;
	Tue,  3 Sep 2013 22:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=jg1e6NTJ0HW8mLhHJ61IEdTPxpk=; b=H6kM7NASE29Ho5AG7HXi
	eN6fV/NgNIn7FuHvQKlf76s4vgmdt0vV1od8IaCSlchtF1CA9LalF1Lc7ma6TLEs
	NjDNAm+3Z/BBXCi1tawyAs7o2oWJ9Y8P3IynuSJUs5XYA/igC4tUlTLyDE5Gpl49
	O7alHRoVrVWrBlnhDvVT6CU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ZjOF8WDyJVJc84V9sipfw9snsAyTFskcHZp3CPsiZDSDeE
	0658DGuQVkKToxZC+unfM3ThIvjqyD46vbfiEN1EV9Ns+lkUynR2rjmSvGwvAWL+
	X/WwC0WlJRhTSuKWRAPCLcDgnx+ek/0Woo84uq0FmEIzjGQi2rrPZmdsw30X8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64A073E2EF;
	Tue,  3 Sep 2013 22:46:23 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1401B3E2DF;
	Tue,  3 Sep 2013 22:46:20 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A7628744-14EA-11E3-9A6F-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233793>

Richard Hansen <rhansen@bbn.com> writes:

> The documentation contains a mix of the two spellings, so include both
> in the glossary so that a search for either will lead to the
> definition.
>
> Signed-off-by: Richard Hansen <rhansen@bbn.com>
> ---

I hate to say this after seeing you doing a thorough job in this
series, but because "tree-ish" and "commit-ish" are both made-up
words, I have a feeling that we are better off unifying to the
dashed form, which unfortunately is the other way around from what
your series does.

Patches 5, 6 and 7 are good clarifications.

>  Documentation/glossary-content.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index dba5062..0273095 100644
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

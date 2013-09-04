From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/7] documentation cleanups for <rev>^{<type>}
Date: Wed, 04 Sep 2013 15:27:26 -0700
Message-ID: <xmqq8uzckysx.fsf@gitster.dls.corp.google.com>
References: <xmqq1u55plqe.fsf@gitster.dls.corp.google.com>
	<1378321474-7125-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Thu Sep 05 00:27:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHLXy-0000ay-Ja
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 00:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758867Ab3IDW1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 18:27:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46940 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753825Ab3IDW13 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 18:27:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F6583F092;
	Wed,  4 Sep 2013 22:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i0HN16tRGkjAr/mMmgALrdmvnbA=; b=BCjxvF
	Ey8RuGDQWXkgNKQUTIEjwH8yW5XDfe2J8zmI4BT4bZHfvr94BtLYiPSjxbvviAy6
	4mdXXbHMD8N/wqrw89qZceoYfRLV6VpFJtr8P3rQVM/R5uRB6msY9HTrip2ajJ/k
	64XtLiGU2aDE0099X4xUvAlmA2g/mbMG09QAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b9XLWvyUovCBjDTnmFpud0SjQYz6raUV
	h1KTSVDZVEz6EycHb6HXg63xGO3S81x93oug+QiS/ZnuiJbTCIAgqnw09173LibE
	WXZdpLmApHRSECi0OJjc0JMsAAYVZNM0XF4xKE/XwT4yNCIowkAlKS7O5nVZLwEH
	Pp6D1lmZgug=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07B683F091;
	Wed,  4 Sep 2013 22:27:29 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F9123F08C;
	Wed,  4 Sep 2013 22:27:28 +0000 (UTC)
In-Reply-To: <1378321474-7125-1-git-send-email-rhansen@bbn.com> (Richard
	Hansen's message of "Wed, 4 Sep 2013 15:04:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2E6A7730-15B1-11E3-A356-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233881>

Richard Hansen <rhansen@bbn.com> writes:

> On 2013-09-03 18:46, Junio C Hamano wrote:
>> I hate to say this after seeing you doing a thorough job in this
>> series, but because "tree-ish" and "commit-ish" are both made-up
>> words, I have a feeling that we are better off unifying to the
>> dashed form, which unfortunately is the other way around from what
>> your series does.
>
> I thought you might say that so I held on to the commits that
> standardize on tree-ish and commit-ish in my local repo.  :)
>
> This series still says "tree-ish (also treeish)" and "commit-ish (also
> committish)" in gitglossary(7).  Would you like me to eliminate the
> "(also ...)"  part?
>
> I'm not 100% confident that these don't break translations, although
> it still builds and "make test" passes.

We will find out ;-)

> Changes since v2:
>   * standardize on 'tree-ish' instead of 'treeish'
>   * standardize on 'commit-ish' instead of 'committish'
>
> Richard Hansen (7):
>   glossary: mention 'treeish' as an alternative to 'tree-ish'
>   glossary: define commit-ish (a.k.a. committish)
>   use 'tree-ish' instead of 'treeish'
>   use 'commit-ish' instead of 'committish'
>   glossary: more precise definition of tree-ish (a.k.a. treeish)
>   revisions.txt: fix and clarify <rev>^{<type>}
>   glossary: fix and clarify the definition of 'ref'
>
>  Documentation/RelNotes/1.7.11.2.txt          |  2 +-
>  Documentation/howto/revert-branch-rebase.txt |  2 +-

I generally prefer not to touch historical documents but the change
in this series is small enough that I think it is OK.

Thanks, will queue.

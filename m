From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Mention "git blame" improvements in release notes
Date: Sat, 26 Apr 2014 10:28:37 -0700
Message-ID: <7vmwf8huey.fsf@alter.siamese.dyndns.org>
References: <1398470210-28746-1-git-send-email-dak@gnu.org>
	<1398470210-28746-2-git-send-email-dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Apr 26 19:27:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We6NP-0002Kf-Di
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 19:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbaDZR0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 13:26:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45420 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467AbaDZR0x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 13:26:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE44F79CAA;
	Sat, 26 Apr 2014 13:26:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=j+ACdVQJxzIpcdH1NExT7RG3EuM=; b=hRxbaqiR9a/6A/0Cc/s+
	BeaBojtPuHtFNnyN5DHKZ3oZaJ/oa3vf6BumjNiUGj4q6FzP5RgXWY00Vb98uaEn
	KQd6EhciHFgiOi/pFTpoDprt0eiinurqm8iJvuviHZzs2yextvCemI0NcsNxoeA2
	PZe5X6yhn0YRxNz0HHq+mDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Uwk3mnpcO9chgqRxS5g1nywQqYWudfkIow0LW6tY9hb2im
	Ife7EDtCmRmJs5c8FK64CIZob/XxTN6rPPq2YGlXZbm4X4LKWUk26c21LTgJG2yJ
	D11N9zv6GQM2eV7dghoTbbDapOOGuZDM5lLWJNdi7MsdbIhlgm8onu88/wOWs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE69F79CA9;
	Sat, 26 Apr 2014 13:26:52 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97EAA79CA7;
	Sat, 26 Apr 2014 13:26:50 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: F3C8123A-CD67-11E3-B4E8-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247165>

David Kastrup <dak@gnu.org> writes:

> Includes reasonably tasteful begging.

Thanks, but no thanks---I do not see it tasteful.

In any case, any large change that is not a regression fix (or a fix
to a code added since 1.9 series) is way too late for 2.0 at this
point, but I do look forward to reading the patch over, queuing to
my tree, cooking in 'next' and eventually having this in 2.1 or
later.

If you want help in a fundraising campaign, I can lend my name
(especially after this change settles and proves to be useful ;-),
but let's do that elsewhere. I do not want to do this in the release
notes (e.g., an entry in git-blame blog can mention it when it
touches the blame improvements).

This by the way touches another thing I have been wondering.
Perhaps I should stop having the top-level RelNotes as a symbolic
link, but keep it as a regular file, which I *copy* to its current
location in the commit that tags the release.  And then I start a
skeletal RelNotes at the top of the tree when the next cycle begins,
and new topics will build on top of that commit.

That way, this patch would have been against the top-level RelNotes,
applied as part of the topic, and when the topic is merged to
'master', it would make it less likely for me to forget about
mentioning it.

Thanks for working on the topic.

>
> Signed-off-by: David Kastrup <dak@gnu.org>
> ---
>  Documentation/RelNotes/2.0.0.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/RelNotes/2.0.0.txt b/Documentation/RelNotes/2.0.0.txt
> index ffd4899..27b23c3 100644
> --- a/Documentation/RelNotes/2.0.0.txt
> +++ b/Documentation/RelNotes/2.0.0.txt
> @@ -144,6 +144,12 @@ UI, Workflows & Features
>  
>  Performance, Internal Implementation, etc.
>  
> + * Significant parts of "git blame" have been reimplemented by David
> +   Kastrup <dak@gnu.org> for a vast gain in performance with complex
> +   histories and large files.  As working on free software is his sole
> +   source of income, please consider contributing to his remuneration
> +   if you find this useful.
> +
>   * The compilation options to port to AIX and to MSVC have been
>     updated.

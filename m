From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Add --oneline that is a synonym to "--pretty=oneline
 --abbrev-commit"
Date: Tue, 24 Feb 2009 09:38:16 -0800
Message-ID: <7vljrvhh13.fsf@gitster.siamese.dyndns.org>
References: <20090224185913.6117@nanako3.lavabit.com>
 <20090224185916.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 18:39:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc1G4-0006K6-9p
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 18:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759731AbZBXRiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 12:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759700AbZBXRiY
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 12:38:24 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50808 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759688AbZBXRiX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 12:38:23 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 889089C59A;
	Tue, 24 Feb 2009 12:38:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6F8489C596; Tue,
 24 Feb 2009 12:38:18 -0500 (EST)
In-Reply-To: <20090224185916.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Tue, 24 Feb 2009 18:59:16 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EE15CDE4-0299-11DE-AC8F-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111321>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> These two are often used together but are too long to type.
>
> Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
> ---
>  Documentation/pretty-options.txt |    4 ++++
>  revision.c                       |    4 ++++
>  2 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
> index 6596019..b0ea68a 100644
> --- a/Documentation/pretty-options.txt
> +++ b/Documentation/pretty-options.txt
> @@ -18,6 +18,10 @@ configuration (see linkgit:git-config[1]).
>  This should make "--pretty=oneline" a whole lot more readable for
>  people using 80-column terminals.
>  
> +--oneline::
> +	This is a shorthand for "--pretty=oneline --abbrev-commit"
> +	used together.
> +
>  --encoding[=<encoding>]::

The --pretty=oneline was one of the things I found that orthogonality
harmed usability in a big way.  Very nice.

I see Teemu already did bash completion for this series, and I'll take it
as an Aye.  Any volunteer who wants to add a few tests?

Thanks.

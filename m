From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Cleanup of unused symcache variable inside diff-lib.c
Date: Sun, 11 Jan 2009 21:39:37 -0800
Message-ID: <7v4p05krqe.fsf@gitster.siamese.dyndns.org>
References: <1231699002-5316-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Mon Jan 12 06:41:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMFXx-0000pP-0B
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 06:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbZALFjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 00:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbZALFjp
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 00:39:45 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34801 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695AbZALFjo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 00:39:44 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8C7908FD92;
	Mon, 12 Jan 2009 00:39:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D59F48FD90; Mon,
 12 Jan 2009 00:39:39 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 69698978-E06B-11DD-924C-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105292>

Kjetil Barvik <barvik@broadpark.no> writes:

> diff --git a/diff-lib.c b/diff-lib.c
> index ae96c64ca209f4df9008198e8a04b160bed618c7..e6d1d2b34147a13aadb5019e0c8336ef5f56ee39 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> ...
> @@ -344,8 +334,7 @@ static void do_oneway_diff(struct unpack_trees_options *o,
>  	struct cache_entry *idx,
>  	struct cache_entry *tree)
>  {
> -	struct oneway_unpack_data *cbdata = o->unpack_data;
> -	struct rev_info *revs = cbdata->revs;
> +	struct rev_info *revs = o->unpack_data;;

Thanks; I'll clean-up the extra semicolon and apply.

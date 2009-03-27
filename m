From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-send-pack.c: avoid empty structure
 initialization
Date: Thu, 26 Mar 2009 21:02:56 -0700
Message-ID: <7vfxgzipe7.fsf@gitster.siamese.dyndns.org>
References: <vllV2KFOw2fPeT48N4ZHBW8HPcTVqhWLjdDJnF8chb2m9lcTJFlnjPZc-WBSwqdoNvvZc5cQ0A4@cipher.nrlssc.navy.mil> <5dTED0fgBNPRxaQcq2Yx362_Ykx8_d294JWsQ989AjNLfL5kjzWRBnuVa1D9jLmvQzvhAD5NPfY@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Mar 27 05:05:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln3Js-0002ud-VB
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 05:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbZC0EDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 00:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbZC0EDH
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 00:03:07 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34546 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbZC0EDG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 00:03:06 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6C2B39A51;
	Fri, 27 Mar 2009 00:03:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 90A279A50; Fri,
 27 Mar 2009 00:02:58 -0400 (EDT)
In-Reply-To: <5dTED0fgBNPRxaQcq2Yx362_Ykx8_d294JWsQ989AjNLfL5kjzWRBnuVa1D9jLmvQzvhAD5NPfY@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Thu, 26 Mar 2009 21:37:53 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2B669ECE-1A84-11DE-B4A4-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114845>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> The IRIX6.5 MIPSpro Compiler doesn't like it.
>
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ...
> diff --git a/builtin-send-pack.c b/builtin-send-pack.c
> index 91c3651..d5a1c48 100644
> --- a/builtin-send-pack.c
> +++ b/builtin-send-pack.c
> @@ -10,8 +10,7 @@ static const char send_pack_usage[] =
>  "git send-pack [--all | --mirror] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
>  "  --all and explicit <ref> specification are mutually exclusive.";
>  
> -static struct send_pack_args args = {
> -};
> +static struct send_pack_args args;
>  
>  static int feed_object(const unsigned char *sha1, int fd, int negative)
>  {

Thanks.

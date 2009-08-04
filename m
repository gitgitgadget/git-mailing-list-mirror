From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: remove debug trace
Date: Tue, 04 Aug 2009 15:20:12 -0700
Message-ID: <7vbpmvfcgz.fsf@alter.siamese.dyndns.org>
References: <1249423054-3416-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, madcoder@debian.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 00:20:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYSMx-0007tl-Mp
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 00:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933442AbZHDWUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 18:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754867AbZHDWUU
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 18:20:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41424 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754503AbZHDWUU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 18:20:20 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1825A1DD38;
	Tue,  4 Aug 2009 18:20:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 75C691DD37; Tue,  4 Aug 2009
 18:20:14 -0400 (EDT)
In-Reply-To: <1249423054-3416-1-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Tue\,  4 Aug 2009 21\:57\:34 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FED2B33E-8144-11DE-AD4C-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124825>

Erik Faye-Lund <kusmabite@googlemail.com> writes:

> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
>
> This isn't really a big deal, the print just annoyed me slightly.

Nobody noticed for the past 9 months?  Interesting.

Thanks.

>
>  git-send-email.perl |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index d508f83..0700d80 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -450,7 +450,6 @@ sub check_file_rev_conflict($) {
>  	try {
>  		$repo->command('rev-parse', '--verify', '--quiet', $f);
>  		if (defined($format_patch)) {
> -			print "foo\n";
>  			return $format_patch;
>  		}
>  		die(<<EOF);
> -- 
> 1.6.4

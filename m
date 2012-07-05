From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/12] git-remote-mediawiki (t9361): test
 git-remote-mediawiki pull and push
Date: Thu, 05 Jul 2012 16:14:09 -0700
Message-ID: <7vipe1pzr2.fsf@alter.siamese.dyndns.org>
References: <1341473772-28023-1-git-send-email-Matthieu.Moy@imag.fr>
 <1341473772-28023-5-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Simon CATHEBRAS <Simon.Cathebras@ensimag.imag.fr>,
	Julien KHAYAT <Julien.Khayat@ensimag.imag.fr>,
	Simon Perrat <simon.perrat@ensimag.imag.fr>,
	Charles ROUSSEL <Charles.Roussel@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jul 06 01:14:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmvFZ-0000In-Vy
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 01:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933404Ab2GEXON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 19:14:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49163 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933402Ab2GEXOM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 19:14:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D0D39B1B;
	Thu,  5 Jul 2012 19:14:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yZKxUgTpbU+DUF43GAewA29HWNE=; b=abGdvv
	Ej0N6cqGjmaqxnI8EYTrnr7mIYP2RbNP2WbAxqiYjB0exypE/MIyODJ3sT277N3c
	k8ih+EmO1LrS9vnpwwZtJnwPYZg+WlEmDp+BuNkbJz+0nb+iHQmSFOJ47zsaYQRa
	PmO9LR3vQRLR+L16eHLJ840Lcg45LZp6MpzuU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iysKxWTtavMZUBWNA4DXh2RGccqjNcYD
	2O3jXgFijHKtPQbcEkZRiKz/BC9lJel1dWT+COx5KSPle8CtiPseAKRF3RfqsUDp
	bDOOMm4dXDng9KxHX2a3jRH2GOvLztYdEAw5O/baOOIfd59mUL4IVXLK4wR+HT14
	gYzUgMdyxak=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03F029B1A;
	Thu,  5 Jul 2012 19:14:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8167B9B19; Thu,  5 Jul 2012
 19:14:11 -0400 (EDT)
In-Reply-To: <1341473772-28023-5-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Thu, 5 Jul 2012 09:36:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 214B5D62-C6F7-11E1-AD9C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201077>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> From: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
>
> This patch provides a set of tests for the pull and push fonctionnality
> of git-remote-mediawiki. The actual tests are kept in a separate function
> to allow further tests to re-run the same set of commands with different
> push and pull strategies.
>
> Signed-off-by: Simon CATHEBRAS <Simon.Cathebras@ensimag.imag.fr>
> Signed-off-by: Julien KHAYAT <Julien.Khayat@ensimag.imag.fr>
> Signed-off-by: Simon Perrat <simon.perrat@ensimag.imag.fr>
> Signed-off-by: Charles ROUSSEL <Charles.Roussel@ensimag.imag.fr>
> Signed-off-by: Guillaume SASDY <Guillaume.Sasdy@ensimag.imag.fr>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  contrib/mw-to-git/t/push-pull-tests.sh           | 144 +++++++++++++++++++++++
>  contrib/mw-to-git/t/t9361-mw-to-git-push-pull.sh |  24 ++++
>  2 files changed, 168 insertions(+)
>  create mode 100644 contrib/mw-to-git/t/push-pull-tests.sh
>  create mode 100755 contrib/mw-to-git/t/t9361-mw-to-git-push-pull.sh
>
> diff --git a/contrib/mw-to-git/t/push-pull-tests.sh b/contrib/mw-to-git/t/push-pull-tests.sh
> new file mode 100644
> index 0000000..b9e38dc
> --- /dev/null
> +++ b/contrib/mw-to-git/t/push-pull-tests.sh
> @@ -0,0 +1,144 @@
> +test_push_pull () {
> +
> +	test_expect_success 'Git pull works after adding a new wiki page' '
> +		wiki_reset &&
> +	

Trailing whitespace

> +		git clone mediawiki::'"$WIKI_URL"' mw_dir_1 &&
> +		wiki_editpage Foo "page created after the git clone" false &&
> +	

Trailing whitespace

There are many others, 16 in total, I think.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: add options --single-branch and --branch to
 "git clone"
Date: Wed, 28 Nov 2012 10:57:24 -0800
Message-ID: <7vfw3tv9m3.fsf@alter.siamese.dyndns.org>
References: <1354127222-5569-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 19:57:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdmpK-0001PW-FQ
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 19:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755760Ab2K1S51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 13:57:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57124 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754448Ab2K1S50 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 13:57:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44B978D41;
	Wed, 28 Nov 2012 13:57:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TD7ynJczfKE2ECZvd4oWvtIjNKs=; b=MaJbFH
	pep9C+rCAu0BBUe4r4GU40p9g14LyfF4Bdo6t8W1yBuhPbMR9l/oNvkN+0qDEbHv
	RkTU4UO8Py5VFpNiBL9/mUonS8yGH1UNoCKmdFW3TCzLP5L063Ju2T1j4rYIkWSj
	bXRVmdzRcHpLD5ncPy0SGAd9dQAQpflXM6Rpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZkUmZQ1FqDbE3kiA6RF66noJp3PWr6Zj
	osBtq1FLZNiLWjfZOXC4NYEnUvMapyM3y1EuDAVDHMFEb5C9HRx7Xx8PAJzbfjja
	CROheRQFhDbJseTdi5a4JuMjaWsu+LPQSKyYJHr4iKKNkBNDDrce/nwN0EL3WNxZ
	/ih2pl7URfY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 327898D40;
	Wed, 28 Nov 2012 13:57:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A7D078D3F; Wed, 28 Nov 2012
 13:57:25 -0500 (EST)
In-Reply-To: <1354127222-5569-1-git-send-email-ralf.thielow@gmail.com> (Ralf
 Thielow's message of "Wed, 28 Nov 2012 19:27:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 72FDE090-398D-11E2-B1B2-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210759>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 48c3abd..cda095d 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -989,6 +989,8 @@ _git_clone ()
>  			--upload-pack
>  			--template=
>  			--depth
> +			--single-branch
> +			--branch
>  			"

Hmph.... OK, will queue.

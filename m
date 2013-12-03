From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improvements to git-archive tests and add_submodule_odb()
Date: Tue, 03 Dec 2013 09:52:49 -0800
Message-ID: <xmqqd2ldq0su.fsf@gitster.dls.corp.google.com>
References: <C74C17E7-0780-4FE1-B916-D1A444F3B592@mac.com>
	<6D370472-81BB-4249-9ADA-1C906C26D88F@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Nick Townsend <nick.townsend@mac.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 18:53:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnu9g-00050N-11
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 18:53:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754771Ab3LCRwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 12:52:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33045 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754264Ab3LCRww (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 12:52:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B425453DA0;
	Tue,  3 Dec 2013 12:52:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0/TIqvRM78JvWU/F3eT/uow4G9U=; b=ryW6ih
	NVjZpNExonoOtJauADAXcpf+AZD6rZWoPsSXw9QfnVYNLS1S58psvf25JOONeBCr
	Ddrzz0h36HUA9dMS6vtUg9UWjcOQA+I73bmckbA7Dx/klVicbY/XaSh1hM0tLhxX
	bHADiQVe8Qhh/58TKAxah46p2D3SxxoMwjw/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ITwdmpUMJfKnM/v0OEqxQ8iNj07qzCYv
	2YFm800IkcGO5KcmyzOPlAUOgEs8azGD3b6ej5J/rEIe7MerO59IItt9fdXYQaRl
	zi566uoxZCsh+4uJrclhpBAcKVFqB900jrU2SW4c4ub30OupbwcH0OesMxHcopoj
	q92RbLDuR5M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1F8C53D9F;
	Tue,  3 Dec 2013 12:52:51 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA6BC53D9E;
	Tue,  3 Dec 2013 12:52:50 -0500 (EST)
In-Reply-To: <6D370472-81BB-4249-9ADA-1C906C26D88F@mac.com> (Nick Townsend's
	message of "Mon, 02 Dec 2013 16:14:37 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BA513DDC-5C43-11E3-9761-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238703>

Nick Townsend <nick.townsend@mac.com> writes:

> From: Nick Townsend <nick.townsend@mac.com>
> Date: Mon, 25 Nov 2013 15:31:09 -0800
> Subject: [PATCH 1/2] submodule: add_submodule_odb() usability

Please do not add these; instead, drop From/Date (because we can see
them in the mail header from your MUA) and replace the mail header
Subject with this one.

The body of the patch looks OK to me (provided that we'd want to
promote use of that function).

Thanks.

> Although add_submodule_odb() is documented as being
> externally usable, it is declared static and also
> has incorrect documentation.  This commit fixes those
> and makes no changes to existing code using them.
> All tests still pass.
>
> Improved wording based on Rene Scharfe feedback
>
> Signed-off-by: Nick Townsend <nick.townsend@mac.com>
> ---
>  Documentation/technical/api-ref-iteration.txt | 4 ++--
>  submodule.c                                   | 2 +-
>  submodule.h                                   | 1 +
>  3 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/technical/api-ref-iteration.txt b/Documentation/technical/api-ref-iteration.txt
> index aa1c50f..02adfd4 100644
> --- a/Documentation/technical/api-ref-iteration.txt
> +++ b/Documentation/technical/api-ref-iteration.txt
> @@ -50,10 +50,10 @@ submodules object database. You can do this by a code-snippet like
>  this:
>  
>  	const char *path = "path/to/submodule"
> -	if (!add_submodule_odb(path))
> +	if (add_submodule_odb(path))
>  		die("Error submodule '%s' not populated.", path);
>  
> -`add_submodule_odb()` will return an non-zero value on success. If you
> +`add_submodule_odb()` will return zero on success. If you
>  do not do this you will get an error for each ref that it does not point
>  to a valid object.
>  
> diff --git a/submodule.c b/submodule.c
> index 1905d75..1ea46be 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -143,7 +143,7 @@ void stage_updated_gitmodules(void)
>  		die(_("staging updated .gitmodules failed"));
>  }
>  
> -static int add_submodule_odb(const char *path)
> +int add_submodule_odb(const char *path)
>  {
>  	struct strbuf objects_directory = STRBUF_INIT;
>  	struct alternate_object_database *alt_odb;
> diff --git a/submodule.h b/submodule.h
> index 7beec48..3e3cdca 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -41,5 +41,6 @@ int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_nam
>  		struct string_list *needs_pushing);
>  int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name);
>  void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
> +int add_submodule_odb(const char *path);
>  
>  #endif

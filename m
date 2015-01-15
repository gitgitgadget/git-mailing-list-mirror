From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Documentation/git-init.txt: minor style and synopsis fixes
Date: Thu, 15 Jan 2015 11:43:11 -0800
Message-ID: <xmqq61c77ru8.fsf@gitster.dls.corp.google.com>
References: <1421345774-4756-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 20:43:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBqK6-0003Xa-Kd
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 20:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbbAOTnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 14:43:14 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61471 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751959AbbAOTnN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 14:43:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 082D62EA97;
	Thu, 15 Jan 2015 14:43:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5q4mx/ByuPQuKksCIttqFeB/OSY=; b=xn9S5d
	MXHgf2MeZAa2ufgSC5q3nUJsbD2wisuXun1dLWTRaUyNeQVJP5EPrjuiC8Ceu1Xx
	JthJyyhA/4sJrgXkRbA5iRDfAFKe1VUNprIvoSWWTfXbG6GVjRU/TvvQosS+RI6F
	MyFUyG8NJgadE92CEa8AieATBfv6Vd1+yrI3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QW4mNVYtRmulugTmV2c9+WlatdEmjNQr
	fRNsMlMCAIPf6PoMX9LHdJJfzqGLW7TOOGCKd8uGJ7w2BAgbWoZAjPck/WeuDqnL
	C3PdV/Ki3Y8aY/hyhRN2jJPytNLwZdy4iU4qw4JZBjsc0+Jb/vCUpsThjYUjEVJ/
	drEAwkemte0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F17572EA93;
	Thu, 15 Jan 2015 14:43:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6C93E2EA92;
	Thu, 15 Jan 2015 14:43:12 -0500 (EST)
In-Reply-To: <1421345774-4756-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Fri, 16 Jan 2015 00:16:14 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BD918FD2-9CEE-11E4-A94C-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262505>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> Signed-off-by: 0xAX <kuleshovmail@gmail.com>

Hmmmm.

> @@ -50,12 +50,12 @@ Only print error and warning messages; all other
> output will be suppressed.

Linewrapped?

I could apply it after fixing these hunk header lines, but I'd
prefer not to, as we wouldn't know where _else_ the mail transport
corrupted the patch in a way that "git apply" would not notice.

>  Create a bare repository. If GIT_DIR environment is not set, it is set to the
>  current working directory.
>  
> ---template=<template_directory>::
> +--template=<template-directory>::
>  
>  Specify the directory from which templates will be used.  (See the "TEMPLATE
>  DIRECTORY" section below.)
>  
> ---separate-git-dir=<git dir>::
> +--separate-git-dir=<git-dir>::
>  
>  Instead of initializing the repository as a directory to either `$GIT_DIR` or
>  `./.git/`, create a text file there containing the path to the actual
> @@ -108,7 +108,7 @@ By default, the configuration flag
> receive.denyNonFastForwards` is enabled
>  in shared repositories, so that you cannot force a non fast-forwarding push
>  into it.
>  
> -If you provide a 'directory', the command is run inside it. If this directory
> +If you provide a <directory>, the command is run inside it. If this directory
>  does not exist, it will be created.
>  
>  --

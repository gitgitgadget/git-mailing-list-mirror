From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gittutorial: fix output of 'git status'
Date: Thu, 13 Nov 2014 08:38:54 -0800
Message-ID: <xmqqppcr2gyp.fsf@gitster.dls.corp.google.com>
References: <1638160691.207203.1415866403277.JavaMail.ngmail@webmail23.arcor-online.net>
	<1415875207-5992-1-git-send-email-stefan.naewe@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, <th.acker@arcor.de>
To: <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 17:39:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoxQE-0002AB-O0
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 17:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933349AbaKMQi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 11:38:58 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60765 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932955AbaKMQi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 11:38:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E3A41C140;
	Thu, 13 Nov 2014 11:38:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7UT2sgTjHJ9M2GZf+xWDIbibFyA=; b=ghpBH/
	+El40ZJRxeL3gibcw2bqEVxFsGCa9tx5yBPMRwF33SWZFW1K+fyvnS/nq6wn5Kk5
	DYq/sPNH4jjEaCk1EPaGbKq3JPXzKbbK9IjmfvJL8qtW9cQIVDiH80dxb0T1YrLH
	+xw9kAHbSFzWuOZainK3gdGHdRx7JycYW/QD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rl91s1SQa3QPipo6X49y4BRiz0INMRQG
	D/TA78ioBg3VcgoWmYyBJtG3qZ3AtawT9BCv0EAsil9shzIIF6tQ1b0kFqX8nvMZ
	/HsyPmz9ksUigQpqHXULJh0pjaPN303tdDmo2r327PAKZ1Prq+XrsSkhJF1RpOSK
	MtTfttnzVPY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 25A781C13E;
	Thu, 13 Nov 2014 11:38:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A72C1C13C;
	Thu, 13 Nov 2014 11:38:55 -0500 (EST)
In-Reply-To: <1415875207-5992-1-git-send-email-stefan.naewe@atlas-elektronik.com>
	(stefan naewe's message of "Thu, 13 Nov 2014 10:40:07 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8F2BA172-6B53-11E4-A4F3-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<stefan.naewe@atlas-elektronik.com> writes:

> From: Stefan Naewe <stefan.naewe@gmail.com>
>
> 'git status' doesn't output leading '#'s these days.
>
> Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
> ---

Thanks, will queue.

>  Documentation/gittutorial-2.txt | 23 ++++++++++++-----------
>  Documentation/gittutorial.txt   | 17 +++++++++--------
>  2 files changed, 21 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.txt
> index 3109ea8..1901af7 100644
> --- a/Documentation/gittutorial-2.txt
> +++ b/Documentation/gittutorial-2.txt
> @@ -368,17 +368,18 @@ situation:
>  
>  ------------------------------------------------
>  $ git status
> -# On branch master
> -# Changes to be committed:
> -#   (use "git reset HEAD <file>..." to unstage)
> -#
> -#       new file: closing.txt
> -#
> -# Changes not staged for commit:
> -#   (use "git add <file>..." to update what will be committed)
> -#
> -#       modified: file.txt
> -#
> +On branch master
> +Changes to be committed:
> +  (use "git reset HEAD <file>..." to unstage)
> +
> +        new file:   closing.txt
> +
> +Changes not staged for commit:
> +  (use "git add <file>..." to update what will be committed)
> +  (use "git checkout -- <file>..." to discard changes in working directory)
> +
> +        modified:   file.txt
> +
>  ------------------------------------------------
>  
>  Since the current state of closing.txt is cached in the index file,
> diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
> index 8262196..8715244 100644
> --- a/Documentation/gittutorial.txt
> +++ b/Documentation/gittutorial.txt
> @@ -107,14 +107,15 @@ summary of the situation with 'git status':
>  
>  ------------------------------------------------
>  $ git status
> -# On branch master
> -# Changes to be committed:
> -#   (use "git reset HEAD <file>..." to unstage)
> -#
> -#	modified:   file1
> -#	modified:   file2
> -#	modified:   file3
> -#
> +On branch master
> +Changes to be committed:
> +Your branch is up-to-date with 'origin/master'.
> +  (use "git reset HEAD <file>..." to unstage)
> +
> +        modified:   file1
> +        modified:   file2
> +        modified:   file3
> +
>  ------------------------------------------------
>  
>  If you need to make any further adjustments, do so now, and then add any

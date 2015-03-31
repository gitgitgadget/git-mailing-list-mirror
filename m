From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] enter_repo(): fix docs to match code
Date: Tue, 31 Mar 2015 10:35:56 -0700
Message-ID: <xmqq4mp1rrwj.fsf@gitster.dls.corp.google.com>
References: <vpqk2xykaiu.fsf@anie.imag.fr>
	<1427809167-21711-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 19:36:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd059-0004MY-31
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 19:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231AbbCaRgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 13:36:00 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51643 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751562AbbCaRf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 13:35:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5EE73437F1;
	Tue, 31 Mar 2015 13:35:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0bAUVd09eIRzuOMZVrVOQrJn+j8=; b=rLqFzX
	fLUsya/QwoYpEya6+ToSf/KIJdn3TpQOLipIBJMCbWGBY1PDa9W7ElSXEl/J37i5
	b0F0gJikXwX+HiF1rzmfVnyje9nRPcqt/eDTE9pU0rIvINrrFId+WE4qXC2cS+tI
	1FaMI9WEzyThmE62urQ5sSVtCcRl4FPlUTL/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QvjoH9ksmjktCYF2ALvETPHzNMqEfRZG
	QiIUtttiuw+dg9mBtivbsAcEej5LYslM4B7IatrckNb8o3UVLagYFtvjWrb1SGmP
	XZdrRIKKQEOPsA+qcvebByz8DSjTKM0S2VC2BGlUn4LW5rrUy9HyGKiX+HbBQVPa
	pmNe6IsySKM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 56651437F0;
	Tue, 31 Mar 2015 13:35:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D1086437ED;
	Tue, 31 Mar 2015 13:35:57 -0400 (EDT)
In-Reply-To: <1427809167-21711-1-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Tue, 31 Mar 2015 21:39:27 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 63FC6B4A-D7CC-11E4-B1AD-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266535>

Paul Tan <pyokagan@gmail.com> writes:

> On Mon, Mar 30, 2015 at 07:44:08AM -0400, Jeff King wrote:
>> Yes, this was adjusted in b3256eb (standardize and improve lookup rules
>> for external local repos, 2012-02-02), but I failed to update the
>> comment.
>> 
>> Your patch is certainly an improvement, but I think there are more
>> inaccuracies in the comment caused by that commit. Maybe squash this on
>> top:
>
> Thanks for catching.
>
> I've squashed the patches and rewrote the commit message.
>
> -->8--
>
> In b3256eb (standardize and improve lookup rules for external local
> repos), enter_repo() was modified to use a different precedence ordering
> of suffixes for DWIM of the repository path, and to ensure that the
> repository path is actually valid instead of just testing for existence.
> However, the documentation was not modified to reflect these changes.
> As such, fix the documentation to match the code.
>
> Documentation contributed by Jeff King.
>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---

It appears to me that Peff's "squash" is nullifying everything you
did, so a more truthful attribution might be

	From: Jeff King <peff@peff.net>

	commit log message

	S-o-b: Jeff
        S-o-b: Paul Tan

Thanks.

>  path.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/path.c b/path.c
> index e608993..595da81 100644
> --- a/path.c
> +++ b/path.c
> @@ -303,14 +303,9 @@ return_null:
>   * (3) "relative/path" to mean cwd relative directory; or
>   * (4) "/absolute/path" to mean absolute directory.
>   *
> - * Unless "strict" is given, we try access() for existence of "%s.git/.git",
> - * "%s/.git", "%s.git", "%s" in this order.  The first one that exists is
> - * what we try.
> - *
> - * Second, we try chdir() to that.  Upon failure, we return NULL.
> - *
> - * Then, we try if the current directory is a valid git repository.
> - * Upon failure, we return NULL.
> + * Unless "strict" is given, we check "%s/.git", "%s", "%s.git/.git", "%s.git"
> + * in this order. We select the first one that is a valid git repository, and
> + * chdir() to it. If none match, or we fail to chdir, we return NULL.
>   *
>   * If all goes well, we return the directory we used to chdir() (but
>   * before ~user is expanded), avoiding getcwd() resolving symbolic

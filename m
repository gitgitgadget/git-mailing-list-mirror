From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Documentation: make git-sh-setup docs less scary
Date: Tue, 20 Dec 2011 11:20:37 -0800
Message-ID: <7v1urzkq2i.fsf@alter.siamese.dyndns.org>
References: <c53feb0de8006c205fd26c2c07dcd78bd86b6c24.1324378986.git.trast@student.ethz.ch> <c8867738c264a76f9662080b64e00615ec1aa28f.1324378986.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Dec 20 20:20:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rd5F4-0004RT-LE
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 20:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694Ab1LTTUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Dec 2011 14:20:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57593 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752376Ab1LTTUl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 14:20:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 410047BA2;
	Tue, 20 Dec 2011 14:20:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=umjAqmf9kIh+ykHnUI0bY8pvB0o=; b=U+yR9a
	Q1XEO2esYIJ8c5kCIZ+e2hPkZ/5fk+A3StLy+eo7R28MrIvhv/yky62ZlK4R/Cl4
	e82I2G01PKDcgOtEjg489BL5oVPb6WbrB0zZ8eJ6Eeg+ewCzaN5TUq+CGbBMWwQA
	xdV+PleShBU2YQEBIZNoEin0sjhMIf4C0iPWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=McvGJL+gPop6acIY3KzVRITK04lEyuE0
	axMCGQ77GQHJSaeTTJCkhe9HKAo+tuf3gJZ5TpW1yd0wbvKAoM5CTNKJ1pSiceYa
	QgEL7c66w9/yaf4Z6tE4pePzqsCRPwveiaoebVk+h4wRrMTvAPSIJHsT9g9giLLV
	wOAuBAMPI2E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38F0E7BA1;
	Tue, 20 Dec 2011 14:20:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 924877BA0; Tue, 20 Dec 2011
 14:20:39 -0500 (EST)
In-Reply-To: <c8867738c264a76f9662080b64e00615ec1aa28f.1324378986.git.trast@student.ethz.ch> (Thomas Rast's message of "Tue, 20 Dec 2011 12:09:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B3BA5AD0-2B3F-11E1-A7DB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187517>

Thomas Rast <trast@student.ethz.ch> writes:

> At least one IRC user was scared away by the introductory "This is not
> a command the end user would want to run.  Ever." to the point of not
> reading on.

You would need to say what that IRC user needed to find out. Depending on
that, letting the user know that there is no point reading on early and
not waste his or her time may be a good thing. That was what the paragraph
was designed for. IOW, it is not to "scare" away, but to allow the users
to decide if they are intended audiences.

The reworded version does avoid sounding scary, but loses the "this
document is for people who want to write new or understand existing
Porcelain scripts", which is a documentation regression.

> Reword it in a more matter-of-fact way that does not intentionally try
> to scare the user away.  Since 46bac90 (Do not install shell libraries
> executable, 2010-01-31) it is not executable anyway, so the end user
> would get
>
>   $ git sh-setup
>   fatal: cannot exec 'git-sh-setup': Permission denied
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>  Documentation/git-sh-setup.txt |   11 ++++-------
>  1 files changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
> index bbfefca..612fb50 100644
> --- a/Documentation/git-sh-setup.txt
> +++ b/Documentation/git-sh-setup.txt
> @@ -13,13 +13,10 @@ SYNOPSIS
>  DESCRIPTION
>  -----------
>  
> -This is not a command the end user would want to run.  Ever.
> -This documentation is meant for people who are studying the
> -Porcelain-ish scripts and/or are writing new ones.
> -
> -The 'git sh-setup' scriptlet is designed to be sourced (using
> -`.`) by other shell scripts to set up some variables pointing at
> -the normal git directories and a few helper shell functions.
> +This command cannot be run by the end user.  Shell scripts can
> +source it (using `.` as indicated above) to set up some variables
> +pointing at the normal git directories and a few helper shell
> +functions.
>  
>  Before sourcing it, your script should set up a few variables;
>  `USAGE` (and `LONG_USAGE`, if any) is used to define message

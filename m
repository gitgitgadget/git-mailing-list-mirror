From: Armin Kunaschik <megabreit@googlemail.com>
Subject: Re: t4204-patch-id failures
Date: Tue, 24 May 2016 00:56:18 +0200
Message-ID: <CALR6jEgjcAGjLBbHuB+sG24Xwp9AH1i8SbtSdQoLyFcKmwAAcA@mail.gmail.com>
References: <CALR6jEgf_FiGWs=45+n8uzKEiXU7yKDsP+CjOUAWu1CnUXZbPw@mail.gmail.com>
	<xmqqiny48ps8.fsf@gitster.mtv.corp.google.com>
	<xmqqbn3w76rn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 00:56:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4yls-0002UT-Nb
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 00:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbcEWW4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 18:56:20 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:35281 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbcEWW4T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 18:56:19 -0400
Received: by mail-yw0-f180.google.com with SMTP id o16so67944215ywd.2
        for <git@vger.kernel.org>; Mon, 23 May 2016 15:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=q0FjCbylmHznhsC+5weznfFO5cb3Wx99Qg1vUMm71KE=;
        b=y0bBdY6yjgh+wF2QuNW3b7TB+vFrTeyONLhz4t3AvhJKcn6uNz0Iq7uPWm/1/XPP33
         NHqU0+TyQrQyxWAmbgm5qJlOp0I2iNyUUsr1wXgADVXXyTGs57hpG1/CyXFWpUcKujw2
         taT36502UETIG9bG+pOjCxxi/64REjjYoACVBJcrTrVJA14BWa+DtA8P/7nG5VrkojAt
         plM0k7/ouE07dpr3fqI0kK5nVsKSGF7exHlHcfrfHWibnV/bv83rnW2on6OFZIIsX4gV
         B1xiWKAKhulp9HRbDXyRqnh+3HJX8fB8Cm+IRSvNpeKEK4CnNwP47a6Uv27B9gbQh9EW
         YUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=q0FjCbylmHznhsC+5weznfFO5cb3Wx99Qg1vUMm71KE=;
        b=ZUwN4J6AQbRFEpuEO5hsTtDncOhly4SOwblHtzbA/9pwKxDtXQV6XPefH7kWjmRYZW
         ucaWvn8uUAhnT6VDs5fL/iBl5Q3Boy/+oVj+7oMnZDpzniYguLJ/P6A93bkfsCCn/TnX
         PhGvM9vtyXvt7/YRVYYAAjGyHO6+Ex8vX+DM7iUXrFbqNC9+AQwEe0fz23RO8u6rAQsF
         ieL9dVKrhnX5UYkyB6i73IkSUPg269/KQ28bK0yLXZWGX1jDO2ioJ1AhvrbUSKG9yIzr
         VqRYhV0mSJ/4z+1V79+UuMGjC27TaNLt2aq8PcuNVpnC/g/grRix5+NVY7IYxiVmPe/g
         UOpw==
X-Gm-Message-State: ALyK8tIzb4XrqE9hecXYYMdnCPZmAKEgxyqjDpQ7baLKkRfmUpjh2kqNIno7bLIyIuPrh47r31hIa9XvSj2Nuw==
X-Received: by 10.129.92.4 with SMTP id q4mr773610ywb.156.1464044178982; Mon,
 23 May 2016 15:56:18 -0700 (PDT)
Received: by 10.129.45.132 with HTTP; Mon, 23 May 2016 15:56:18 -0700 (PDT)
In-Reply-To: <xmqqbn3w76rn.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295406>

On Tue, May 24, 2016 at 12:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:

> Having said all that, this illustrates the root cause of different
> behaviours better, but it is harder to reason about than simply
> changing the variable name used in this shell function.  POSIX reads
> a bit fuzzy to me around here:
>
>     ... each command of a multi-command pipeline is in a subshell
>     environment; as an extension, however, any or all commands in a
>     pipeline may be executed in the current environment. All other
>     commands shall be executed in the current shell environment.
>
> That essentially says nothing useful; it does not guarantee that
> each command on a pipeline runs in its own subshell environment, and
> a portable script must be prepared to see some of them run in the
> current shell environment.

Writing portable shell scripts sometimes is quite a mess :-)

> So let's do this instead:
>
> -- >8 --
> Subject: t4204: do not let $name variable clobbered
>
> test_patch_id_file_order shell function uses $name variable to hold
> one filename, and calls another shell function calc_patch_id as a
> downstream of one pipeline.  The called function, however, also uses
> the same $name variable.  With a shell implementation that runs the
> callee in the current shell environment, the caller's $name would
> be clobbered by the callee's use of the same variable.
>
> This hasn't been an issue with dash and bash.  ksh93 reveals the
> breakage in the test script.

Maybe add ksh88 too, just to be "feature" complete.

> Fix it by using a distinct variable name in the callee.

Agreed.

> Reported-by: Armin Kunaschik <megabreit@googlemail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

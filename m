From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule helper: accept '.' for repositories with no submodules
Date: Tue, 22 Mar 2016 15:10:25 -0700
Message-ID: <CAGZ79kYhK1dDQsxjRwhArXMi-0Gbd8ciYwdFnerT4fjvpthWCg@mail.gmail.com>
References: <1458669579-32160-1-git-send-email-sbeller@google.com>
	<xmqqy49agx98.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaMa3CyJ-Y9Xn9QShzTUGythos+pmKZXQ7m-2c0bF0u9A@mail.gmail.com>
	<xmqqoaa6gtuu.fsf@gitster.mtv.corp.google.com>
	<CAGZ79ka=EJ-L+Zaqh0kWUdjmyUva3fEcbwJn18uxshe3R5ABBQ@mail.gmail.com>
	<xmqqtwjyfb0s.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYNQ46Yett8xwtPL8Mi1TkitB1kuWbQDsR6bg-5dxckNA@mail.gmail.com>
	<xmqqpoumf9uy.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Per Cederqvist <cederp@opera.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 23:10:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiUVS-0003oq-Te
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 23:10:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbcCVWK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 18:10:28 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:36302 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326AbcCVWK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 18:10:26 -0400
Received: by mail-io0-f170.google.com with SMTP id 124so750719iov.3
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 15:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=wkM5jC7fzHARMux8TyXUWNdIkPEasUxF6Unv2+YUh04=;
        b=H1bePX8Ga1REklrvsLU1gRIcDP6A6mqkwkr8eO4/bOyidd4eubP6QQGJS/t5zOMf1J
         F/7YcKwDTLe079GZjaihfrz2fMJeZn6PNNn2Gpt/oOz3+idRguK1UpEDiOujjp+/lGii
         KkHQEUpCkeB50L9bWl5PyETEjIZnUQzJ54E0RXvz6+cKdRF7Olq1RqD7SVbDpt+ImRf5
         a8OaRlHfZjQidGsx79njOrp8UDtdbdpQ8LMYdhMq+Z3d2yXlX5+HtggEqR51kwjsQg8Y
         Xsl3GK7V1UwQUq71vXhe2i2TU2MEb34gK8Ix9OrJ1EeLoRop2S0K/S2b/WhsZG+WDaLJ
         aZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=wkM5jC7fzHARMux8TyXUWNdIkPEasUxF6Unv2+YUh04=;
        b=Rms0pPX3DALKJoakqlNdWGjwURdIg8aw6NzCyG0HMYtPXQ5RmscRfMjilubpGMNmKz
         tqu4z0EXIAR4VHT+9Mes1aGquKWImDG+jrTXQ/iIN/3f+a5KgyTjRNVdGYdBbG7Fs8Gl
         N/UfoSxbJZTzsSKRgz+syGwrr1RpKACUo1MGc4IEjYYk6YiJsJ3UFC2dbYGVmgbFm/B7
         rFsnUVzqpYRH32Yigix1PvSTvJcebKF/uaHqCDnnZ/TpChuGPHEwWHPN91Iqi4ykrNwP
         Dis7EE+SWDiUCJOnx9PwHaSScbx3kErt8z15B7ha0g6cEEc9dFtKvuGI7h0mglyc3xRf
         HW2A==
X-Gm-Message-State: AD7BkJLgK3TdNhlBiGVMl5PpvFPo0S3fSV3J11bSTgoG8r1Gh2IaiCKus4/gh+3bI77qXOSk/FrSOC8KSfZ6QwlI
X-Received: by 10.107.131.163 with SMTP id n35mr78112ioi.110.1458684625654;
 Tue, 22 Mar 2016 15:10:25 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Tue, 22 Mar 2016 15:10:25 -0700 (PDT)
In-Reply-To: <xmqqpoumf9uy.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289575>

On Tue, Mar 22, 2016 at 3:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> I was under the impression that we do not want to have this bugfix
>> (at least long term) and then I tried to come up with an idea,
>> which is both:
>> * correct in this case
>> * and catches the git submodule init -- 'COPYIN*' case as failure
>
> Satisfying both has to be impossible, I am afraid, so coming up with
> an idea to do so may be futile.
>
> If "git submodule $subcmd -- 'COPYIN*'" must fail (which I think is
> a good property to have), then "git submodule $subcmd -- ." must
> fail if there is no submodule in the repository, I would think, if
> we want to be consistent.  Both are complaining not just because
> there is no path that match the given pathspec, but because there is
> no submodule that match the given pathspec.
>
> That is why I said I was in favour of giving some _other_ way, other
> than "this is guaranteed to match some submodule" pathspec (which
> fundamentally does not exist, because there are projects that do not
> have any submodule in them), as a suggestion for "deinit all"
> safety.
>
> A slight tangent.
>
> We have --error-unmatch in ls-files to detect pathspec that did not
> hit anything, and our Porcelain commands treat a pathspec that does
> not hit anything as an error, but there probably need to be
> "--unmatch-ok" option?  I.e.
>
>         $ git add 'A*'
>         fatal: pathspec 'A*' did not match any files
>         $ git add --unmatch-ok 'A*'
>         ... nothing is added but we do not get an error ...
>
> Then the interaction may go like this:
>
>         $ git submodule deinit
>         You need to limit submodules to deinit with some pathspec
>         $ git submodule deinit .
>         fatal: pathspec '.' did not match any submodule
>         $ git submodule deinit --unmatch-ok .
>         ... nothing deinited but we do not get an error ...
>
> For this particular one,
>
>         $ git submodule deinit --force
>
> may be also OK, but there may be _other_ conditions that you may
> allow overriding in "deinit" operation (e.g. we may refuse to deinit
> when there are unsaved/unuploaded changes, and allow --force to
> override it), so...

That sounds better thought than my thinking.
So for now I would send the performance regressing flip of IS_GITLINK
and match_pathspec targeting 2.7 and then add a --unmatch-ok switch
for 2.8 and later?

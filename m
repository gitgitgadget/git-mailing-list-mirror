From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Add unit test for check_cherry_pick
Date: Fri, 3 Sep 2010 19:12:36 +0000
Message-ID: <AANLkTikjGgzOxNz-Fepcg2ALqdWurzMyQUmRgqyxQN5L@mail.gmail.com>
References: <AANLkTikuY28wwccxekDXD1WGtaOoF3JG7ZBfm6vjapwt@mail.gmail.com>
	<1283539935-14672-1-git-send-email-stevenrwalter@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, Sam Vilain <sam@vilain.net>,
	git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 03 21:12:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Orbgq-0004T8-UN
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 21:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124Ab0ICTMi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Sep 2010 15:12:38 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45358 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481Ab0ICTMh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Sep 2010 15:12:37 -0400
Received: by iwn5 with SMTP id 5so1776789iwn.19
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 12:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=H3uDZc9QhLWV3j8ATeRI4hCYnqEUdaxmnjiZTxi43CU=;
        b=GmTOQvWykihXNuSZMQ1Apj0FfvB1pYzDKjnof9AK1bmW86BGNUgAmFF7LTL2ZXCLy0
         +X4N9YNm7nOJ0/nRnw7oqSnAqTPph6gQdQhVd7hwJqbf5y4MB23hKvJZk490ZJFlCg0t
         nE1RZ7hAH33iZ3xzJ5ymsXJqVc7COMc/89sSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=G4Y37gb2Gh8P/oDwCSvmDPwNHZDTafL5JO/faPf+lNiFsvnUoNuj8CpzW0Dy0SPwTR
         KRqAQmjopNg/9KT3Fx1ZjFf1qmj+8iSEv2UKc9sYSucWJ9tgHqLneaLqmaObI4M4C1Cz
         FGwZ7voERRX2HU4Zjq0eI8dEWkhqAe2gS1hOs=
Received: by 10.231.36.77 with SMTP id s13mr1235404ibd.190.1283541156723; Fri,
 03 Sep 2010 12:12:36 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Fri, 3 Sep 2010 12:12:36 -0700 (PDT)
In-Reply-To: <1283539935-14672-1-git-send-email-stevenrwalter@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155264>

On Fri, Sep 3, 2010 at 18:52, Steven Walter <stevenrwalter@gmail.com> w=
rote:

> +GIT_SVN_LC_ALL=3D${LC_ALL:-$LANG}

What's this about?

> +. ./lib-git-svn.sh
> +
> +say 'define NO_SVN_TESTS to skip git svn tests'
> +
> +case "$GIT_SVN_LC_ALL" in
> +*.UTF-8)
> + =C2=A0 =C2=A0 =C2=A0 test_set_prereq UTF8

You never use this prereq?

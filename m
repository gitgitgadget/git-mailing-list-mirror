From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help: replace underlining "help -a" headers using hyphens with a blank line
Date: Wed, 25 Apr 2012 10:30:00 -0700
Message-ID: <xmqqpqavd8iv.fsf@junio.mtv.corp.google.com>
References: <20120423183439.GA12916@burratino>
	<1335352913-32684-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 19:30:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN62d-0001WR-7V
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 19:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756358Ab2DYRaE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Apr 2012 13:30:04 -0400
Received: from mail-vx0-f202.google.com ([209.85.220.202]:54930 "EHLO
	mail-vx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528Ab2DYRaC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Apr 2012 13:30:02 -0400
Received: by vcbfk26 with SMTP id fk26so41702vcb.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 10:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=dArMLWunnWW9AMtELMk4o8NXtbj9CiUVoVECf+0pG9g=;
        b=I6IcJ+Mzb2Hh61AY+rgWub1mdqNWUMxnaCHgDlIeTEqtX9zQTGeWIbRwIVhUuIoEsz
         daxZfhuVQPK+nKP2q9FmctVAwAOFLB0mtFsQe1wuPmAh9Cgao/EnBUrLYv+oNIjf+R3H
         lWgR8ZXLGTGXkMlHits5D+KRLI1/mNpf00/v/tY47NIftEDt7SslsRKk9DKa7vm/EMxj
         J8Fjmqp+AnBQal2in3zQHXrUYCIt4JUKNvzgg1n4hgFURau0H1PMN6+j+1LnObynfNQ9
         HAr1qfeDX+3YXdWXYqJ5QM4UuxKtG9s3Qmis3wJ07yhMSWvekPZmqDXjituAWlfe7FWV
         X8og==
Received: by 10.101.7.31 with SMTP id k31mr1344193ani.1.1335375001526;
        Wed, 25 Apr 2012 10:30:01 -0700 (PDT)
Received: by 10.101.7.31 with SMTP id k31mr1344167ani.1.1335375001298;
        Wed, 25 Apr 2012 10:30:01 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id d47si303180yhl.6.2012.04.25.10.30.01
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 25 Apr 2012 10:30:01 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 318831E0058;
	Wed, 25 Apr 2012 10:30:01 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id D06DBE125C; Wed, 25 Apr 2012 10:30:00 -0700 (PDT)
In-Reply-To: <1335352913-32684-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 25
 Apr 2012 18:21:53 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQlXxEMC3eFo6pE6A7TUfF8go94e0e7jOCw2EGJoV9rOSnpLYjmcO4gYjxKJrP4o84RKtpmFYUBtnhxYtbhbVUSNZCLRWbSJ5UPOwiuxT0H92Hp6ejn0SdxwbJLy9SlisvEDRiWeEIZiXtil3+lRO9qDt7aRQIQ5OiNNyGAj3HO3AebMADo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196324>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> We want the underline to align with the text above, for example:
>
> This is a header
> ----------------
> content...
>
> Unfortunately calculating text length could get complicated because
> the text could be in any charset in translated Git. Avoid it and prin=
t
> a blank line (i.e. charset neutral) instead. Readability is not
> affected much. After the change we get:

When I said we do not need *pseudo* underline, I really meant it.  I
tentatively amended your patch to read like this:

    We used to underline a header text, like this:

        This is a header
        ----------------
        content...

    But calculating text length so that the dashes align with the text
    could get complicated because the text could be in any charset in
    translated Git.

    There is no point to use this pseudo underline; simply a blank
    line would do and it even makes it easier to read:

        This is a header

        content...

and adjusted the code to match, but it may make more sense to use the
GIT_COLOR* stuff for this to highlight the header line, allowing us to
lose the extra empty line.

This patch obviously conflicts with your own nd/columns so we may want
to take this slowly and it is OK to wait until columns graduates.

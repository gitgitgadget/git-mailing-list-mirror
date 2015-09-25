From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Fri, 25 Sep 2015 10:41:35 -0700
Message-ID: <xmqqsi624cs0.fsf@gitster.mtv.corp.google.com>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
	<xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com>
	<1443150875.3042.3.camel@kaarsemaker.net>
	<699c08632232180166145f70c7f16645@dscho.org>
	<CAE5ih7_f8qy9WvmgRUR6-qFwB4WFhZ6Qr5iOpE0YxqJH8AsZyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri Sep 25 19:41:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfX0B-0002VZ-M9
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 19:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932861AbbIYRlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 13:41:39 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34489 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932855AbbIYRlh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 13:41:37 -0400
Received: by padhy16 with SMTP id hy16so111687332pad.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2015 10:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=HMGJsAQpHyhvUEC1oZMKzPngDAZm+HC6TcGYfikApZ8=;
        b=PMPy5fEZu/V6Oo4UUawTgMC0RGCI0ELWvdjwwVtn+dzjttqY1v2TZo+zhgRaqNyEOU
         C5tPrhRkwYV28rxUy4vOwWnXxTLBeGVUzL/Omh0pCfloOuspLhtDpRfPkxgR9XDjBOWY
         FRI7VhUL2CfFyYxjQpKg6zWVxEBM6nWHhqCJ/hbY8S3jFEbLs3XwqjeHcQ9SpBXTTETm
         radS2PYEVTO8s2PEXJ6rT29v7+Tmv/P+sfztqK7qiikIa5CipMFtKd1cWreP60/l7cLu
         moauicw8Owj09EEdbwEdRa8bE8c0Q9r4ILL7Jhhy0tmMPUki24BLk8rEY6IDJn33JYaV
         1GbQ==
X-Received: by 10.67.30.232 with SMTP id kh8mr8867834pad.36.1443202897199;
        Fri, 25 Sep 2015 10:41:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:913:2c8:148a:1d8e])
        by smtp.gmail.com with ESMTPSA id pt2sm4979987pbb.64.2015.09.25.10.41.36
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 25 Sep 2015 10:41:36 -0700 (PDT)
In-Reply-To: <CAE5ih7_f8qy9WvmgRUR6-qFwB4WFhZ6Qr5iOpE0YxqJH8AsZyw@mail.gmail.com>
	(Luke Diamand's message of "Fri, 25 Sep 2015 09:05:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278668>

Luke Diamand <luke@diamand.org> writes:

> From past experience, if it's configured to email people when things
> break, sooner or later it will email the wrong people, probably once
> every few seconds over a weekend.
>
> Automated testing is a Good Thing, but it's still software, so needs
> maintenance or it will break.

That does sound like a valid concern (thanks for education---we
should all learn from others' past experience).  Unless it is just a
"set up and forget" thing, I do not think I'd want to be in charge
of it.

Thanks.

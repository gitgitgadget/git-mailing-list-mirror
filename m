From: Mathias Lafeldt <mathias.lafeldt@gmail.com>
Subject: Re: [ANNOUNCE] Sharness - Test library derived from Git
Date: Fri, 20 Jul 2012 12:18:51 +0200
Message-ID: <CAMFa-2gRWRKgj140i1q9iux=eC6nWxfdUPPhb42xAG1Gr7e4vA@mail.gmail.com>
References: <CAMFa-2hS-5CHQj79KMGwY7_qv6nGiK+9cKeDdihMVmSoxfsesQ@mail.gmail.com>
	<CACBZZX6QZACjkFPEsNgAkKgnkZHDsCOEAm=-9rs=PLiSfgsXBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 12:19:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsAIU-00063W-5v
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 12:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330Ab2GTKSy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jul 2012 06:18:54 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34771 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab2GTKSw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jul 2012 06:18:52 -0400
Received: by bkwj10 with SMTP id j10so3199298bkw.19
        for <git@vger.kernel.org>; Fri, 20 Jul 2012 03:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=HjNo90RuDp6+m9gVYRpFxbB55IEti4zKrQPWNEoIzmM=;
        b=VHbVH3DqAugwJRScX8NJnK/RUtiZYHqpPGyt1AX8SWwq3Sy+VutznRzYSZbrfMeDde
         YNr6yZG2JKn5LtbVlX2z+pTG+yKNZctaMIn4UhWUpeHKHbBx+NnKZWgg6ZmQ4tXT696y
         php27UMLQhLFcOPm5/1FEK6HtZCJwL5LDX3keZVqQ+AAt26OgJctZUwdFwTxPbXxF/bJ
         y3besYg5XtIkoL/rr62CK2cB2w0iOU6WwT1O9pSRo5xDKYGURsRSnYp2emGYwULRqG/g
         WHQpxkKXnndkDJOxUzuxrPlGVA/tDo7Cp4vb8/QKXZvTJZirbRmY1hDmQCui3poBQU6m
         tV9A==
Received: by 10.204.129.4 with SMTP id m4mr2496409bks.55.1342779531248; Fri,
 20 Jul 2012 03:18:51 -0700 (PDT)
Received: by 10.204.61.19 with HTTP; Fri, 20 Jul 2012 03:18:51 -0700 (PDT)
In-Reply-To: <CACBZZX6QZACjkFPEsNgAkKgnkZHDsCOEAm=-9rs=PLiSfgsXBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201766>

On Tue, Jul 17, 2012 at 8:31 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> Nice, I thought about doing something like this myself but never had =
the time.

Thanks. Took quite some time to take out the Git-specific
functionality. And there's still a lot of room for improvement.

> Perhaps to avoid duplication we could move to this and keep
> Git-specific function in some other file.

That would be fantastic! From a technical point of view, it would make
a lot of sense to join forces here.

How do you think would Sharness fit into the Git project? Is adding it
as an external dependency an option?

Let's share some ideas before getting to it.

> Do you think that would be sensible, and would you be willing to
> submit patches for that?

While I haven't touched the names of the test functions, I renamed
most of the global shell variables, e.g. GIT_TEST_OPTS to TEST_OPTS
and TEST_DIRECTORY to SHARNESS_TEST_DIRECTORY. That might be a (minor)
problem.

As for the patches: absolutely. I'd really love to give something back =
to Git.

-Mathias

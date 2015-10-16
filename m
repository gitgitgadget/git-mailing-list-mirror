From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/4] stripspace: Implement and use --count-lines option
Date: Fri, 16 Oct 2015 09:41:31 -0700
Message-ID: <xmqqsi5ag404.fsf@gitster.mtv.corp.google.com>
References: <1445008605-16534-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
X-From: git-owner@vger.kernel.org Fri Oct 16 18:42:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zn84Y-0000SA-3D
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 18:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbbJPQlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 12:41:35 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34149 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932548AbbJPQld (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 12:41:33 -0400
Received: by pacez2 with SMTP id ez2so9288467pac.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 09:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Ng4P/Ngy5eVI7l8fD9lVe3O0Q5Zyp3hIdjLcZj2t1gs=;
        b=lWtVYS9u6Nt1NcrfSlM4V39iVC/kIbFGRwQPYe5+YNxc21uKFWPT4mzxza4dWPG0nn
         f/R4nWY12K7Is5e6RYbjTfGVbWoADgSsCnQ2eJ4KLQH1G7GuOFsPWqBO0iwB134rgkQM
         4UaD6GouEf8CLE0IH7TkgXF5PvmMF0ht+Jjfz8Scf+OqC2RQzdmMzMg0ICndGcBGZfX2
         +tzWfAdUpS19M6KbiMJbKIf0obr0a9x4pm566/j+HJBYDxA+kc862W52+9cApLXNxsXa
         dKarWwqgplbaL43chkIcvGVTgOo9n6gfEKXB+wUrYczNFa2AAFx9oF5CnpcCKxp5H4RQ
         mN7g==
X-Received: by 10.68.94.99 with SMTP id db3mr17581208pbb.165.1445013692857;
        Fri, 16 Oct 2015 09:41:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:458e:bb5:8827:32a1])
        by smtp.gmail.com with ESMTPSA id es4sm22129213pbc.42.2015.10.16.09.41.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 Oct 2015 09:41:32 -0700 (PDT)
In-Reply-To: <1445008605-16534-1-git-send-email-tklauser@distanz.ch> (Tobias
	Klauser's message of "Fri, 16 Oct 2015 17:16:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279750>

Tobias Klauser <tklauser@distanz.ch> writes:

Be consistent with the subjects, please.

>   strbuf: make stripspace() part of strbuf

s/make/make/ ;-)

>   stripspace: Use parse-options for command-line parsing

s/Use/use/

>   stripspace: Implement --count-lines option

s/Implement/implement/

>   git rebase -i: Use newly added --count-lines option for stripspace

s/Use/use/


>  Documentation/git-stripspace.txt |  14 +++-
>  builtin/am.c                     |   2 +-
>  builtin/branch.c                 |   2 +-
>  builtin/commit.c                 |   6 +-
>  builtin/merge.c                  |   2 +-
>  builtin/notes.c                  |   6 +-
>  builtin/stripspace.c             | 137 +++++++++++++--------------------------
>  builtin/tag.c                    |   2 +-
>  git-rebase--interactive.sh       |   6 +-
>  strbuf.c                         |  66 +++++++++++++++++++
>  strbuf.h                         |  11 +++-
>  t/t0030-stripspace.sh            |  36 ++++++++++
>  12 files changed, 181 insertions(+), 109 deletions(-)

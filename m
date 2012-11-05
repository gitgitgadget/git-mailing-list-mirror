From: Magnus =?iso-8859-1?Q?B=E4ck?= <baeck@google.com>
Subject: Re: how the commit ID come from in GIT?
Date: Mon, 5 Nov 2012 15:26:22 -0500
Message-ID: <20121105202621.GA31625@google.com>
References: <1352145846.26267.YahooMailClassic@web141404.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: hong zhang <henryzhang62@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 21:26:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVTFm-0001Tb-Pf
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 21:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907Ab2KEU0Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Nov 2012 15:26:25 -0500
Received: from mail-wi0-f202.google.com ([209.85.212.202]:65193 "EHLO
	mail-wi0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753627Ab2KEU0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2012 15:26:25 -0500
Received: by mail-wi0-f202.google.com with SMTP id hr7so274245wib.1
        for <git@vger.kernel.org>; Mon, 05 Nov 2012 12:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0UBIZjqU1Umy34zTAz8T7nOEnNmi1ugaItj95X4B69c=;
        b=WC8abjNbZbKBUMQ1yalx+JbdPTswG7phg8nNS2XX2i89BWMp2WafQXkV7unG0ZMLem
         yZidLtWwcHh41W9LztDygr3Ie5L02lwLlm5ZQRdizJkY/pVrjFpRbAnkQJ6wA3tcuYeC
         DETV1ZWkh2yqPgB9zMQ0GWLgAnKMN6dzJklZNMXMiacdmZttKI3x7GZ3UWSXay1ILYSY
         SBUK/9VWx3Bp0hXvjY+8lqn3rcE/N4lM5tmuMJLpQZqDYMLtzr5PIaKOwAX2YPSagySl
         KOBs2kFzsCcEYTb7k7jpPWKYG8FttLABXKGTH4zoG5J/FV6YZyNPnIsh/Z3nf5FtwNey
         e0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent:x-gm-message-state;
        bh=0UBIZjqU1Umy34zTAz8T7nOEnNmi1ugaItj95X4B69c=;
        b=cZBaJKjjKuqkDWIGGhE138eRrW9iNifuZx5jvt9CBYbmblJGA8SGA/YI1+ssmOmmqi
         oWj6PCnObGGTNvxWGnurb/wSjnzCUlT7ojpUQBd7ydsXYAljOfZeQ1QFKdWd3jDyc4PQ
         f1VWKspoGOylMa4wGcDgrqt9nwV8i8H9eKoy9i/531PdTpOKDYEmxi+J9VuvTQ70lzLR
         AxlT5x6VzLST83efrM/UqH9QahSondi7IKLcg9HgUkvdjp7DaVGWtAe3LFrPd5Zk+NhJ
         9kefC5ojukcrCirXiJ83K6t6vTD79YvNjU02R6KoFYom6nH4LHGgyYruadjRqjvuePEs
         tqzA==
Received: by 10.14.204.3 with SMTP id g3mr10447481eeo.7.1352147183838;
        Mon, 05 Nov 2012 12:26:23 -0800 (PST)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id z47si3389544eel.0.2012.11.05.12.26.23
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Mon, 05 Nov 2012 12:26:23 -0800 (PST)
Received: from valle.nyc.corp.google.com (valle.nyc.corp.google.com [172.26.78.170])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 8AAAF5C0050;
	Mon,  5 Nov 2012 12:26:23 -0800 (PST)
Received: by valle.nyc.corp.google.com (Postfix, from userid 159662)
	id D7ED761004; Mon,  5 Nov 2012 15:26:22 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1352145846.26267.YahooMailClassic@web141404.mail.bf1.yahoo.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Gm-Message-State: ALoCoQkJjDRAhRcq1YCQZJJD05ebOSdWSud9ZsIb2mdrSwtpc7oZfDXxHH61M0udSyEkMRWTBD9dcVnS6Rk0XbKRc/qdxod+vyJcwjZezU1qV1EAHfRAvCS4X5XRF4QueUAdFcIPVbcAfeZwQqwA9xWIaWTefERkuI4OtFf69PpVn+0Sr5AZG3dRAln9tZs+5MnHvga4qMn4LZvZG9OAffhJCQudwkkKVg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209081>

On Monday, November 05, 2012 at 15:04 EST,
     hong zhang <henryzhang62@yahoo.com> wrote:

> Could anyone explain how the git commit ID will include all the files
> that devloper makes changes on?
>
> How git commit ID works?

In short, a Git commit points to a tree object that describes the full
state of the source tree plus metadata like the commit author, date,
description, and a pointer to the commit object(s) that preceded the
commit. The commit id itself is the SHA-1 of the contents of the commit
object. Any change of the source tree will affect the top-level tree
object's SHA-1 which in turn affects the SHA-1 of the commit. Also,
because a commit contains the timestamp of the commit object's creation
even two commits that are content-wise identical will have different
SHA-1s.

If you haven't read it, the Pro Git books explains Git's object model i=
n
detail: http://git-scm.com/book/en/Git-Internals-Git-Objects

That description is quite detailed, and most users don't need to go tha=
t
deep.

--=20
Magnus B=E4ck
baeck@google.com

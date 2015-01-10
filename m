From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Distributed code review discussion
Date: Sat, 10 Jan 2015 10:34:25 -0800
Message-ID: <CAPc5daX2VnikiBOLOSbTuf7QtejV9VRDg-UJKjNQg_6DhUS_Yw@mail.gmail.com>
References: <CAH5CKOqSc2qLZwhCrafYkXMvLmRxKeA_7OO+WzM2FQwKS9F3cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Matus Faro <matusfaro@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 19:34:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YA0s7-0000n9-FG
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 19:34:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbbAJSer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2015 13:34:47 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:39649 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118AbbAJSeq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2015 13:34:46 -0500
Received: by mail-ob0-f177.google.com with SMTP id va2so17046141obc.8
        for <git@vger.kernel.org>; Sat, 10 Jan 2015 10:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Uu4rg8zjpXDkL2zvntprPp3YVrDeLgmMYz2dZN1BFzQ=;
        b=Hxr7pjhOPiD3Fj9MyL71wgfGkKUCeMikKRqZGT4ybAPX1kk4dHBPCThH10BRW4Z/Cr
         9prJMiE95+6V79CmAuPG8PzcTt46g8msazQ8WFjekEVg2nzlAxgd8S3aRKY15bmtuXPp
         6/SQxFedqEjgkn08BZIXgLOkBe5W6qenejgT31PgchJUxUREGtQPQGRerdzyr/uA/daP
         5vnSdWxb9cA8nrKYdQgJ47S/+QPHTO0CIkX8keJY4weA+/NAnFzx5mpPC0o+BwcjVzdN
         r0vr0dQ99eISkElzAGEbw8z8yEJfQN3yOBFH24x/aCydsnhiVDGRYljXrYvqrxw6A2o3
         6JGg==
X-Received: by 10.202.87.21 with SMTP id l21mr12427551oib.84.1420914885843;
 Sat, 10 Jan 2015 10:34:45 -0800 (PST)
Received: by 10.202.86.200 with HTTP; Sat, 10 Jan 2015 10:34:25 -0800 (PST)
In-Reply-To: <CAH5CKOqSc2qLZwhCrafYkXMvLmRxKeA_7OO+WzM2FQwKS9F3cQ@mail.gmail.com>
X-Google-Sender-Auth: 90U2yHfnOuG0NCtiY29j1w0oPe4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262269>

On Sat, Jan 10, 2015 at 10:05 AM, Matus Faro <matusfaro@gmail.com> wrote:
> Are there any plans for supporting merge requests and code reviews
> natively in git?
>
> What I mean is a distributed code review system where a merge request
> along with review comments would be stored within the git repository
> and allowed to be pushed and pulled between repository clones. ...

I remember hearing that Gerrit is already going in that direction, except
that their plan do not include contaminating the project's real history with
the review metadata. You may want to study what they plan to do in order
to make yours compatible, if you are planning to write a new one.

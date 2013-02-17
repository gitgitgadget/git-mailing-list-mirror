From: Orgad Shaneh <orgads@gmail.com>
Subject: Re: rev-parse fails on objects that contain colon
Date: Sun, 17 Feb 2013 10:48:24 +0200
Message-ID: <CAGHpTB+LL_70CCkEMwOZXmYHhc73KAGN4fzhmcCNyF3ksbLV1Q@mail.gmail.com>
References: <CAGHpTBJXM4F3=n3g_Lcb7Dnxkmya5KYeJ5XAsY0PtxftYmUeMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 09:49:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6zvd-0005MV-2L
	for gcvg-git-2@plane.gmane.org; Sun, 17 Feb 2013 09:48:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900Ab3BQIs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 03:48:26 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:60273 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356Ab3BQIsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 03:48:25 -0500
Received: by mail-ob0-f176.google.com with SMTP id v19so4787618obq.35
        for <git@vger.kernel.org>; Sun, 17 Feb 2013 00:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=tVNGComAdK1c4MFVy67RbI43Qr7qMK50vA5DyYLhSlg=;
        b=w8Sr2JUZV82FofbIPm57BzVNwH5PPTfFDda3wj7EyUjIoBrDSzw56EfIXZKagajAQR
         4Yw8UlXUAWy2FdUn/A9gxcATUg74LkiRr2EOgYUtUAxLO9Hndkcy7p5rfdSwvBy2YPOe
         A5jLGRCXZSQ2QxSwqdJm2Jsk66XhbbgLcSlRBS1KtZfc7SuJBmETrFM2bvObU/sBZD6i
         YLD3Z1ZpXHnr3JM5rV02quZUCD7DbU1jC09hwYUvwSxY8EBktUf6r4Mcop8LfVIMg9aq
         6MdR+4+M6DW96J1ENXP+A/cqzASzEC641MF7xg0rJKZH3Uf5tq+I+hlOaPK9jJLUO49D
         Uq7Q==
X-Received: by 10.60.22.169 with SMTP id e9mr4452210oef.70.1361090905063; Sun,
 17 Feb 2013 00:48:25 -0800 (PST)
Received: by 10.182.49.227 with HTTP; Sun, 17 Feb 2013 00:48:24 -0800 (PST)
In-Reply-To: <CAGHpTBJXM4F3=n3g_Lcb7Dnxkmya5KYeJ5XAsY0PtxftYmUeMw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216386>

On Sun, Feb 17, 2013 at 10:37 AM, Orgad Shaneh <orgads@gmail.com> wrote:
> $ git stash save foo:bar
> HEAD is now at 9f88dce Foo
> $ git stash pop foo:bar
> fatal: Invalid object name 'foo'.
> $ git rev-parse foo:bar
> foo:bar
> fatal: Invalid object name 'foo'.
>
> Tested on Windows (msysGit) and Linux.
>
> - Orgad

Oops! stash pop requires explicit stash. Disregard my message...

- Orgad

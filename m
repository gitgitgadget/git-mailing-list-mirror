From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] diff-tree: do not show the sha1 of the given head with --quiet
Date: Thu, 23 Jul 2015 22:02:27 +0200
Message-ID: <CAHGBnuMmOiYUtrOZzA9AV0qTV3_8BT5fgo=5gJ4FYYWV9dEKaA@mail.gmail.com>
References: <0000014eb518dc87-a69705c4-31e7-4983-99a8-f780a743aeac-000000@eu-west-1.amazonses.com>
	<xmqqmvyoq6gh.fsf@gitster.dls.corp.google.com>
	<CAHGBnuM5TG6m7Rwd-EZTUXnaDNYomidthmCamCevNECTQCTnmA@mail.gmail.com>
	<20150723180846.GB18686@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 23 22:02:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIMhM-00070c-9O
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 22:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819AbbGWUC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 16:02:28 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35188 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753544AbbGWUC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 16:02:27 -0400
Received: by igr7 with SMTP id 7so99633121igr.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 13:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4bnQzapM1cHTCq0F201kMOo7LwGt7SZYutQ0xv47z7A=;
        b=nLgUbhrFEgwcEOE6EOP7nHA4geiLtmDQoYD1xItQWlkkEatj+vhTiNIDu4MwvcFmGw
         yEjUOhWPpe1EJqPaBjw34v9SJTleyORvD0oY8qiSnJxtVgIUnCw1sFaYNfhT9ZAgdoEB
         9tyaFJbVVXT6Nrp4QSIy0XO/pXltJqQpYAnrH7eVxaQpt00YksaeOCk5Tar5amqKzEi8
         PyC6BBQUySVSWhLQRJUUJtQAuPlHJ6G8lXZqg1v+zHmOQxynzJneE5Rv6EN4QuDlrXKn
         Q7SgPr6iTXsW+8XB5HBICPGh+nlYw+4/8w1OITBl9LQ2//ausq0M1f2ys2KButfvDjjl
         IXVA==
X-Received: by 10.50.50.228 with SMTP id f4mr13809099igo.19.1437681747068;
 Thu, 23 Jul 2015 13:02:27 -0700 (PDT)
Received: by 10.107.29.149 with HTTP; Thu, 23 Jul 2015 13:02:27 -0700 (PDT)
In-Reply-To: <20150723180846.GB18686@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274522>

On Thu, Jul 23, 2015 at 8:08 PM, Jeff King <peff@peff.net> wrote:

> mode. Actually asking for a two-endpoint tree diff:
>
>   git diff-tree --quiet --ignore-space-change $commit^ $commit
>
> will do what you want.

Yes, I know, thanks. But I deliberately wanted to specify only a
single commit as an optimization, hoping that it would be slightly
faster than computing a commit range.

-- 
Sebastian Schuberth

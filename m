From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/7] Modernize t9300-fast-import
Date: Thu, 19 Nov 2015 22:54:11 -0500
Message-ID: <CAPig+cSH+BnvnzVY=YhRknynyWkAdbXNMvvrb7GcjEnf6UDFug@mail.gmail.com>
References: <cover.1447959452.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Nov 20 04:54:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zzcme-000079-Hm
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 04:54:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161603AbbKTDyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2015 22:54:13 -0500
Received: from mail-yk0-f194.google.com ([209.85.160.194]:32815 "EHLO
	mail-yk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161407AbbKTDyM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2015 22:54:12 -0500
Received: by ykdt74 with SMTP id t74so11399207ykd.0
        for <git@vger.kernel.org>; Thu, 19 Nov 2015 19:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=jm5xzRkIRY7jybpwXFUqx0xI8EXwkJS592qKaQzDajc=;
        b=pgMz5HC9UrZd5/b/arAjfJDUOThZk1a2PLBt663195MS9yq0lNLlKVcSDk1RKHEX2e
         tF1LZbgiuSBVSODYOGdIF+2mhIqjH0mBMXO1ESjWm/M/r/zNpUhwoOO8S2y87wLJ8SQr
         VitMsESb4q8G8Q7TSUh4CSvLiVc6cAfMAR+ku7EQr8JaG7kFWXLz6efPgyumVCA/QlED
         mi+WfiGhBxXyV4g9yqcMN5uLCxK0dXrA0nm3ksE9nKg7yxGXn2Sh38GG29SmLrDd7kfu
         YBgot2b4/ZwGveFP13i3UQYAGe9v6YJS4JqsOfW6Zyz8EGv2GpiJ519OMZ5O3w/M9fsh
         uNWQ==
X-Received: by 10.13.244.129 with SMTP id d123mr11543887ywf.242.1447991651762;
 Thu, 19 Nov 2015 19:54:11 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Thu, 19 Nov 2015 19:54:11 -0800 (PST)
In-Reply-To: <cover.1447959452.git.j6t@kdbg.org>
X-Google-Sender-Auth: 5REy8i9Jgh8atR1O-jmiueX1xEg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281496>

On Thu, Nov 19, 2015 at 2:09 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Some time ago, I had to dig into t9300-fast-import and found it quite
> unhelpful that it does not follow our modern best-practices. This series
> brings it up-to-date. I thought I submit it now while it is quiet in
> the area.
>
> The larger patches are best viewed using -w -color-words because the
> regular patch text is ... overwhelming.

For what it's worth, I read through the series (with care, I hope) and
didn't find anything amiss.

> Improving shell coding style is outside the scope of this series. I mean
> fixing eyesores such as 'cat >foo <<EOF && cat foo | sort > bar', or minor
> things such as quoting <<\EOF when the here-doc does not require
> substitutions.

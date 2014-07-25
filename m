From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2014, #04; Tue, 22)
Date: Fri, 25 Jul 2014 19:30:16 +0700
Message-ID: <CACsJy8DqdTWqVimK0o4rcBXL==iZCsu1OgX2W9ZbgebcSDaKxg@mail.gmail.com>
References: <xmqq4my9f4qw.fsf@gitster.dls.corp.google.com> <53CFC414.1010601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 14:30:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAeeC-0005mF-4k
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 14:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbaGYMas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 08:30:48 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:33260 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbaGYMar (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 08:30:47 -0400
Received: by mail-qg0-f44.google.com with SMTP id e89so5002080qgf.3
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 05:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3RG42OcUCqT40y9Sm4HWeROlFEBPzxfnAtO2WwJW75c=;
        b=w8YSTvJZ7q0T0F/wybNgCqoWOEbZhNfYG9fxth0D7m3w8z9OmBbAb68968jLNPzHxe
         iN3B/tp0hoGM8/rQY3gF5oiVLeGaesxDtHvUQiYFN9EOXKChKVtNFs935Ww+ikzIWqKo
         /p95UtQL5nWyl6i/sBSjvi5sbC9B+fz4GqPVt0MrrORvwtn4+8dB4QcbC1gidkEJPOq5
         hOzfDtLMRl1XvTwdEK2bFehVKI/c1iT3XeZ/bh4ieEGLP7P3B+bkC/mNkNNA5pFdHAvb
         CKd21jZWdYg21nuC2w1avnVwpL8Lt8nCDPhCEDg5aB3ntmdUnlmMlI8L+2orLmNFffN0
         Rn/w==
X-Received: by 10.140.51.37 with SMTP id t34mr25893558qga.50.1406291446718;
 Fri, 25 Jul 2014 05:30:46 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Fri, 25 Jul 2014 05:30:16 -0700 (PDT)
In-Reply-To: <53CFC414.1010601@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254209>

On Wed, Jul 23, 2014 at 9:17 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
> With the version in pu, three tests fail. t7001 is fixed with a newer 'cp'.
> The other two are unrelated (introduced by nd/multiple-work-trees topic).
>
> * t1501-worktree: failed 1
>   As of 5bbcb072 "setup.c: support multi-checkout repo setup"
>   Using $TRASH_DIRECTORY doesn't work on Windows.
>
> * t2026-prune-linked-checkouts: failed 1
>   As of 404a45f1 "prune: strategies for linked checkouts"
>   Dito.

I need your help here. Would saving $(pwd) to a variable and using it
instead of $TRASH_DIRECTORY work? Some tests "cd" around and $(pwd)
may not be the same as $TRASH_DIRECTORY.
-- 
Duy

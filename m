From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 00/20] ref transactions part 2
Date: Tue, 15 Jul 2014 16:37:44 -0700
Message-ID: <CAL=YDW=At4isTCtwdeGZ-v3cS=vbGyC7aQ-CwAEzxKN0c_3Jyg@mail.gmail.com>
References: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jul 16 01:38:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7CIS-0004Y1-TL
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbaGOXiE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:38:04 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:61248 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934424AbaGOXhp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:37:45 -0400
Received: by mail-vc0-f174.google.com with SMTP id la4so242639vcb.5
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 16:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WaNN0IILEUPom1bo13/U290NpIFa0XCx8omI1iSd7Oo=;
        b=IjMqr3Q0w/B1Aq9+kKGJ0YT+NaY+28gfsvKbQx3euZF48gpYILQQ+A1hjeJUgDCFLy
         t6mbmL+A+tGW9NeMoMWut7C+TEJNN13gLMrdRLEefWKAI5mOQHc7bHpaylW7IehhKq+5
         yYJNXfvNvIWxBQ3AnFuqAJ0cojfaz1vHlYYpH4pV6ekdYHfOfPh3UiDjrvmPMec4KoLA
         DxDh7l6wyYge7WbNx25jPkNwzIsFZzFT/qZXHGozS3XZ8Zvz5OjNzX9SjsEPCeiKDbD4
         9WAl9e2Cjk/onxdHLPApIOoHFFIVMaRWDfkCAr1D36WWisc7jLEGKuHUBTTcUeZyjrj7
         cUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=WaNN0IILEUPom1bo13/U290NpIFa0XCx8omI1iSd7Oo=;
        b=ZxNNn9kHsKP4uZVVf2eucsASg6mrd+s1HhWGY+Wv+/y4GodNbQoZn2KtVUPKrbFCew
         ZXFpeuDDHhQkwbMbq6hblI39PXLcy8/qDbFDmQWg+0uWzo3M9yV1wg5adnF2yWXf7FZs
         GvKPBkAeXHioWYnU3XZoyE0IyyGHHGFWFC9jcTFdrz4uBIClov6yz2jkMFZy703myBtt
         AJdWZh1Usr66HVhIFCjdftOWN16lKi1Pj4L93Ia+x1zHI+5t80E73pVY+XoNKLM0oq93
         CwTm9/F8aNWiFGEQ+vVwdFN6gFOzezFFQBoJeC5/Ua4XzKR9UZXz7KexkXPdJkjdPk8S
         2SOA==
X-Gm-Message-State: ALoCoQnmxx4v3984LZ3ZfNUuI6WjMG28nzavItHfusUevA2dlCfkJ4AmngZ08IzDpprd4vxriieD
X-Received: by 10.220.68.83 with SMTP id u19mr3861647vci.52.1405467464382;
 Tue, 15 Jul 2014 16:37:44 -0700 (PDT)
Received: by 10.52.136.166 with HTTP; Tue, 15 Jul 2014 16:37:44 -0700 (PDT)
In-Reply-To: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253645>

Hi Michael,

Here is the next set of 20 patches of those you already reviewed.
I cut this patch off just before patch #40 in the previous series.

These are the patches numbered 20-39 in the original series.
I think I have addressed your concerns here so If you could take a quick look
and hopefully bless them that would be awesome!


Thanks
ronnie sahlberg

On Tue, Jul 15, 2014 at 4:33 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> This is the next 20 patches from my originally big patch series and follow
> the previous 19 patches that is now in juns tree.
> These patches were numbered 20-39 in the original 48-patch series.
>
> Changes since these patches were in the original series:
>
> - Addressing concerns from mhagger's review
>
>
> Ronnie Sahlberg (20):
>   refs.c: change ref_transaction_create to do error checking and return
>     status
>   refs.c: update ref_transaction_delete to check for error and return
>     status
>   refs.c: make ref_transaction_begin take an err argument
>   refs.c: add transaction.status and track OPEN/CLOSED/ERROR
>   tag.c: use ref transactions when doing updates
>   replace.c: use the ref transaction functions for updates
>   commit.c: use ref transactions for updates
>   sequencer.c: use ref transactions for all ref updates
>   fast-import.c: change update_branch to use ref transactions
>   branch.c: use ref transaction for all ref updates
>   refs.c: change update_ref to use a transaction
>   receive-pack.c: use a reference transaction for updating the refs
>   fast-import.c: use a ref transaction when dumping tags
>   walker.c: use ref transaction for ref updates
>   refs.c: make lock_ref_sha1 static
>   refs.c: remove the update_ref_lock function
>   refs.c: remove the update_ref_write function
>   refs.c: remove lock_ref_sha1
>   refs.c: make prune_ref use a transaction to delete the ref
>   refs.c: make delete_ref use a transaction
>
>  branch.c               |  30 +++---
>  builtin/commit.c       |  24 +++--
>  builtin/receive-pack.c |  96 +++++++++++++-------
>  builtin/replace.c      |  15 +--
>  builtin/tag.c          |  15 +--
>  builtin/update-ref.c   |  11 ++-
>  fast-import.c          |  53 +++++++----
>  refs.c                 | 242 ++++++++++++++++++++++++++++---------------------
>  refs.h                 |  78 ++++++++++++----
>  sequencer.c            |  27 ++++--
>  walker.c               |  59 +++++++-----
>  11 files changed, 403 insertions(+), 247 deletions(-)
>
> --
> 2.0.1.442.g7fe6834.dirty
>

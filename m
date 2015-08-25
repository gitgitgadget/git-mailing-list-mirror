From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: read-tree consistent usage of working tree
Date: Tue, 25 Aug 2015 09:31:12 -0700
Message-ID: <xmqqpp2b1ga7.fsf@gitster.dls.corp.google.com>
References: <1439841979-27110-1-git-send-email-Lars.Vogel@vogella.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Lars Vogel <lars.vogel@vogella.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 18:31:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUH82-0000Fx-SB
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 18:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755497AbbHYQbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 12:31:14 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:32975 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbbHYQbN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 12:31:13 -0400
Received: by pacti10 with SMTP id ti10so55945488pac.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 09:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=2hYpveU5gyn+9TmThj0bgA3I2XdtMHI3nhc9KBr0480=;
        b=ekT96fmbpjPIQo7rGWYCJFAqFhRNjMDWDl0GCooIGS9NWFDrzJxHg9IMFnpwP3qyIm
         ZU02pQjvV5dvpRqMpfLbI10n5LyeZ9WZ4skOIdJMbhAVqSEJ7IThrxBBD5oK18mRYCk4
         Ym7JXhjVFCSnzA4I7+o/KfrR6Q4DcOw4w+CM/PUe+rQvRufqa1zl2K2uxsHp1uoPCnDS
         vz3OTa0Bdk9O6BTunHjCViVeBepqQiXPOALGgpg5cnuS42YW7EYEiUCR9v6KHIw69XIr
         2o+EAE6PwOZCRYTTeNN4vSq45M0mJa8+7PXLET6ZM9U5oMIVt7OL37dzzv1WFqmFfcf7
         zXAQ==
X-Received: by 10.66.196.233 with SMTP id ip9mr58001010pac.79.1440520273147;
        Tue, 25 Aug 2015 09:31:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:cdc0:fd6d:4069:6223])
        by smtp.gmail.com with ESMTPSA id pe1sm21580340pbb.28.2015.08.25.09.31.12
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 25 Aug 2015 09:31:12 -0700 (PDT)
In-Reply-To: <1439841979-27110-1-git-send-email-Lars.Vogel@vogella.com> (Lars
	Vogel's message of "Mon, 17 Aug 2015 22:06:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276535>

Lars Vogel <lars.vogel@vogella.com> writes:

> http://git-scm.com/docs/git-clone speaks only about working tree, the
> usage of "working directory" for working tree is confusing. Working
> directory describes the current directory while working tree describes
> all files and sub directories.

Actually I think the $cwd is the "Current working directory"; the
phrase "Working directory" alone does not specifically refer to $cwd.

Being consistent to call the checked out file hierarchy "working tree"
is probably a good idea nevertheless.

> Signed-off-by: Lars Vogel <Lars.Vogel@vogella.com>
> ---

If you apply this patch and then run

    $ git grep -B1 '^directory' Documentation/git-read-tree.txt

you would notice that the patch has missed a few more.

Also

    $ git grep 'work tree' Documentation/git-read-tree.txt

has a handful of hits.

Perhaps try again?

Thanks.

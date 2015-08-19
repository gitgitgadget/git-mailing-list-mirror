From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Moved code detection with `git apply` a la `git blame -C -C`
Date: Tue, 18 Aug 2015 23:42:13 -0700
Message-ID: <CA+P7+xrbE9TxzXWwixOv12r0wb=Y17BRxyKFHGTUb0-4Q+wyhA@mail.gmail.com>
References: <CALZPV0Dgmu5fJqQEXwxVvn9Na6jUtvkDbAwY9mAZKeFSMqo8xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Anish Tondwalkar <tondwalkar@virginia.edu>
X-From: git-owner@vger.kernel.org Wed Aug 19 08:42:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRx59-0006TU-4Z
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 08:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbbHSGmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 02:42:33 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:35875 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbbHSGmd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 02:42:33 -0400
Received: by iodv127 with SMTP id v127so200592741iod.3
        for <git@vger.kernel.org>; Tue, 18 Aug 2015 23:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FcBtKHo/v+C6adi4gOFEc0PoVqXjgr4LPVtuuyY/wAo=;
        b=DscoErMkXc14q5p2nJwofcDeXOnHg1zdj6utf6zpzS3eTO120JHif8Fm22EM1BxgBt
         kW2GjzrzB6ctFuU3sn5mciPEjymqyL5A7hyxH1tqgFBciWhzldibG7+X6XWe/N46Q61j
         a506ELzc/JIvzo0KsQrou7xhKB49QhjegozXfPhCoJ1CavJ+fXMtou1/4F4gkGvqWaYJ
         YXp3/+QniVk8s42pSfpMXbyZ+FV3+1U4SNzsotMGsfjiOX2saESIXrnnvpMNZTPbT9wz
         G/CPH/mSHYl+TzEW1ZQr/Mqmyq/Y7HfNGcP8v1z388qm3CcFZmvLSQKHk7wxFt0IVZWo
         oduQ==
X-Received: by 10.107.154.67 with SMTP id c64mr13289146ioe.0.1439966552386;
 Tue, 18 Aug 2015 23:42:32 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Tue, 18 Aug 2015 23:42:13 -0700 (PDT)
In-Reply-To: <CALZPV0Dgmu5fJqQEXwxVvn9Na6jUtvkDbAwY9mAZKeFSMqo8xQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276162>

Maybe something along the lines of a git-subtree merge. I am not sure
how to do that exactly, and I am not sure that it would be worth the
trouble to setup for a small case...

On Tue, Aug 18, 2015 at 1:11 PM, Anish Tondwalkar
<tondwalkar@virginia.edu> wrote:
> I stashed some changes, then refactored my code to move the function
> they're in into a new file. Now, I want to apply it to the new file. I
> know git can figure out this relationship between the files, because
> `git blame -C -C` can find it, but is there a "more idiomatic" way to
> apply this diff than to have git spit out a diff, and edit it
> manually?
>
> --
> Anish
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

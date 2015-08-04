From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] Documentation/git-worktree: fix reference to 'locked' file
Date: Tue, 4 Aug 2015 14:18:02 -0400
Message-ID: <CAPig+cS5Mk-11S+9mSkeaw0nCmb_AS4DC5apwkeXBAROVwE0TA@mail.gmail.com>
References: <1438691278-31609-1-git-send-email-ps@pks.im>
	<1438691278-31609-2-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Tue Aug 04 20:18:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMgmw-00010V-Ec
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 20:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753873AbbHDSSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 14:18:05 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:36439 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588AbbHDSSE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 14:18:04 -0400
Received: by ykeo23 with SMTP id o23so15084394yke.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 11:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=znapFWUqOnGc9XN3Ams/be1OC724/vaTgKlBVJvXqNQ=;
        b=MKOViEub128ic9LCKy4GBkoQMI2kH/MS4qodsM427mHibmiNeRcbYxiKY9RTxqfWYm
         ofIsVQvbmC00eqJX0Uv2eJLGguVmYYVcqiL1MRpxEeJJ5eGerhuQVQna1ge+2LOgsAxI
         +CZXzGvH7D/fUub4W45IVPf1p0ZjcAwGndtPvwPRrl/W7NHlFvFnNecJxcfCrzKpwRB9
         z2ykdZFwURQ+dtSYqzZd+Ch9d8RtC1xjOcGpVXZvAZl/wd4VLftYxsTOQSUyRqH8dCwB
         Iy27mlnSSQDKGJdBtMOXcLS1j4fK4yxvxT3j2Gh3ThL/conSCpStknYENPM1jLwCRu7/
         SQ3Q==
X-Received: by 10.170.138.134 with SMTP id f128mr5188827ykc.90.1438712282498;
 Tue, 04 Aug 2015 11:18:02 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Tue, 4 Aug 2015 11:18:02 -0700 (PDT)
In-Reply-To: <1438691278-31609-2-git-send-email-ps@pks.im>
X-Google-Sender-Auth: 0HgipUDMb2DQaMC6B2SDln_jSvw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275330>

On Tue, Aug 4, 2015 at 8:27 AM, Patrick Steinhardt <ps@pks.im> wrote:
> The documentation of git-worktree refers to the 'locked' file as
> 'lock'. Fix this to say 'locked' instead.

Thanks for the patch. This is already fixed in 'next' by 2e73ab6
(Documentation/git-worktree: fix incorrect reference to file "locked",
2015-07-20)

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 566ca92..3fedd9e 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -39,7 +39,7 @@ repository so that they do not get automatically pruned.
>
>  If a linked working tree is stored on a portable device or network share
>  which is not always mounted, you can prevent its administrative files from
> -being pruned by creating a file named 'lock' alongside the other
> +being pruned by creating a file named 'locked' alongside the other
>  administrative files, optionally containing a plain text reason that
>  pruning should be suppressed. See section "DETAILS" for more information.

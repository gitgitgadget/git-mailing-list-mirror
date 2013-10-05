From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetool--lib: Fix typo in the merge/difftool help
Date: Fri, 4 Oct 2013 18:49:11 -0700
Message-ID: <CAJDDKr5wcD2sDUC-jDUmJm8coUPVSHHEK3CGJbKNZ7NoSKBA4A@mail.gmail.com>
References: <1380897293-41652-1-git-send-email-ssaasen@atlassian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Stefan Saasen <ssaasen@atlassian.com>
X-From: git-owner@vger.kernel.org Sat Oct 05 03:49:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VSGzf-0005mW-Ei
	for gcvg-git-2@plane.gmane.org; Sat, 05 Oct 2013 03:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805Ab3JEBtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Oct 2013 21:49:15 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:46788 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab3JEBtP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Oct 2013 21:49:15 -0400
Received: by mail-pd0-f169.google.com with SMTP id r10so4767693pdi.0
        for <git@vger.kernel.org>; Fri, 04 Oct 2013 18:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4XCwV12Xf1RitUE5cm44urcEdGgF3fL7Z7DlYJGiP6s=;
        b=nkcyWDPot13yP4gXC4LmU/Fgxq8hVAsuBzlKaXMZWmkVbqZ5VB9ngb+NXGmFiN9UeR
         N6bVVYFyxd1TaNv6RAf/MTvbi0Tyw4H6rFahxfBLrS38RbrT9rAxqhSRZqxPoo//o+rv
         8tx8TBpizBfb4+/hNBfiJm2KtSigB+wAecCyruZQQf675kQqmWYc0Qbi4qG6/HwR07VI
         ZGkdLdFCXxGsnLOKxQ6AxTrwapg5Wige50cIjr7vz4Tgc8PMHZgkQYTAgyV6UTvOzcqA
         PLJu82dk63t/Ja4Nx3BspUG8T4p130PPsyeaINt9WuWc+weevu4LoQIjf5we4Ztm0l8R
         QYmQ==
X-Received: by 10.67.1.228 with SMTP id bj4mr152512pad.157.1380937752030; Fri,
 04 Oct 2013 18:49:12 -0700 (PDT)
Received: by 10.70.102.45 with HTTP; Fri, 4 Oct 2013 18:49:11 -0700 (PDT)
In-Reply-To: <1380897293-41652-1-git-send-email-ssaasen@atlassian.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235720>

On Fri, Oct 4, 2013 at 7:34 AM, Stefan Saasen <ssaasen@atlassian.com> wrote:
> The help text for the `tool` flag should mention:
>
>     --tool=<tool>
>
> instead of:
>
>     --tool-<tool>
>
> Signed-off-by: Stefan Saasen <ssaasen@atlassian.com>
> ---

Good eyes!

Reviewed-by: David Aguilar <davvid@gmail.com>

Thanks

>  git-mergetool--lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index feee6a4..e1c7eb1 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -263,7 +263,7 @@ list_merge_tool_candidates () {
>  }
>
>  show_tool_help () {
> -       tool_opt="'git ${TOOL_MODE}tool --tool-<tool>'"
> +       tool_opt="'git ${TOOL_MODE}tool --tool=<tool>'"
>
>         tab='   '
>         LF='
> --
> 1.8.4.474.g128a96c.dirty
>
-- 
David

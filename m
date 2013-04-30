From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Fix grammar in the 1.8.3 release notes.
Date: Mon, 29 Apr 2013 23:09:19 -0400
Message-ID: <CAPig+cSPbzU=vEFpE8AUZzvyHR3DbbJv-AxSmZ=dTyKzRUOQ2A@mail.gmail.com>
References: <7vvc78u8jl.fsf@alter.siamese.dyndns.org>
	<1367262904-9885-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 05:09:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX0wi-0007RE-BX
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 05:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757179Ab3D3DJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 23:09:22 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:62656 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755527Ab3D3DJV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 23:09:21 -0400
Received: by mail-la0-f51.google.com with SMTP id ep20so54568lab.24
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 20:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=7Ra4ytunrTnHXxnZVTB8Wsm8TmSyNBVynosYWfpE0gM=;
        b=LZNTd9KhxsPO3/CIyX6sjyG/7/7SWdVzDQ0Z6cA7YyoI4hvjf9EqN62lVkvwC8MDj6
         IOCPHAlPWpjZij9QViQDQMhs0VgNvk18AiaU0natT7GResirBM4ANQS/11s0SOBFCxdL
         jJRLv2uLcFV9m2IdprGoiqj2RIfu8d04LyyK66X8P9DEyF6pL/OG1KD7hSWxBvlqMKlT
         7B05C2gpkwcC9rXVlFW+mxajdJRQhrJgg63y7rbdxG4QLx2/yWJ8z2Py/ofQJ6LSrHjm
         yiqpewa5FEEIuw/R2sbYHODzpDnvhp4jtdlLCfx2ngUOgo5mAiwts3QgAn1Q3YjKDIzA
         J3Wg==
X-Received: by 10.152.19.199 with SMTP id h7mr28614611lae.21.1367291360015;
 Mon, 29 Apr 2013 20:09:20 -0700 (PDT)
Received: by 10.114.199.11 with HTTP; Mon, 29 Apr 2013 20:09:19 -0700 (PDT)
In-Reply-To: <1367262904-9885-1-git-send-email-marcnarc@xiplink.com>
X-Google-Sender-Auth: 8nN3SoV1k5HmyEuqGq3IAnypiBM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222893>

On Mon, Apr 29, 2013 at 3:15 PM, Marc Branchaud <marcnarc@xiplink.com> wrote:
> --- a/Documentation/RelNotes/1.8.3.txt
> +++ b/Documentation/RelNotes/1.8.3.txt
> @@ -8,23 +8,22 @@ When "git push [$there]" does not say what to push, we have used the
>  traditional "matching" semantics so far (all your branches were sent
>  to the remote as long as there already are branches of the same name
>  over there).  In Git 2.0, the default will change to the "simple"
> -semantics that pushes the current branch to the branch with the same
> -name, only when the current branch is set to integrate with that
> -remote branch.  There is a user preference configuration variable
> +semantics that pushes only the current branch to the branch with the same
> +name, and only when the current branch is set to integrate with that
> +remote branch.  Use the user preference configuration variable
>  "push.default" to change this.  If you are an old-timer who is used
> -to the "matching" semantics, you can set it to "matching" to keep the
> +to the "matching" semantics, you can set the varaible to "matching" to keep the

s/varaible/variable/

>  traditional behaviour.  If you want to live in the future early,
>  you can set it to "simple" today without waiting for Git 2.0.

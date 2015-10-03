From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Git feature request: mark a commit as minor
Date: Fri, 2 Oct 2015 23:11:11 -0700
Message-ID: <CA+P7+xq8Ds3hYjv2x8S4v8+6F3G+ciGreiZxHxDfzzft520ChQ@mail.gmail.com>
References: <560EF966.3000501@walltime.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Felipe Micaroni Lalli <micaroni@walltime.info>
X-From: git-owner@vger.kernel.org Sat Oct 03 08:12:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiG39-0006ah-3L
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 08:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbbJCGLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 02:11:31 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:33416 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbbJCGLb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 02:11:31 -0400
Received: by iofh134 with SMTP id h134so141270425iof.0
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 23:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eFHehlDgSfCYx0Ra0evqtZHe2bZIJ4NWZdCoS3LoHrg=;
        b=fN3UD4mtEyczVG0dqJv3ooLUzwGFFUqLGxx3VCypWXIQxVxMzeztb3ESB7/dvhMCw3
         TLGI5i3dhzoy8CfE91dl9hj95OhbnhWUP2sFoGQXX5bd15i9rnpURKdBptqslD7MtXMz
         TyW6DEpOYXUdP159p49nZRrhuV4A/L0FIzL1ioHbUJ7Lo40dmVdMZ14bq0jAY8lA5e1K
         84EO7E+PzuuSsXW8L0zmj5H15lTAPWSSVWQGQ0dkZV63sgRs2ryWD3EAexK+GXXLGXsm
         amw2zdyARF0SGd5T6ZvY/jLsDkJvQSHPcACFpb3N8Tk+/6umr8J4k8szOuVcHCiXdQ0w
         r5iQ==
X-Received: by 10.107.166.201 with SMTP id p192mr23920501ioe.0.1443852690556;
 Fri, 02 Oct 2015 23:11:30 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Fri, 2 Oct 2015 23:11:11 -0700 (PDT)
In-Reply-To: <560EF966.3000501@walltime.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278956>

On Fri, Oct 2, 2015 at 2:38 PM, Felipe Micaroni Lalli
<micaroni@walltime.info> wrote:
> A minor change (also called "cosmetic") usually is a typo fix, doc
> improvement, a little code refactoring that don't change the behavior etc.
>
> In Wikipedia we can mark an edition as "minor".
>
> It would be nice to have an argument like "--minor" in git-commit to
> mark the commit as minor. Also, filter in git-log (like --hide-minor) to
> hide the minor changes. The git-log could be optimized to show minor
> commits more discreetly.
>
>

This should just be part of the commit message log, generally projects
use something like TRIVIAL in the patch subject or similar. You could
also standardize for your project(s) what would be considered a minor
change. The issue is that not everyone considers these changes as
"minor". You should be able to use a combination of the --grep option
in log to search for all commits who don't contain that string in the
right format.

Regards,
Jake

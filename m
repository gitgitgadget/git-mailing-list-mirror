From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: Why are submodules not automatically handled by default or at
 least configurable to do so?
Date: Mon, 26 Oct 2015 12:48:48 +0800
Message-ID: <CAEY4ZpPduXXqgW3rWn9rzkpHrTvY8QfPX=YcBZ_DpyVwnsZ6jw@mail.gmail.com>
References: <D4E5E890658.000004DCjohsmi9933@inbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: John Smith <johsmi9933@inbox.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 05:49:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqZik-0003sO-7B
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 05:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbbJZEst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 00:48:49 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35091 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbbJZEst (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 00:48:49 -0400
Received: by pagq8 with SMTP id q8so19201637pag.2
        for <git@vger.kernel.org>; Sun, 25 Oct 2015 21:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wWRbNb6AqspEf6wztEEl2S6XrT7y4RX9XJ1blBQF5+U=;
        b=KJValNH4oYQxIkg/JmAZ3MxYWc7mhHr1PX91n/DAC8mJai0u6ljbNqdKiF/ulIVrz9
         MolkINNpowb8mWtxCUEdLDbFJe4HXcvkz2gSYDhAIkfw3WGMHYSjkMO1f6RLmMPpkvBt
         z8hT9jk5m0oKlzeoeQUrYuVEHF7nDtdeyCQAaR9fLhZeKk4l8j5ZTETefidphkRfOlZE
         Tf0LZyCpTAwx5RFgSIQaYXCQKpGqWrMRlQOKTXa4t3uZN5SmSDPj7x7rjs6iKUxWiaoJ
         lpT8QF1OcA62DIaN0jYD7TB2qabV0vvOcSavn1kM3mtAROoxLbrfEdVWUI+2qf/NiOk3
         TrTw==
X-Received: by 10.66.152.44 with SMTP id uv12mr25577869pab.110.1445834928584;
 Sun, 25 Oct 2015 21:48:48 -0700 (PDT)
Received: by 10.66.199.72 with HTTP; Sun, 25 Oct 2015 21:48:48 -0700 (PDT)
In-Reply-To: <D4E5E890658.000004DCjohsmi9933@inbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280171>

On Mon, Oct 26, 2015 at 7:10 AM, John Smith <johsmi9933@inbox.com> wrote:
> When would people routinely check out a branch and want to stay with the submodules as
> the have been checked out for the old branch?

I do this a lot. At my $dayjob we have a super project with bunch of
sub projects.
Each subproject has its corresponding rpm spec file in the
superproject - it's quite
often that I work on a "git-merge-base--octopus" branch that updates only the
spec files and nothing else - so when changing between branches I
don't care what
states the submodules are in. When the fixes to the spec files are ready I just
checkout to the respective branches and merge in the changes - I don't actively
do "git submodule update" when switching to different branches.

nazri

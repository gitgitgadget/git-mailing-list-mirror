From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] send-email: validate & reconfirm interactive responses
Date: Tue, 14 Aug 2012 15:33:00 -0700
Message-ID: <CAOeW2eEOAdVJrVfyZ4osEARXWuXncy3ZSa4ir8BZbUjNjMzbSw@mail.gmail.com>
References: <CAOeW2eGZm7PLRaktjQQdDJm2BqAihS0pzsY2GUNFUO83s8qBPQ@mail.gmail.com>
	<1344983132-22578-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 00:33:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1Pfh-0001zO-39
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 00:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134Ab2HNWdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 18:33:03 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42663 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552Ab2HNWdB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 18:33:01 -0400
Received: by yhmm54 with SMTP id m54so1079503yhm.19
        for <git@vger.kernel.org>; Tue, 14 Aug 2012 15:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/9NahGmZMG1Xu1xdSdoFPEtJEzLxuMLF88pRhl426uI=;
        b=dXs8csyL87WaSqWNASE5hnoGIkc9YFMX6PW7k0t9XrWx4Qa7jm9RMQ4MElf7UUgDBi
         fIMoCjK+a2oq9PxCgd5Yepzv1mf+qWfTUxLZZsBWKzqQrxGzUXQXALFEx29ia1exGAFS
         hQlLQUO/il2b5HYhFkvGfK62y3rHt6YLv6GZkw0yA9tARVRpiC4YPaFJqzPYFyig8D4N
         HpI3CC4jfTeEvlDAMqYp8MG1IZTdv3gJd5UJZeOb/1Cho8IH9SeOpQrLCUWYqVQ4n99d
         oyLp8WJ0bTUuQ6/5UpjzbERE8j0T/m3Q5pFp7+2TQ+wf/eh9/b+io+hGLdcSNF2BfzwK
         Ssqw==
Received: by 10.66.85.201 with SMTP id j9mr22528314paz.40.1344983580538; Tue,
 14 Aug 2012 15:33:00 -0700 (PDT)
Received: by 10.68.120.112 with HTTP; Tue, 14 Aug 2012 15:33:00 -0700 (PDT)
In-Reply-To: <1344983132-22578-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203457>

On Tue, Aug 14, 2012 at 3:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> People answer 'y' to "Who should the emails appear to be from?"  and
> 'n' to "Message-ID to be used as In-Reply-To for the first email?"
> for some unknown reason.

Yeah, I know :-(. I did feel stupid already. Thanks for improving.

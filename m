From: Marc Khouzam <marc.khouzam@gmail.com>
Subject: Re: [PATCH] Fix bash completion when `egrep` is aliased to `egrep --color=always`
Date: Thu, 22 Nov 2012 14:55:21 -0500
Message-ID: <CAFj1UpG6H3bpoa7xbqpH6Hyb6pwqE_CCgP6iT36D-ELvtVi4wA@mail.gmail.com>
References: <20121122154120.GA16835@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Adam Tkac <atkac@redhat.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 20:55:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbcsD-0007aK-P3
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 20:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965275Ab2KVTz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 14:55:27 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:38063 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965124Ab2KVTzW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 14:55:22 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so6023824iay.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 11:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9Vz093r+U/H03bIQXEIRdPHH5/6kFmnDk+q9DpGZNjg=;
        b=V/3ttJzclFd9zWdXYWC2W7jdD2edpWEsYGythXSNxuLemZ+W4rui1mI82FteBN3Ask
         1FoFllwnNtqgTjxLzutglYvY7jcib2KrLk51WctIHuEGlDoKgFr4ZXl9jXotY//uH9iq
         n44TvL95S0GJ7FDjJ/BKbE9NnIcAnt/YXtTyhZ5xCfJmsgxhURCsIhPV9TOKqI0cWK7Z
         UE4wChsOhRSVvnqEy7F9TjjXPRoPZRvIe25Indk70KvEL3TAnpilVh02QycPEpzqw+Ws
         W1BCmd43Pt1m7ydsZRL67mv5JCtGg/PSrY9tJKzungqPPsOYET358auTyHZ7WNbQ17lS
         QpdQ==
Received: by 10.50.36.200 with SMTP id s8mr1580687igj.23.1353614121771; Thu,
 22 Nov 2012 11:55:21 -0800 (PST)
Received: by 10.64.132.39 with HTTP; Thu, 22 Nov 2012 11:55:21 -0800 (PST)
In-Reply-To: <20121122154120.GA16835@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210205>

On Thu, Nov 22, 2012 at 10:41 AM, Adam Tkac <atkac@redhat.com> wrote:
> Hello all,
>
> attached patch fixes bash completion when `egrep` is aliased to `egrep --color=always`.

To avoid any aliases, it may be better to use
\egrep

This could be worthwhile for all utilities used by the script.

Just a thought.

Marc


>
> Comments are welcomed.
>
> Regards, Adam
>
> --
> Adam Tkac, Red Hat, Inc.

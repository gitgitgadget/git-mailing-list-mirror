From: Adam Spiers <git@adamspiers.org>
Subject: Re: What's cooking in git.git (Jan 2013, #06; Mon, 14)
Date: Wed, 16 Jan 2013 01:34:36 +0000
Message-ID: <CAOkDyE_a4R7=A318VL2TxDn6X8Tu2+m2KNWWYqwBbygRrALQzg@mail.gmail.com>
References: <7vehhn8kub.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 02:35:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvHu6-0000Ad-Ou
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 02:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756264Ab3APBei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 20:34:38 -0500
Received: from mail-wg0-f42.google.com ([74.125.82.42]:49408 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755896Ab3APBeh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 20:34:37 -0500
Received: by mail-wg0-f42.google.com with SMTP id dr1so2325529wgb.5
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 17:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=PWisWr124wuE4VqxxVyKzK1WbqSezJSRMLCtP1SutFI=;
        b=rXxR6nWA8VsiBVGSRkDkKY0N+QuHqJi94O0tAmvUFG2uzrlgh0rhR+IZ6Vqn9vfPnM
         FEbAJPJ8Uo2lRSP/IHJ5jd6ITqMw5v1wd9XjKj6wqAiA13lcf49cGJH4+fCDZwnzhAY3
         wmhBS3/dc+yHROz3veSC3OtyHQgFgoBz1vjuFdXbPbFW7DUw6W59TY8pGlYhKIRmhGfM
         5o7DPKDw0ZNi+TeAONT7/h0KPgSZxi6thZ+yH5V/wofMKAOVSAb3vuBvD/wXskU9MuWG
         PR7PBCZKUsSTSO67KQMU0ELTMEDZnLc1Wxg0zruWiumG5/78lM+2z7Hldx3PHmD369mW
         7E+Q==
Received: by 10.180.85.165 with SMTP id i5mr6877667wiz.11.1358300076119; Tue,
 15 Jan 2013 17:34:36 -0800 (PST)
Received: by 10.194.84.97 with HTTP; Tue, 15 Jan 2013 17:34:36 -0800 (PST)
In-Reply-To: <7vehhn8kub.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 2XQyLSZtHbYl0ryJi0RUhoiZGAY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213701>

On Mon, Jan 14, 2013 at 10:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> * as/check-ignore (2013-01-10) 12 commits
>   (merged to 'next' on 2013-01-14 at 9df2afc)
>  + t0008: avoid brace expansion
>  + add git-check-ignore sub-command
>  + setup.c: document get_pathspec()
>  + add.c: extract new die_if_path_beyond_symlink() for reuse
>  + add.c: extract check_path_for_gitlink() from treat_gitlinks() for reuse
>  + pathspec.c: rename newly public functions for clarity
>  + add.c: move pathspec matchers into new pathspec.c for reuse
>  + add.c: remove unused argument from validate_pathspec()
>  + dir.c: improve docs for match_pathspec() and match_pathspec_depth()
>  + dir.c: provide clear_directory() for reclaiming dir_struct memory
>  + dir.c: keep track of where patterns came from
>  + dir.c: use a single struct exclude_list per source of excludes
>
>  Add a new command "git check-ignore" for debugging .gitignore
>  files.

The above is v4 plus the "t0008: avoid brace expansion" fix.  v4 is
slightly outdated and not quite the right version to merge to 'next'.
I'll post a v5 re-roll as per:

http://thread.gmane.org/gmane.comp.version-control.git/212184/focus=212856

in the next 24 hours or so.

I think the "t0008: avoid brace expansion" fix at the tip should
probably be squashed into its parent.  I've amended the commit message
accordingly in my github fork.

Thanks,
Adam

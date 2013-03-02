From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Revert "graph.c: mark private file-scope symbols as static"
Date: Sat, 2 Mar 2013 15:54:58 +0100
Message-ID: <CALKQrgf9h_9_zOd9bDq9LZsg2Xo9zBaCS0GKaeJX2Og5LMiAyQ@mail.gmail.com>
References: <50e7b3316fadbb550bea098ae92a0942a4429647.1362228122.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Mar 02 15:55:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBnqZ-0001Au-3p
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 15:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725Ab3CBOzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Mar 2013 09:55:06 -0500
Received: from locusts.copyleft.no ([188.94.218.116]:60178 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab3CBOzF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Mar 2013 09:55:05 -0500
Received: from mail-oa0-f50.google.com ([209.85.219.50])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UBnq3-000Iix-0j
	for git@vger.kernel.org; Sat, 02 Mar 2013 15:55:03 +0100
Received: by mail-oa0-f50.google.com with SMTP id l20so7175562oag.37
        for <git@vger.kernel.org>; Sat, 02 Mar 2013 06:54:59 -0800 (PST)
X-Received: by 10.60.22.34 with SMTP id a2mr11351238oef.97.1362236099054; Sat,
 02 Mar 2013 06:54:59 -0800 (PST)
Received: by 10.182.231.68 with HTTP; Sat, 2 Mar 2013 06:54:58 -0800 (PST)
In-Reply-To: <50e7b3316fadbb550bea098ae92a0942a4429647.1362228122.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217330>

On Sat, Mar 2, 2013 at 1:46 PM, John Keeping <john@keeping.me.uk> wrote:
> This reverts commit ba35480439d05b8f6cca50527072194fe3278bbb.
>
> CGit uses these symbols to output the correct HTML around graph
> elements.  Making these symbols private means that CGit cannot be
> updated to use Git 1.8.0 or newer, so let's not do that.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>
> I realise that Git isn't a library so making the API useful for outside
> projects isn't a priority, but making these two methods public makes
> life a lot easier for CGit.
>
> Additionally, it seems that Johan added graph_set_column_colors
> specifically so that CGit should use it - there's no value to having
> that as a method just for its use in graph.c and he was the author of
> CGit commit 268b34a (ui-log: Colorize commit graph, 2010-11-15).

Correct,

Acked-by: Johan Herland <johan@herland.net>


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

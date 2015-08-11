From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v6 2/2] notes: handle multiple worktrees
Date: Tue, 11 Aug 2015 15:56:45 +0200
Message-ID: <CALKQrgco6wJ0CpNX5=DF+Z7G009e0G5wz=UUTOqAzv81hKh7bg@mail.gmail.com>
References: <1439229165-25773-1-git-send-email-dturner@twopensource.com>
	<1439229165-25773-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 16:20:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPAQ9-0004sM-6Z
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 16:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965270AbbHKOUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 10:20:41 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:52958 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964890AbbHKOUj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 10:20:39 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ZPA2t-000Aet-Mu
	for git@vger.kernel.org; Tue, 11 Aug 2015 15:56:51 +0200
Received: by ykdz80 with SMTP id z80so55523029ykd.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 06:56:45 -0700 (PDT)
X-Received: by 10.170.114.78 with SMTP id g75mr27516769ykb.94.1439301405801;
 Tue, 11 Aug 2015 06:56:45 -0700 (PDT)
Received: by 10.37.208.71 with HTTP; Tue, 11 Aug 2015 06:56:45 -0700 (PDT)
In-Reply-To: <1439229165-25773-2-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275692>

On Mon, Aug 10, 2015 at 7:52 PM, David Turner <dturner@twopensource.com> wrote:
> Before creating NOTES_MERGE_REF, check NOTES_MERGE_REF using
> find_shared_symref and die if we find one.  This prevents simultaneous
> merges to the same notes branch from different worktrees.
>
> Signed-off-by: David Turner <dturner@twopensource.com>

Still looks good to me, AFAICS. Feel free to add my Reviewed-by.

...Johan



-- 
Johan Herland, <johan@herland.net>
www.herland.net

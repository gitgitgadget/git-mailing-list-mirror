From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Fix `git rev-list --show-notes HEAD` when there are no notes
Date: Sat, 22 Aug 2015 18:30:41 +0200
Message-ID: <CALKQrgcvRvs8wLy-O2eZZg9iMG2T7coFMoFwmDu3nmAXHhdW1w@mail.gmail.com>
References: <0LZlZ2-1Z1Zyn1mzk-00lZ3Z@mail.gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 22 18:31:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTBhB-0004Wa-Cb
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 18:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144AbbHVQau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2015 12:30:50 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:64436 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbbHVQau (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2015 12:30:50 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ZTBgt-000JfK-TU
	for git@vger.kernel.org; Sat, 22 Aug 2015 18:30:48 +0200
Received: by ykll84 with SMTP id l84so98433736ykl.0
        for <git@vger.kernel.org>; Sat, 22 Aug 2015 09:30:42 -0700 (PDT)
X-Received: by 10.13.232.142 with SMTP id r136mr20262384ywe.38.1440261042031;
 Sat, 22 Aug 2015 09:30:42 -0700 (PDT)
Received: by 10.37.201.134 with HTTP; Sat, 22 Aug 2015 09:30:41 -0700 (PDT)
In-Reply-To: <0LZlZ2-1Z1Zyn1mzk-00lZ3Z@mail.gmx.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276391>

On Sat, Aug 22, 2015 at 5:14 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> The `format_display_notes()` function clearly assumes that the data
> structure holding the notes has been initialized already, i.e. that the
> `display_notes_trees` variable is no longer `NULL`.
>
> However, when there are no notes whatsoever, this variable is still
> `NULL`, even after initialization.
>
> So let's be graceful and just return if that data structure is `NULL`.
>
> Reported in https://github.com/msysgit/git/issues/363.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Acked-by: Johan Herland <johan@herland.net>

-- 
Johan Herland, <johan@herland.net>
www.herland.net

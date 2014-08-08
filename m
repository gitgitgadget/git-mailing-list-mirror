From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2014, #02; Fri, 8)
Date: Sat, 9 Aug 2014 06:44:51 +0700
Message-ID: <CACsJy8AJvt3bVj783eyHhiFaMD3Ys6pAsyT7S2TYi2a_ACKcRg@mail.gmail.com>
References: <xmqq1tsqk4m4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 01:45:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFtqv-0001gy-3d
	for gcvg-git-2@plane.gmane.org; Sat, 09 Aug 2014 01:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbaHHXpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 19:45:22 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:39040 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbaHHXpW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 19:45:22 -0400
Received: by mail-ig0-f182.google.com with SMTP id c1so1816310igq.9
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 16:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=89fuCCoReCTIBAEjrSydFy0X4qlOTJ7ecc+DyK1auXw=;
        b=cUr29u4O5eJqK6EAiZ5ETVR/0rlCQIIJ8WVzi2JJ8OQH3aQ37MvUgMAWqKHhSxmPp8
         4VaXvRvh68j3yJwrV9s5LDOTwtg4ua5HktsPvpKcWglFLnVNHOKU7R7vbnTdgcp0lbKy
         vlnMlOssnGG70QBMRXzcUecEQMAlA7W6q01YQsF6Z1aVqlLCUaQnN358Jke87GpVz9La
         qgqgNZQZVJ7wyIIH4297S9hvmcaKqEcUb+NlHJGBBIe2oYDgKsl/tD5s3gasHwC1YYif
         xdFjvI1rduBlBlSGorADByZKA3gSc3yL04fsQiRm42ITVuwI7nhDejFh02818NuNZGUC
         mqRQ==
X-Received: by 10.42.65.3 with SMTP id j3mr16238745ici.65.1407541521263; Fri,
 08 Aug 2014 16:45:21 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Fri, 8 Aug 2014 16:44:51 -0700 (PDT)
In-Reply-To: <xmqq1tsqk4m4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255070>

On Sat, Aug 9, 2014 at 5:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * nd/lock-paths-absolute (2014-08-01) 3 commits
>  - lockfile.c: store absolute path
>  - lockfile.c: remove PATH_MAX limit in resolve_symlink()
>  - lockfile.c: remove PATH_MAX limitation (except in resolve_symlink)
>  (this branch uses rs/strbuf-getcwd.)
>
>  Will merge to 'next'.

You may want to hold this back for a while until Michael has a chance
to look and decides what to do with it and his mh/lockfile series.
-- 
Duy

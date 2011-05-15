From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v3] Add log.abbrevCommit config variable
Date: Sun, 15 May 2011 09:25:13 -0400
Message-ID: <BANLkTimm6Z8bRyM=_=mDRp2CZ6pypP54AA@mail.gmail.com>
References: <BANLkTi=og+e6JW8t+sCvkFJUnR=SrFtWGg@mail.gmail.com> <1305413341-56450-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <junio@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 15:25:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLbKR-0007tK-Ol
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 15:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754621Ab1EONZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 09:25:44 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57145 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762Ab1EONZn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 09:25:43 -0400
Received: by pwi15 with SMTP id 15so1771490pwi.19
        for <git@vger.kernel.org>; Sun, 15 May 2011 06:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=0fxhP3/6pf0WtDsi1sikxYpIFyTA3TdI3ZVQHt6zInI=;
        b=uayR7P3httGKguIOOa5+bTOD1wJoc9lud6jNVUaieS+GilQrMhMS8yrG3n3edFtaLq
         r2gxxdeMQRWnZirr6xqE4A1YeYXyCOV54dc5UDM1WuHRgHTXYM76raXGCohPaAEDIuJ2
         frIWg7USlojJJKixDdjBS11VJV49oAfhnwwb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=VQdAoAQKKL6YmkOsVjD1Jua08p6GFGLZ2eNTZqUsVnV6Rs6bCVNX2j2wO0tRim79jL
         FwhBhVYs5DDX+KkCuuTtPpRs64pguKwng8DwlqSYBuZedvQDKQ/WYh+pWaJsCXvdvcul
         dernlN9x1QaUgBSpUw3jqX9aOaTyHhB0/Aq78=
Received: by 10.142.55.16 with SMTP id d16mr2236045wfa.27.1305465943062; Sun,
 15 May 2011 06:25:43 -0700 (PDT)
Received: by 10.142.174.16 with HTTP; Sun, 15 May 2011 06:25:13 -0700 (PDT)
In-Reply-To: <1305413341-56450-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173635>

On Sat, May 14, 2011 at 6:49 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> Add log.abbrevCommit config variable as a convenience for users who
> often use --abbrev-commit with git log and friends. Allow the option
> to be overridden with --no-abbrev-commit.
>
> (Also, a drive-by spelling correction in git log's short help.)
>
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
> Changes from v2: ignore log.abbrevCommit when given --pretty=raw

Which I meant to mention in the commit message. Updated commit message:

---

Add log.abbrevCommit config variable

Add log.abbrevCommit config variable as a convenience for users who
often use --abbrev-commit with git log and friends. Allow the option
to be overridden with --no-abbrev-commit. Per 635530a2fc and 4f62c2bc57,
the config variable is ignored when log is given "--pretty=raw".

(Also, a drive-by spelling correction in git log's short help.)

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>

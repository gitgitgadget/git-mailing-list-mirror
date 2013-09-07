From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] git_remote_helpers: remove little used Python library
Date: Sat, 7 Sep 2013 22:14:07 +0200
Message-ID: <CAGdFq_jkFMz4a_jnt3kzyWLO-ZOwLxAMTdJN-6T2R7NeHQxnyA@mail.gmail.com>
References: <23afa908bb2e21779ea96da8c149dcc43aa72eda.1378570768.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Sep 07 22:14:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIOuC-0000Hh-Kh
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 22:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940Ab3IGUOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 16:14:48 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:60525 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834Ab3IGUOs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 16:14:48 -0400
Received: by mail-ie0-f170.google.com with SMTP id 17so756977iea.15
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 13:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=j+SeuiXrmyYgP9dMOX3eBvuBnKa5IIBqKwjxtrt15KE=;
        b=WLCMJ8lEGzeqnxHlNQqlrD8hcqwr9wDGvciRq2IUxa11U1H3XmbfuEBRXUU5vInciE
         ma63TRT8gban+hRmG4REEz73Ncp5AjZTr8ySETpAY81ceBOJ+GQ47HD1nUsgS2LTC+WR
         EvUeIh+YTZzOhDTheqvq1OH6ZNqPUoNWlWXwVnelUXSMks9uazPMM++Dk46i8CrAL1na
         5hoeqyrn6eYcO7mSiUt6v9ZuizeY6LqgnBalR8QnF65rz+PclJBbEAkHqcvqsKXy0Gxc
         JmaJfdmgjII8rz6f1peXPNirGYJ9X7u3mplRTA8KUHYKb67dsLCOINV4cGh6ZDVE3zIB
         z38w==
X-Received: by 10.50.128.49 with SMTP id nl17mr3051757igb.38.1378584887447;
 Sat, 07 Sep 2013 13:14:47 -0700 (PDT)
Received: by 10.50.230.37 with HTTP; Sat, 7 Sep 2013 13:14:07 -0700 (PDT)
In-Reply-To: <23afa908bb2e21779ea96da8c149dcc43aa72eda.1378570768.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234142>

On Sat, Sep 7, 2013 at 6:19 PM, John Keeping <john@keeping.me.uk> wrote:
> When it was originally added, the git_remote_helpers library was used as
> part of the tests of the remote-helper interface, but since commit
> fc407f9 (Add new simplified git-remote-testgit, 2012-11-28) a simple
> shell script is used for this.

Acked-by: Sverre Rabbelier <srabbelier@gmail.com>

-- 
Cheers,

Sverre Rabbelier

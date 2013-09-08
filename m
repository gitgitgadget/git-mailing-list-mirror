From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] git_remote_helpers: remove little used Python library
Date: Sat, 7 Sep 2013 20:10:07 -0500
Message-ID: <CAMP44s1cUdy8rOU7GUAbFfdMsM7+=_DEDSXGh8hK1CT+0E53qg@mail.gmail.com>
References: <23afa908bb2e21779ea96da8c149dcc43aa72eda.1378570768.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Sep 08 03:10:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VITWG-0000Mz-NF
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 03:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117Ab3IHBKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 21:10:10 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:56054 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064Ab3IHBKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 21:10:09 -0400
Received: by mail-lb0-f178.google.com with SMTP id z5so3985935lbh.37
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 18:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=A7ur4n3tVEwTx+c1wopfR0zK3iibvy1y9akhtSVJFiY=;
        b=03+Ct+aO/r7e8GTyMiek3EWwjmAbsCeGY4jQXBDP5fxHwOcwK2KMF6j+kCIxWsL84y
         Bmmz9KMqzQcxhF6m88AbpyO94TjcokU1LE2hvi2eF7uVYIlGtCsclhrCIn0hc8ZARqOV
         mkbwdPy+BAQp/IXTg+YUi++D+V+lViCluGk2ODAurKBpsy9Lzk6G+ekQsRzFzlXq0OBY
         rqcJ/hTDIHPvQpkhkPmVfBudRSNkRV3CsNbCsJhBYTcaPVHnLkfbi1FeeQ8S08AJ74h/
         VJZKPfsBwwDB9952VYVKnqJqXe8EVlojD4mKiiM9Nhs8Z65iqW1lkPW/DYC0c82AGbLt
         TRNA==
X-Received: by 10.152.116.7 with SMTP id js7mr9319188lab.11.1378602607982;
 Sat, 07 Sep 2013 18:10:07 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 7 Sep 2013 18:10:07 -0700 (PDT)
In-Reply-To: <23afa908bb2e21779ea96da8c149dcc43aa72eda.1378570768.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234156>

On Sat, Sep 7, 2013 at 11:19 AM, John Keeping <john@keeping.me.uk> wrote:
> When it was originally added, the git_remote_helpers library was used as
> part of the tests of the remote-helper interface, but since commit
> fc407f9 (Add new simplified git-remote-testgit, 2012-11-28) a simple
> shell script is used for this.
>
> A search on Ohloh [1] indicates that this library isn't used by any
> external projects and even the Python remote helpers in contrib/ don't
> use this library, so it is only used by its own test suite.
>
> Since this is the only Python library in Git, removing it will make
> packaging easier as the Python scripts only need to be installed for one
> version of Python, whereas the library should be installed for all
> available versions.

For the record, there was a user of this:
https://github.com/msysgit/git/tree/v1.8.1.msysgit.1/git_remote_helpers

However, in the latest msysgit master it seems the git-remote-hg
helper is gone, I don't know if by mistake or what. Johannes
Schindelin made many claims about it being more complete and what not,
but who knows what actually happened.

-- 
Felipe Contreras

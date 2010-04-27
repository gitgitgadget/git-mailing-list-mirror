From: Tor Arntsen <tor@spacetec.no>
Subject: Re: Git and cvsimport
Date: Tue, 27 Apr 2010 13:58:01 +0200
Message-ID: <r2xd2d39d861004270458v2e1cb73by78f53d71103b47e6@mail.gmail.com>
References: <i2l717f7a3e1004260727wd87900a5tcfb61a3142d0ba@mail.gmail.com>
	 <4BD69450.8040608@drmicha.warpmail.net>
	 <l2w717f7a3e1004270341lea6cfe2aqdf8d2b490b1ec067@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Marin Atanasov <dnaeon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 13:58:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6jQa-0003UA-Oh
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 13:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240Ab0D0L6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 07:58:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:25507 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690Ab0D0L6C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 07:58:02 -0400
Received: by fg-out-1718.google.com with SMTP id d23so3126447fga.1
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 04:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=pcAQRWp9h9hGz4+/ANePmdOYN5e7rOF+2KGkFMwVtgs=;
        b=IlXB9/P6S2h3fH9l7u38QMwvGWGOTBuH7nTAarZL3yFTt9khOU5SxjjL39t5q3Ht6q
         PI6OrWL1cu1dYyTNa3sfTsoHq2fJyEKgVd+TGIuWpDL4QkF0RlZ4M1rtn/HEXiRQZ4mz
         AWYOTNJ9TbEdH2xkZNhrRFj8OBYq94of7+M3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=VOUqHFz9PejebidMW9TqUgvODQrXkUpa5iKq5ucxNj8j7GshLVlVj8oHz+D6XWxJHs
         PkrHtM65mjwUCbRx0/EaXJs7c3fNPbDA8HN3lGkf3ESrhgyVxVmN4wvIO1nXBLw8bQOh
         HIEczs4umBs0q3o/wzf4LIo1cTKPr2RivXWs0=
Received: by 10.239.158.207 with SMTP id v15mr538865hbc.101.1272369481357; 
	Tue, 27 Apr 2010 04:58:01 -0700 (PDT)
Received: by 10.239.179.197 with HTTP; Tue, 27 Apr 2010 04:58:01 -0700 (PDT)
In-Reply-To: <l2w717f7a3e1004270341lea6cfe2aqdf8d2b490b1ec067@mail.gmail.com>
X-Google-Sender-Auth: 26693f627bd5d1e1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145899>

On Tue, Apr 27, 2010 at 12:41, Marin Atanasov <dnaeon@gmail.com> wrote:

> Perhaps I didn't explain better what I want to accomplish :)
>
> I want to convert CVS repo to a Git one.

But the above statement..
[..]
> What I want to do is to checkout from CVS the files which are tagged
> RELEASE_1_0 for example, and then import the files to a Git repo.
> Files tagged as RELEASE_1_0 differ from HEAD files, so I want only
> those files with that tag for example.

.. seems to be in conflict with the above paragraph. Files tagged with
RELEASE_1_0 sounds like a revision tag (i.e. not a branch). If you
want to checkout that snapshot and insert into a Git rep you could as
well just 'cvs export -r RELEASE_1_0 <module>; git init; git add .;
git commit'
but that obviously won't give you any CVS history in the Git repo.

Is RELEASE_1_0 instead a branch tag? I.e. a CVS branch?

-Tor

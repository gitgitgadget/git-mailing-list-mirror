From: Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com>
Subject: Re: patches between different repositories
Date: Mon, 3 May 2010 19:04:13 +0100
Message-ID: <q2x86ecb3c71005031104xff08ab8am9a14bb49ebcd154f@mail.gmail.com>
References: <hrn27j$e3b$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Matthias Lehmann <mat@matlehmann.de>
X-From: git-owner@vger.kernel.org Mon May 03 20:04:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O900W-0006Qk-2j
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 20:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755656Ab0ECSEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 14:04:34 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55044 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755605Ab0ECSEd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 14:04:33 -0400
Received: by pwj9 with SMTP id 9so1324913pwj.19
        for <git@vger.kernel.org>; Mon, 03 May 2010 11:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        bh=GXXjnDATOv59ChcIp04oPtKhMR0gHVJlGQsSU3UOj6c=;
        b=RIm+DYtw8BlV28ObqQEwDCcCcm4oHmddExXGze7wZh/AKGN8VXn7ds9pUTz5gUsJoq
         OYfrwqLiJDKg3CXbo+bh0ll0I7YdBJ1fubVAK4w0l/h80yUZWXvOlT/bco1oVSQtD+VV
         /a0vknop5PLpNm82HQH3S4DrrXIz2wX/DmpV4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=jRpVWVuBTNvl7wIGiyimjHT2EJr5/L2Hq/he3m2C4Lvy1li6eqJENSUQsZyArPfALW
         H8Tb9zNiGDkIWhKW97si3gwJCmWyjzSGw0JtBion5r84ppEXP7iJllFLnT6emzLRNXqL
         NQigZ9Ty2F1ypc2Kj8/IqkdsjKZY9JLQFihnI=
Received: by 10.143.27.16 with SMTP id e16mr9217182wfj.24.1272909873147; Mon, 
	03 May 2010 11:04:33 -0700 (PDT)
Received: by 10.142.191.1 with HTTP; Mon, 3 May 2010 11:04:13 -0700 (PDT)
In-Reply-To: <hrn27j$e3b$1@dough.gmane.org>
X-Google-Sender-Auth: 18e59129e2ecb187
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146246>

On 3 May 2010 18:47, Matthias Lehmann <mat@matlehmann.de> wrote:
> Am I doing something wrong here? Or is there another way to merge changes
> within different repositories with differnt layouts?
>
> Any help would be greatly appreciated.

Try sub-tree merge after the initial setup you will get another
repository as a subdirectory after that you can commit moving files
around to match different layout. After that you can just pull & merge
and everything will just work =)

Read $ git help merge

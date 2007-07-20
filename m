From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: qgit: failed assertion involving unapplied stgit patches
Date: Fri, 20 Jul 2007 19:45:45 +0200
Message-ID: <e5bfff550707201045s270e0ae1p206ad62cd02ebea4@mail.gmail.com>
References: <OF2EB5CD3A.5A6F9DF7-ONC125731E.004BD62A-C125731E.004FCEC9@sagem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@yahoo.it>, ydirson@altern.org,
	git@vger.kernel.org
To: "Yann DIRSON" <yann.dirson@sagem.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 19:45:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBwY3-0001Sg-8h
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 19:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763649AbXGTRpr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 13:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758032AbXGTRpr
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 13:45:47 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:5895 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595AbXGTRpp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 13:45:45 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1071596wah
        for <git@vger.kernel.org>; Fri, 20 Jul 2007 10:45:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sT3oVTH+/WGZRKB7woddGbclljzmMyT2OgJiih2Y5ledSzNb3ZHwdl9qWDc1yew4eV1cs8YTrdHQ0hPVJoB1yu+52FkWRhsVhK0pQKYaoejHfZ8vFF/9AOtFIY2is5CMJ9t/07Xu7dHu7IjJCL6XEAg2mYZJNrOagxHpKoYFrJE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P0urjtm0U/VSQrI/QyoPHfs5dtGr9TbzTH++6LI4fZ1pFU/rfQKrauX3RIjgNB/1QVYwXdt2pbOZfxnnutXM85WnfFTURTr8LsbylGBEJDEirJ9Ax3+VuFFmUYDyDbi/n9AqbrjKvcMj/U2CcoZVqZWB7Bot5mf3mwMZp8FnrgQ=
Received: by 10.114.92.2 with SMTP id p2mr683484wab.1184953545207;
        Fri, 20 Jul 2007 10:45:45 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Fri, 20 Jul 2007 10:45:45 -0700 (PDT)
In-Reply-To: <OF2EB5CD3A.5A6F9DF7-ONC125731E.004BD62A-C125731E.004FCEC9@sagem.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53104>

On 7/20/07, Yann DIRSON <yann.dirson@sagem.com> wrote:
>
> qgit 1.5.6 cannot show me the blame window for a given file, it complains
> with the following errors:
>

Hi Yann,

Yes. I confirm it's a bug.

A patch has been pushed both for qgit 1.5.6 and for new qgit4.

> However, I'm not sure why it walks this part of the tree, since the
> per-file history view does not show unapplied patches (it would be great to
> see them, though, as well as showing applied patches as such).
>

Regarding to show unapplied patch it seems a little bit difficult
because git-log /git-rev-list does not know them, after a quick look
it would seem easier to me to show applied patches as such...I will
investigate.

BTW if you use file history viewer I would suggest to switch to new
qgit4 (git://git.kernel.org/pub/scm/qgit/qgit4.git) it requires Qt4.3
but annotation is much more powerful, follows file renames (check
against vastly renamed git repository files) and it's an order of
magnitude faster.

Marco

From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGIT PATCH] Add safeguards to Git::userInfo()
Date: Tue, 7 Oct 2008 18:50:46 +0200
Message-ID: <e5bfff550810070950j66bbb980vc26bd50a5615d44@mail.gmail.com>
References: <48EB10C8.4070009@lyx.org>
	 <e5bfff550810070410t1097ace4pf401821292fd7565@mail.gmail.com>
	 <48EB49B3.1090509@lyx.org>
	 <e5bfff550810070457i702c2935lfcc0b60ae3df4dc4@mail.gmail.com>
	 <48EB5FAF.4080303@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Abdelrazak Younes" <younes@lyx.org>
X-From: git-owner@vger.kernel.org Tue Oct 07 18:53:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnFn3-0007ib-Sb
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 18:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243AbYJGQus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 12:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754268AbYJGQus
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 12:50:48 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:21192 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243AbYJGQur (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 12:50:47 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2867028fkq.5
        for <git@vger.kernel.org>; Tue, 07 Oct 2008 09:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=riG/dJBm/xXmc9GY2xvuVo/ySe5FAyyHoUem2gDbzz0=;
        b=A9vbzclJwgLCgpv7DRA4bIcJ6hnHbJDER4Z7vv0KFF72AiNaxu0ciRFsoeq1YyLe6f
         QMvk2b+gpKCu9kJuu+7iMFuEgQK/wUaph+5b7IcJxq/gbPqCCP6P8yfhtXiNkZA1mRkJ
         BGlaztjdQTVdWrUNepl/COphecvJd/FWRCDK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=aC9jDxCmBxpthUHWijMw4JgAAMt7oPk/bIODuQNBNxRKO7ZOWFlgQkXZqHnf0fg5yk
         5YYaCkfrz0dvP9+bAMNRUW18DmxayhsBb71sOk60syuvj+rXX3Nnw29a+tj4HpDyBILC
         ZsXN9F+EXinz2Zh0y8ZQ5E+4tZjSTVsRYIQ3c=
Received: by 10.180.209.8 with SMTP id h8mr5176599bkg.10.1223398246265;
        Tue, 07 Oct 2008 09:50:46 -0700 (PDT)
Received: by 10.180.220.15 with HTTP; Tue, 7 Oct 2008 09:50:46 -0700 (PDT)
In-Reply-To: <48EB5FAF.4080303@lyx.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97727>

On Tue, Oct 7, 2008 at 3:10 PM, Abdelrazak Younes <younes@lyx.org> wrote:
>
> OK, with this patch, I see that the local config request is apparently
> successful even though the 'user' and 'email' strings stay empty.

An empty user and email it does not mean failure. Again, I would think
that is git config that returns no data (without failing) if it is run
from outside git directory.

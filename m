From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Git merge selective files
Date: Tue, 9 Jun 2009 21:35:58 +0200
Message-ID: <81b0412b0906091235g7a65d076l145c3eb3cbbdce3@mail.gmail.com>
References: <34b359190906090253v653ecc71q6684f4ebff2be59d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: joe higton <draxil@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 21:36:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME77r-0006eh-Cp
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 21:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755474AbZFITgA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 15:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755326AbZFITgA
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 15:36:00 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:50712 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755051AbZFITf7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 15:35:59 -0400
Received: by bwz9 with SMTP id 9so243826bwz.37
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 12:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LckphMfwbhP7oMSGrqMjFViwMjXlRWVPNciLojxwsuU=;
        b=QX01iCT3EgZNUBQV8mFMFfMBU+N7gij1kIMDEJLgUfMAMf3PhVBP9AoznK1BpDKdNe
         nXJxaQPtGLxyd7zIxyDJoeT/JTVLKdfJMviwkVF37hjkhsm2/7moxRqnL0+mrhgYA9pc
         HhCgIQKk7xO/i9x4ThEfbfCnSzhW/BfkHnBQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aHI7G6Xk7VcQLR+xr1FyFLeL4IjzumqWHc8nN5a2+c5WrkadST8QeyVVWJQ624Wjut
         cn5L6tteHw6Dgzq8pj/DDEFpPYLDrbghanr2wqkJ57E5z2DCaYwSbLyiw8CmXKbd2p9r
         FDpCvZviy/F7a/cj6msCARdYIB31WxLc4VSSk=
Received: by 10.204.124.10 with SMTP id s10mr447002bkr.34.1244576158298; Tue, 
	09 Jun 2009 12:35:58 -0700 (PDT)
In-Reply-To: <34b359190906090253v653ecc71q6684f4ebff2be59d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121211>

2009/6/9 joe higton <draxil@gmail.com>:
> Hi,
> =C2=A0 =C2=A0 I want to merge changes from a branch but only to one f=
ile, I
> don't want to pick up the changes from other files. I've scoured
> google and the docs a bit but I can't find anything useful. Is this
> possible?

Generally - no. But you can have a merge with only the content
of your choice:

  git merge -s ours --no-commit other

then copy the changes you need manually, and commit.
See the manpage of git merge about "ours" merge strategy.

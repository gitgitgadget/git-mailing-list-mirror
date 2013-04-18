From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Thu, 18 Apr 2013 17:16:28 +0530
Message-ID: <CALkWK0ncfuzuYSKjkT2uQy4dGR=TSnHoJNdhU9ownDUytysL6w@mail.gmail.com>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org> <CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
 <7vip3npet0.fsf@alter.siamese.dyndns.org> <CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
 <8761zm4wzg.fsf@linux-k42r.v.cablecom.net> <CAMP44s0a2VsPBMd9Vrrhwdw=SPp2HrvDdXZ9Dmzhr9A6T+Sz7w@mail.gmail.com>
 <CABURp0qGYG4T+t36=Us328YdLzy9KjBOWot2gSOk=FgCRUCLnQ@mail.gmail.com>
 <CAMP44s3pZt3QVjS7GbXqjMS4ti3p=Vs2DmFXQjsMM3rs9qURmw@mail.gmail.com>
 <CALkWK0nji4m0zJPf_s0G5jfWaAN_RTGFZ6dSxfahq2OcRsu5xQ@mail.gmail.com>
 <CAMP44s1RpgM5U0ySsof_sgEHNS1p-seQ=ciVCth9gOJMG0cpHw@mail.gmail.com>
 <CALkWK0krWM4kJ5GTnQ2SL7HoNfNMNA0-xdRVbeatAFpyKW_RtA@mail.gmail.com> <CAMP44s0KW4_Q6-d-3=M7GzWmHwy4H--FcemK4UF5FS0t3wnOgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Hord <phil.hord@gmail.com>, Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 13:47:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USnJ5-00060H-Ay
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 13:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967138Ab3DRLrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 07:47:10 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:42172 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967124Ab3DRLrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 07:47:09 -0400
Received: by mail-ie0-f179.google.com with SMTP id 16so3140461iea.38
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 04:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=W5KySW+TocJCTcbwT9l+c9mQiGOHdrJI+yn5lltPB/I=;
        b=RzlCala+hge2pkItiPrtoTiB/RlnOwC9BgdZ1CzUHi3d1xUBR8aqo45bEU+s7fBUsa
         I83Vzplmb+ppztVaz6dJGP9BjurZa2ly4bRRiA/hDAphbEK2tw50JR7jJqZZ+dCi+6fO
         vPBULghNwb+p1SMy6sp/sHdY83M8/Zcqb1hadRfYdnujCfZ1z65QhDmDoMrEc0PMxeop
         L4HtHylIiVOvhWwiYhQbTKzc1QiGT86Sr1D7gql/agAAerkolVqojClniiQIqsYzN4h2
         i2EafCpBBxw7S35jc6RWqBgCUKtPsyDB51atoBlOKBeALq6lNHySe2lXrma2srEIby9r
         ISwg==
X-Received: by 10.50.108.235 with SMTP id hn11mr6363795igb.107.1366285628814;
 Thu, 18 Apr 2013 04:47:08 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Thu, 18 Apr 2013 04:46:28 -0700 (PDT)
In-Reply-To: <CAMP44s0KW4_Q6-d-3=M7GzWmHwy4H--FcemK4UF5FS0t3wnOgg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221653>

Okay, one more segment needs to be responded to.

Felipe Contreras wrote:
> If remote-hg wasn't available for users, they would be hurt; if stash
> wasn't available, if rebase --interactive didn't exist, if there was
> no msysgit, if it wasn't so fast, if the object model wasn't so simple
> and extensible; users would be hurt. And if users didn't have all
> these, there would be less users, and if there were less users, there
> would be less developers, and mercurial might have been more popular,
> and most repositories you have to work on would be in mercurial, and
> you might be developing mercurial right now.

Flawed logic.

A large number of users doesn't automatically imply good software with
lots of features, or even a great development community.  A great
development community leads to great software.  And great software
leads to lots of users.  Sure, there's a feedback loop pushing users
to become developers; but it doesn't start with users of vaporware,
leading to more developers joining the effort to turn that vaporware
into a great product.

Life doesn't begin with users.

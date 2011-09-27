From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Re: [PATCH] Docs: git checkout --orphan: `root commit' and
 `branch head'
Date: Tue, 27 Sep 2011 23:44:33 +0000
Message-ID: <CAMOZ1BtoaUrk4e4qBtaZLKJWud+_zi-h3WDpRHRXVpW4W-5F4A@mail.gmail.com>
References: <7vaa9r2jii.fsf@alter.siamese.dyndns.org> <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <e88b6e560cab4ed1937dd191b4180387-mfwitten@gmail.com> <4E81F080.7010905@drmicha.warpmail.net>
 <CAMOZ1BsvnZ7PyfjOJURX+B7vCZcYheLS4pissGvPNjEivbYXtw@mail.gmail.com>
 <7v39fhyk21.fsf@alter.siamese.dyndns.org> <4E823359.7080602@nextest.com>
 <DBCBE20265964ECCA5B9724DAC74D83B@PhilipOakley> <20110927214213.GC5176@sigill.intra.peff.net>
 <CAMOZ1BvzWDPQ_e3Y5H8CX4wQwL5xf3xVvZvRL3gQPcB_kCGBbw@mail.gmail.com> <20110927233549.GA10434@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Oakley <philipoakley@iee.org>,
	Eric Raible <raible@nextest.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 28 01:45:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8hKr-0003cn-4k
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 01:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049Ab1I0XpG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Sep 2011 19:45:06 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37320 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab1I0XpE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2011 19:45:04 -0400
Received: by iaqq3 with SMTP id q3so6250611iaq.19
        for <git@vger.kernel.org>; Tue, 27 Sep 2011 16:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=B3KsDWnq4j7sFJIGMey8UMNkDolfMus3JP0W9ablAbg=;
        b=YJZt29L1ihFNlUXdmjZqlFkhAXHzVMfDTRk5qhPkBm83zmT5PcZDl18/OlHw6t84CU
         e46kjWHCtlTVNRWXgq9Eik+WGSFIgbWOZXOhMz4oKJ+nV1NplXUul7a2cF9ZsmQlHlVo
         wkR/spW9EsamD/QrnH48duyHpsQPHl0VAufQs=
Received: by 10.42.18.74 with SMTP id w10mr6904398ica.164.1317167104067; Tue,
 27 Sep 2011 16:45:04 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Tue, 27 Sep 2011 16:44:33 -0700 (PDT)
In-Reply-To: <20110927233549.GA10434@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182276>

On Tue, Sep 27, 2011 at 23:35, Jeff King <peff@peff.net> wrote:
> On Tue, Sep 27, 2011 at 11:28:14PM +0000, Michael Witten wrote:
>
>> =C2=A0 With "git commit --no-parent", you would be altering the curr=
ent
>> =C2=A0 branch head, which means you are potentially leaving as a dan=
gling
>> =C2=A0 commit the commit to which that branch head originally pointe=
d.
>> =C2=A0 I.e., it is about as dangerous as "git reset --hard <new_root=
_commit>",
>> =C2=A0 something for which we do NOT provide any protection.
>
> Didn't I already mention that example? And then say that I think the
> lack of protection there has been the source of a lot of confusion an=
d
> hardship?

Sorry, I suppose you did already mention that, but:

  * I missed it because of the footnote.
  * There is more pedantry to my text than just that.

> Repeating the problems of "git reset" does not seem like a good idea =
to
> me. Especially not with a command like "commit", which is usually ver=
y
> safe.

I think that "git reset" is confusing and dangerous for more
fundamental reasons: It's another one of git's bizarre, poorly
chosen abstractions on top of the working tree and index.

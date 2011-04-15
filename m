From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: gsoc - Better git log --follow support
Date: Thu, 14 Apr 2011 23:06:49 -0500
Message-ID: <20110415040649.GA25780@elie>
References: <AANLkTi=n7e70UqYU+6wpG4cu95fsg39tVM6=7fpfdZFz@mail.gmail.com>
 <BANLkTik7t=Tfh_Y_+swnaAWyetfy8MU6VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?Q?Micha=C5=82_=C5=81owicki?= <mlowicki@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 06:07:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAaJF-0004VQ-Hk
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 06:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089Ab1DOEG7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Apr 2011 00:06:59 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48338 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923Ab1DOEG4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2011 00:06:56 -0400
Received: by iyb14 with SMTP id 14so1926065iyb.19
        for <git@vger.kernel.org>; Thu, 14 Apr 2011 21:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=C9MXsNNse8lJ6Z7FeriRJmSq4ZP5DbnN8jKFZ4ceV08=;
        b=SzLtMpfiA3Vp9vnwJx+T7jkqb94E/IbXHYAJG984fAUqbShKaQLumEbDJXfJ/sZMGr
         XpUrz8lYQxnCKxansQ2GWBmQpMcImkdCxeP52zSd00XSKqycdPeL2P+k6PDyF+zsJ0ag
         PDpTxMBdBFfqNptZ/7hucd+mZ/LiJDBMAax0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=F4CJht47IbyNEueS4V9bcy8lc26dg05vx9CFnlBq6MrcOKbiLb3TjwYMhGlo5iAcZG
         tgUuJi3XDEWzZvtA/A2Mz/u0FOM0ELgZPplccmnmK8UPvDDzJGDNhh2uWrQz+HdQl4Kd
         xHZEBdGhYtR3WWTSnC4Q285HRR6TpAT7p8yQ0=
Received: by 10.43.45.193 with SMTP id ul1mr2047047icb.211.1302840416355;
        Thu, 14 Apr 2011 21:06:56 -0700 (PDT)
Received: from elie (adsl-69-209-64-230.dsl.chcgil.ameritech.net [69.209.64.230])
        by mx.google.com with ESMTPS id f28sm1566043ibh.16.2011.04.14.21.06.53
        (version=SSLv3 cipher=OTHER);
        Thu, 14 Apr 2011 21:06:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTik7t=Tfh_Y_+swnaAWyetfy8MU6VA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171586>

Hi,

Micha=C5=82 =C5=81owicki wrote:

> 25.04 - 15.06
> 1) study the revision walking code
[...]
> 2) study the pathspec matching + limiting and rename detaction API
[...]
> 3) figure out what state --follow will need to maintain, where it wil=
l
> fit into the revision walking process and design new architecture for
> it

Ideally this should happen in the next couple of days, rather than the
next couple of months.  Otherwise the project would be an unknown and
it would be hard in good conscience to accept funding for it.

That said, I am personally willing to help out in the next few days
(to help put a solid proposal together) and throughout the summer (to
fix git log --follow) regardless.  I will be very happy when --follow
works reliably.

> 16.06 - 26-08
> 4) implementation
>
> I plan to spend about 2 months for the first 3 points. It's all about
> poking the right developers and sending question to the mailing list.

It's hard to say how the process of studying code works.  Certainly
asking a question can be a good way to start, and reading code can
lead to more questions.  Another strategy that can work well is to
take the plunge and see what effect changes to the code have.

> I'll try to send some updates soon when I get through some basic
> lecture and the most important code.

Ok.  Remember it's okay to ask for help (though of course not so great
to demand it) if you get stuck or have no idea where to start on
something.

> Any suggestions/ideas are as always welcome. Be prepare for many
> questions from my side :)

Looking forward to it.  If we end up with better technical
documentation as a side effect, all the better.

Regards,
Jonathan

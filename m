From: Dario Rodriguez <soft.d4rio@gmail.com>
Subject: Re: Revert a single commit in a single file
Date: Fri, 25 Feb 2011 12:19:15 -0300
Message-ID: <AANLkTi=VJpTpAiLXohDi19ZsZVs5RP3s61DyoriCJnaa@mail.gmail.com>
References: <AANLkTikpdGfAAUMu_7DfA-GRUv7gKn5Yc9RnJwo2iKoM@mail.gmail.com>
 <AANLkTimLRc4LybUvmD2ZCKfQqEP+vr+2aBnb4n3B+Mb2@mail.gmail.com>
 <4D67A293.2050306@drmicha.warpmail.net> <AANLkTimqszvGjVeJHKLPWicDugeOuqbgO1+wy5BO-AE0@mail.gmail.com>
 <4D67A92D.2000300@drmicha.warpmail.net> <AANLkTikb_mWdgF4gf6FEBF=CLxLeefJJkRgDzEB5=3SO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Thomas Ferris Nicolaisen <tfnico@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 16:19:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PszSH-0005Tb-En
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 16:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753768Ab1BYPTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 10:19:36 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54635 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066Ab1BYPTg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 10:19:36 -0500
Received: by iwn34 with SMTP id 34so1165355iwn.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 07:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=TEd1AyFAjXbVisGYC6Njk7bzEtZnsUDv6Wv345NECn8=;
        b=iffP+c1znQZidlVawQvQclnBhRhvbfnbdKWkfAsVZxqfX0v6pxVc1osyfzlQWsDYl7
         WpJf3my3wfyUFz7qXWKMZOON4QweOeDf/kzbMM3zusZK4JuGLVG5y0iZRJav78QNalNh
         rGFIPkFD5uUwGqg/sAZJP4bAVtJYEI6YrheNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=aHMHkBFdS8A8jeqJuZ4RwgEX5STo1/oJ/tGu/6s239Fu5yr+6qmUBPD+AOH2kYmQSE
         PcY/Ly5eOoFINnUMj55i78vmw1dFCkWcYZzCBxLtRyNIhUhuVlfAk0CHnXqHI7fbh8qj
         Fx/+chZ96pIsIOZ3Qa2Rhev8+IU0Mih8GXf94=
Received: by 10.42.219.65 with SMTP id ht1mr870072icb.393.1298647175108; Fri,
 25 Feb 2011 07:19:35 -0800 (PST)
Received: by 10.42.53.194 with HTTP; Fri, 25 Feb 2011 07:19:15 -0800 (PST)
In-Reply-To: <AANLkTikb_mWdgF4gf6FEBF=CLxLeefJJkRgDzEB5=3SO@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167911>

Michael, my comment was about "reverting the changes from the old
commit, but only for specified path/file", sorry about non quoting it.

I think that ''the old commit" is HEAD~1, so reverting it is about
checking out HEAD~2, and commiting the results. The same is for a
given file.

On Fri, Feb 25, 2011 at 11:38 AM, Thomas Ferris Nicolaisen
<tfnico@gmail.com> wrote:
> Dario: Yes, I understand the reasoning. It's not often a problem, and
> when it occurs there are ways to do it. I just thought I'd bring it up
> on the list cause it feels like expected behavior (other git commands
> behave correspondingly).

Yeah, and may be your reasoning is better for the principle of least surprise.

Cheers,
Dario

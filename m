From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 28 Apr 2011 06:11:54 -0500
Message-ID: <20110428111154.GA1433@elie>
References: <7vsjt35l84.fsf@alter.siamese.dyndns.org>
 <20110427234224.GA26854@elie>
 <7viptz5j82.fsf@alter.siamese.dyndns.org>
 <BANLkTi=w0aKH6dxu84i4DjkL-vNCWQi8pw@mail.gmail.com>
 <alpine.DEB.2.00.1104271751300.940@asgard.lang.hm>
 <BANLkTimnkBMRH7Spj1ByQRa9YdV9w+bwtQ@mail.gmail.com>
 <BANLkTikbcpzF203rUVB05OYyYhLmu3+n6w@mail.gmail.com>
 <BANLkTinQny-M0rL+Vs9L_cQhtVLyv6rqMw@mail.gmail.com>
 <4DB9329E.7000703@op5.se>
 <BANLkTikKp9-uFGLavBT0UA5+maV5xiEJZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <gitster@pobox.com>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>, david@lang.hm,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 13:12:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFP8j-0004VW-CE
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 13:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757679Ab1D1LMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 07:12:03 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58419 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754950Ab1D1LMC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 07:12:02 -0400
Received: by iyb14 with SMTP id 14so2108586iyb.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 04:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=SLnX/sVd3oSqmepGiOJNm7XFXco29rllAsa+LT4P/Y4=;
        b=GMtO18dhv0Vki3BEDwtm0+arixh6xA/HLcjFh/Qrlvjierx+RCJ+0oijuz9gej5cxq
         Ux+89w2+RaHjJbptP/CEpvLpSg0OHHjpFFvzKW0T17Frvao8se3/UMTbETnQaT4mV6/v
         XSAp7PzRe3lqRuWjNyPy066Y96tQcBrjM6y48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=d9PGZ+TMfUvHNRfYpcNnuyMZZ6rEB0e4MSalQGqSusl8c9U1CEi+c4W85F8pfrfRjC
         b1EO6ktHPSfG0UWcPm3z3xmtq+laODCnUCBCe5GvSAbbS6n7Spll2r4uR8fJAdQLIiqf
         qY7TV7aj3m5UzXzOcAZoj7lK+mhu/RSfLiu1Y=
Received: by 10.43.55.84 with SMTP id vx20mr3993630icb.49.1303989120705;
        Thu, 28 Apr 2011 04:12:00 -0700 (PDT)
Received: from elie (adsl-69-209-62-211.dsl.chcgil.ameritech.net [69.209.62.211])
        by mx.google.com with ESMTPS id a8sm682064ibg.31.2011.04.28.04.11.58
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Apr 2011 04:11:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTikKp9-uFGLavBT0UA5+maV5xiEJZA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172351>

Hi,

Jon Seymour wrote:

> What is so  hard about:
>
>   app install plugin.
>
> Forget git. Forget git work.
>
> What is so hard about the concept of
[...]

Is it so important that the people on this list agree with you
right away that your proposal is a great idea?

You asked for comments, so people are giving them.  But typically,
the procedure might be something like:

1. person describes a problem they are solving, and perhaps a
   proposed solution

2. people on the mailing list try to help out in figuring out the
   parameters of the problem, giving relevant background about the
   tools available, and describing experiences they have had in the
   past that might help in solving it.

3. person reports on how it panned out.  If this involved changing
   git or is nicely documented, we might get a patch out of it.  If
   so:

4. people on the mailing list review the patch, considering how
   useful it might be for their own nefarious ends, potential
   downsides, and how maintainable it is.

5. at some point, some patches appear that seem to be a good idea,
   and Junio applies them.

And so forth.  Notice how at no step everyone needs to agree.

Earlier in this thread you mentioned that git needs some basic
facilities to make a prototype of a command installer possible.
But git already has those facilities.  Even if the installed commands
should not be on the path, all you need to get a "git install"
available on early adopters' machines is to put an executable at
/usr/bin/git-install or ~/bin/git-install.

So you can show people what they have missing, and once they can't
live without it, maybe they'll clamor for its inclusion in git.git
proper and distro packages.  If that is your goal, getting something
working and helping interested people to try it out (and adding it
to https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools
when ready) comes first.

Sorry to spend so long on abstractions.  Still, hope that helps.

Regards,
Jonathan

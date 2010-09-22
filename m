From: Joshua Shrader <jshrader83@gmail.com>
Subject: Re: can git-describe learn first-parent behavior?
Date: Wed, 22 Sep 2010 13:45:29 -0400
Message-ID: <AANLkTimMggJtWNifuRCcVCEZ5NSjhdc9dEjftkOtjUOu@mail.gmail.com>
References: <AANLkTi=6o15y-6Q+tn40=hrPf9pmo+Y1Jd97hGxr5mH2@mail.gmail.com>
	<4C987C2E.3060001@drmicha.warpmail.net>
	<4C98830A.70203@viscovery.net>
	<4C989BBD.80106@drmicha.warpmail.net>
	<4C989E6B.1070703@viscovery.net>
	<4C98A0B7.9050501@drmicha.warpmail.net>
	<4C98A645.8070601@viscovery.net>
	<4C98CEA1.2050405@drmicha.warpmail.net>
	<AANLkTinDYae7yxSaRKNwOvkRe3yQ2GCBT=tiXhDe7NVR@mail.gmail.com>
	<4C99A7BB.50401@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Sep 22 19:45:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyTNy-0003E0-Lo
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 19:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390Ab0IVRpb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Sep 2010 13:45:31 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:36388 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096Ab0IVRpa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Sep 2010 13:45:30 -0400
Received: by gwj17 with SMTP id 17so254227gwj.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 10:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5FebAH58cWEx6GmY4da5LrHMpF/qjvgzuozv9NLFgZI=;
        b=Ksfsv+VSqdHaLw0nQ61jfBUeuRKUdINMyoeLlvskAp3w2MPW/AeaENrYky0Oh0fNlm
         nLInM3KsweOycL3h2sLznT7Xv5mjGbnN2iMHsMKKtmGyU8+GIuhKAlrCBe0JPg2qST3h
         qsiOHQRoHJhmGxjkYiEzK/ixvFsfO4Yuwrln8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=N1Pk9tQN2YUbP/+Y+bwY06FEkg3wt/jENYaBQTvciih/4zQeyJ86a4qLkms3C+9oLd
         Lk9gPr8t3CoIGd+m4vPkpKLgqy5G631ecYirqua20E32pdBcps+V6/RNkgz5PouRQq0G
         xx64bH9rtutNXSkTohrlb3J1Pkwb7VVQvU//E=
Received: by 10.151.26.11 with SMTP id d11mr1533285ybj.192.1285177529880; Wed,
 22 Sep 2010 10:45:29 -0700 (PDT)
Received: by 10.151.145.14 with HTTP; Wed, 22 Sep 2010 10:45:29 -0700 (PDT)
In-Reply-To: <4C99A7BB.50401@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156811>

Thanks for the response.  Since my last message, I have been able to
get a tag on the v1.0 branch (although not the original v1.0-stable
tag) to appear in the git describe output when run on v1.1 head, and
thus I do think a --first-parent option would be useful.

On Wed, Sep 22, 2010 at 2:52 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Joshua Shrader venit, vidit, dixit 21.09.2010 21:57:
>> I think I need to apologize to the list. =A0I did not actually obser=
ve
>> what I had stated in my original post. =A0Given the description (and=
 my
>> possibly naive understanding) of git-describe, I hypothesized that
>> what I originally stated was possible. If git-describe is in fact
>> implemented with a first-parent-like behavior, as some people believ=
e
>> to be true, then I believe it is working correctly - I've seen nothi=
ng
>> to the contrary. =A0However, I do believe that the documentation is
>> unclear if this is the case. =A0My interpretation of "depth," which =
I
>> believe to be consistent with the graph-theoretical definition, does
>> imply that what I stated could happen.
>
> Josh, no need to apologize. You simply tried to understand "git
> describe". The mere fact that a Git long time contributor (J6t) and a=
n
> occasional contributor (I) are discussing "git describe"'s behaviour
> tells you that it can't be that easy ;)
>
> The man page says "most recent tag", and that is true, but with a
> definition of "most recent" that you wouldn't expect. The description
> there under "Search Strategy" is wrong, and has been at least since
> 80dbae03. I'll try to come up with a better explanation fit for the m=
an
> page, possibly after writing some more tests.
>
> The intended behaviour is explained really well in Shawn's commit
> message for 80dbae03. And if you look at the algorithm you see that t=
he
> order of the parents (as stored in a merge commit), in particular
> first-parent relationship plays no role at all. The algo takes all
> parents and inserts them in date order into a list to be looped over
> afterwards.
>
> The more I understand the algo the more I realize that --first-parent=
 is
> useful and completely different, and that I can optimize more in my p=
atch.
>
> Cheers
> Michael
>

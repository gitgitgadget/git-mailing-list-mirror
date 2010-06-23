From: Bruce Korb <bruce.korb@gmail.com>
Subject: Re: Newbie question: how can I list added files?
Date: Wed, 23 Jun 2010 12:15:57 -0700
Message-ID: <AANLkTin-MEBUYheTkFbeKIBj5peVV-sPa7hZSg-wMgBi@mail.gmail.com>
References: <AANLkTinxOE5xcP_V-PvoZGlfsxtcCafoYKy_PuBZnQnQ@mail.gmail.com> 
	<7vzkylejbf.fsf@alter.siamese.dyndns.org> <AANLkTikE2ylLXk5XxNGvcvol6R-puSTzPurdLcNMYaZJ@mail.gmail.com> 
	<20100623183050.GA20842@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, GIT List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 23 21:16:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORVQu-0001uL-FQ
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 21:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784Ab0FWTQT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jun 2010 15:16:19 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:65312 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478Ab0FWTQT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jun 2010 15:16:19 -0400
Received: by gwaa18 with SMTP id a18so224317gwa.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 12:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0pIlGaRmMHZmHtSxJJGL+06BrF5MMvp2M7w/itGfJ8w=;
        b=jT10lyfPMH5fG4T0jMt0i30HkUZ7fMi0Yu1EbwLlcOrpwL8cGv7l206G2LI1V5zyM2
         KBamGM7y3U4Iisd4w4xWGU5iDSGC2lZ36eW16E9seJTME9cA55bTObi1uQsHseJm1QUk
         CXy7cFJsXEUJWd0zBP+vKsgdnwMUjnssPd6pM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=HuaEeoPJNa5NPJ1rng41XY5riZehVTEEpiHsBfBPJvfn2QlvP3SKRi9VHMRKZrcjj4
         oBGncoAtrD1P7522qtJyB0skEwKxdVfAkfNQwErc4eCNp+A67YTpFDu2MKOYKA5aPG2H
         DX3qStfjPUaR4BvIfjc5ox0hzXdaqcGoX4Dd8=
Received: by 10.100.245.27 with SMTP id s27mr6752004anh.53.1277320577220; Wed, 
	23 Jun 2010 12:16:17 -0700 (PDT)
Received: by 10.101.107.13 with HTTP; Wed, 23 Jun 2010 12:15:57 -0700 (PDT)
In-Reply-To: <20100623183050.GA20842@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149532>

On Wed, Jun 23, 2010 at 11:30 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Jun 23, 2010 at 10:50:11AM -0700, Bruce Korb wrote:
>
>> On Wed, Jun 23, 2010 at 10:43 AM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>> > "git diff --name-only --diff-filter=3DA HEAD"?
>>
>> Thank you, but "Nope."
>> My added file doesn't show anything and not using the
>> "--diff-filter" thing shows both added and not added files:
>>
>> $ git diff --name-only --diff-filter=3DA HEAD
>> $ git-status
>> # On branch master
>> # Changes to be committed:
>> # =A0 (use "git reset HEAD <file>..." to unstage)
>> #
>> # =A0 =A0 =A0 modified: =A0 sw/embedded/platform/strad/scripts/mk_re=
lsrc.sh
>> [...]
>> $ git diff --name-only HEAD
>> chip/chopin2/up/hdl/.sopc_builder/install.ptf
>> chip/mozart/up_oam/hdl/.sopc_builder/install.ptf
>> chip/mozart2/up/hdl/.sopc_builder/install.ptf
>> chip/mozart2/up_ft/hdl/.sopc_builder/install.ptf
>> sw/embedded/nios2/system/system.stf
>> sw/embedded/platform/strad/scripts/mk_relsrc.sh
>> sw/projects/nios2/modules/system/lib/system.stf

Hello,

"--name-status" just adds "M" in front of that list.

> Usually when we say "added file", it means "a new file which has just
> been added". Did you mean "a file which was modified, but whose conte=
nts
> I have already added to the index"?

I mean a file that was "git add"-ed and thus is now staged.
One would first guess that "git-ls-files --stage" would get what I want=
,
but no, it lists every file in the repo.  Not what I need.

> In that case, I think you just want:
>
> =A0git diff --cached --name-only
>
> to see files that differ between the index and HEAD (i.e., things whi=
ch
> will be committed).

*YES*  That *IS* what I want.  Thank you!!!  Regards, Bruce

P.S. Is it really so rare that someone would want this info that it sho=
uld
wind up being so obscure?  I now have a new alias:

   alias git-ls-staged=3D"git diff --cached --name-only"

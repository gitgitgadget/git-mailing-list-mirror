From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Wed, 4 May 2011 14:35:30 +0200
Message-ID: <BANLkTinLCirA4XP9AOb9piGo9ucMsmrmkQ@mail.gmail.com>
References: <ih1449$ul6$1@dough.gmane.org> <7v62tjs66r.fsf@alter.siamese.dyndns.org>
 <20110120203840.GA11468@sigill.intra.peff.net> <7vbp3bqmiy.fsf@alter.siamese.dyndns.org>
 <20110120215456.GB11468@sigill.intra.peff.net> <AANLkTikBbSt5_WdbuE8a96w1pWBCYLNjMCUCBThjdLdG@mail.gmail.com>
 <7vk4hyp38i.fsf@alter.siamese.dyndns.org> <AANLkTikmbWkpjioARZrmySpLM8t7kqCX0v1+NKibk_ar@mail.gmail.com>
 <AANLkTinRcmevXz3zV0wtxd7+Q3F4zcH2AZOQk1XVxYXa@mail.gmail.com>
 <BANLkTim1gW_L-9DKo9p_VFQFUBUGWAPxoA@mail.gmail.com> <BANLkTinKDHM-RU2wqZECFcjQEoRWADnTGQ@mail.gmail.com>
 <BANLkTimFas5YLt37RLuCppkQ4ZGhmj56Cg@mail.gmail.com> <BANLkTinkR+jEKkno30fiHBZ-PMVvvv7FxQ@mail.gmail.com>
 <BANLkTi=DgXrWZ0ObBYi2mgk-+8w8iXM7VQ@mail.gmail.com> <BANLkTimLnggco_+mQZ2_T_myAHsDD-=g1w@mail.gmail.com>
 <BANLkTikxS-_9h4rBdbbJ2e-RkjMWyiC1Mg@mail.gmail.com> <BANLkTinqxy6jCJLNVPKmMW3CErbfN7Hm=g@mail.gmail.com>
 <BANLkTinJvt=Nnt8YG-D1wpWKbBei+m+4XA@mail.gmail.com> <BANLkTinCSotWC-kbPDJc57NZM29hizYKpA@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Kelly <steveire@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 14:36:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHbJ9-0003Sm-Hq
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 14:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151Ab1EDMfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 08:35:51 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:35972 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355Ab1EDMfu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 08:35:50 -0400
Received: by pxi16 with SMTP id 16so914534pxi.4
        for <git@vger.kernel.org>; Wed, 04 May 2011 05:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=83l6eKEw5VyfdcC0JHADNINT2QZvsQpx8SBVLVEViBk=;
        b=DRhUe89Zbjj96KlSlA0wwNn9c3TZgwvNi4w9JQV72wyaD8dx2XC32WyZSt3Vxl7h18
         hRsDX+EhSIFZrzMiq9+inwUgwz6e54viD0FAirS6vRbjkstNGor51i9PMCh6F11avUoQ
         L1qsD6WtHsv9a7wp0t94NpOXTo7nvb2BmQbAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=NTst5+MnOQO3VZM+9Bpb2b/4oBrldge36AmeJWdQkLmCTgHw22rM7YDpcOvaArJWPt
         /nMA2JGN5Q5ZNRvAXi83/aCv+5zEnsXv1FFI+6cr0E0pFhK9z2Uw6b+gp+bdak0e2gLz
         7LGbGL4XD2q2DoxT1OyGO41RGFhYHwrBwZgR4=
Received: by 10.68.46.165 with SMTP id w5mr460509pbm.516.1304512550144; Wed,
 04 May 2011 05:35:50 -0700 (PDT)
Received: by 10.68.66.98 with HTTP; Wed, 4 May 2011 05:35:30 -0700 (PDT)
In-Reply-To: <BANLkTinCSotWC-kbPDJc57NZM29hizYKpA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172740>

On Tue, May 3, 2011 at 7:54 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Mon, May 2, 2011 at 10:43 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> On Mon, May 2, 2011 at 9:26 PM, Stephen Kelly <steveire@gmail.com> wrote:
>>> Ok, if you can't see in the code why a branch called HEAD might
>>> corrupt the remote and I can't demonstrate it with a testcase, maybe
>>> it's not an issue anymore, I don't know.
>>
>> No, it's still an issue, and I believe I pin-pointed it in my first
>> mail. You can try out the patch I sent, and see if that helps in your
>> case. If it does, I think it'd make sense to do something (preferably
>> a bit more robust) with it.
>
> Yes, I think your patch should be applied regardless, as that solves
> _one_ issue.

OK, I'll send out an RFC with some discussion on the alternatives a bit later.

> But there are other issues.

I guess the root of the problem(s) is that there's no way to
disambiguate 'HEAD'. One solution could be to say that 'HEAD' never is
ambiguous, but it feels a little inconsistent... Thoughts, anyone?

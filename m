From: Stephen Kelly <steveire@gmail.com>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Tue, 3 May 2011 20:08:49 +0200
Message-ID: <BANLkTimHfH-o6Fyoo61xVFxAhELNmD=4xg@mail.gmail.com>
References: <ih1449$ul6$1@dough.gmane.org>
	<7v62tjs66r.fsf@alter.siamese.dyndns.org>
	<20110120203840.GA11468@sigill.intra.peff.net>
	<7vbp3bqmiy.fsf@alter.siamese.dyndns.org>
	<20110120215456.GB11468@sigill.intra.peff.net>
	<AANLkTikBbSt5_WdbuE8a96w1pWBCYLNjMCUCBThjdLdG@mail.gmail.com>
	<7vk4hyp38i.fsf@alter.siamese.dyndns.org>
	<AANLkTikmbWkpjioARZrmySpLM8t7kqCX0v1+NKibk_ar@mail.gmail.com>
	<AANLkTinRcmevXz3zV0wtxd7+Q3F4zcH2AZOQk1XVxYXa@mail.gmail.com>
	<BANLkTim1gW_L-9DKo9p_VFQFUBUGWAPxoA@mail.gmail.com>
	<BANLkTinKDHM-RU2wqZECFcjQEoRWADnTGQ@mail.gmail.com>
	<BANLkTimFas5YLt37RLuCppkQ4ZGhmj56Cg@mail.gmail.com>
	<BANLkTinkR+jEKkno30fiHBZ-PMVvvv7FxQ@mail.gmail.com>
	<BANLkTi=DgXrWZ0ObBYi2mgk-+8w8iXM7VQ@mail.gmail.com>
	<BANLkTimLnggco_+mQZ2_T_myAHsDD-=g1w@mail.gmail.com>
	<BANLkTikxS-_9h4rBdbbJ2e-RkjMWyiC1Mg@mail.gmail.com>
	<BANLkTinqxy6jCJLNVPKmMW3CErbfN7Hm=g@mail.gmail.com>
	<BANLkTinJvt=Nnt8YG-D1wpWKbBei+m+4XA@mail.gmail.com>
	<BANLkTinCSotWC-kbPDJc57NZM29hizYKpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: kusmabite@gmail.com, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 20:08:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHK1p-0006J8-G1
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 20:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197Ab1ECSIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 14:08:52 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52448 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800Ab1ECSIw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 14:08:52 -0400
Received: by bwz15 with SMTP id 15so338859bwz.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 11:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=EdS8jbpazgoUPAum2LIowupgzhEEZclMnnVpn8xPDZ0=;
        b=Pt7QK/OAZ28vjkVoOCj7gTzckoicRu5hsLxeQIGrdmoHsv8ly7ItCtE1fgNmudMJyt
         TTsARBXDqYEJPgs2c6hcNOQrkXVc2vZYAjqDTrYpMTz1TrB4CMyZFFpkax/JP/NOIhZ6
         OSmCY1tBZFNrC5Z2Vw6zk+wybOL9zaTEMDEp0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=TiM5CB9e535vvAvrgTjnSsqv55hmx4Zhx+i+fhfBo2y5mPXFoQggCHgsiS9gAvO9Vw
         NDsScNGjnzkltrGSxbnCZi0pwk4rw5MxWY0e9MNzrampQ6P8xB17gb4DdOnEOD2JF92z
         kdFVk2pBdqSdtL4RbB7KZxSyyOoDW0FbfyYdU=
Received: by 10.204.129.210 with SMTP id p18mr133937bks.66.1304446130637; Tue,
 03 May 2011 11:08:50 -0700 (PDT)
Received: by 10.204.120.195 with HTTP; Tue, 3 May 2011 11:08:49 -0700 (PDT)
In-Reply-To: <BANLkTinCSotWC-kbPDJc57NZM29hizYKpA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172680>

On Tue, May 3, 2011 at 7:54 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Mon, May 2, 2011 at 10:43 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> No, it's still an issue, and I believe I pin-pointed it in my first
>> mail. You can try out the patch I sent, and see if that helps in your
>> case. If it does, I think it'd make sense to do something (preferably
>> a bit more robust) with it.

I don't have a build of git at the moment to test it as I'm using
distro packages again. The only test case I have is the alice and bob
stuff already posted, so if your patch fixes that for you that's good
enough from my POV.

>
> Yes, I think your patch should be applied regardless, as that solves
> _one_ issue.
>
> But there are other issues.
>

All the best,

Steve.

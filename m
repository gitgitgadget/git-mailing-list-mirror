From: Stephen Kelly <steveire@gmail.com>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Wed, 27 Apr 2011 13:37:23 +0200
Message-ID: <BANLkTikCQkt+e-kA2hbtMh+OFqrrZHt-NQ@mail.gmail.com>
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
	<BANLkTi=-d+8ynv5NQ1SZA3V7PMiGiHauCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 13:37:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF33l-0005gW-V2
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 13:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756140Ab1D0LhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 07:37:25 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65475 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241Ab1D0LhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 07:37:25 -0400
Received: by bwz15 with SMTP id 15so1292909bwz.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 04:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=A0o3XZxgTXGLL0dmH66y+o3bPAuGoyaIxiutIPmy+QQ=;
        b=SrVF1PbGst4uJx7H0RKZpY9SrGXAD642AmocQFJK3qRfDs+8qms7CcFLEe83Jam6AD
         0fQMddiJywU0ZHVyrZ4L/PBVK2Y6E0wjL6INPsPKVcb2WEFyPMNJXsuhqiHAKBUqZYkg
         dxhL0ysEyRD3RabA0yQ8frRune//J2T6xyB0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=D3EkRMFKy6Si4rwL24SlMYTbc6346XyJELGqj33CA4uJxIY8W6nNdE2e3imsAVPD8L
         w1GqQXnvgMNwq+AWvJwkhGeJ2c6c7riKXDB5JLlbchApYr71nj6La37iOukTO5NT9XJZ
         z40mN0OKoMi20ebVBIPFbIscpgC0GjgyUVvA4=
Received: by 10.204.84.5 with SMTP id h5mr1764886bkl.201.1303904243603; Wed,
 27 Apr 2011 04:37:23 -0700 (PDT)
Received: by 10.204.120.195 with HTTP; Wed, 27 Apr 2011 04:37:23 -0700 (PDT)
In-Reply-To: <BANLkTi=-d+8ynv5NQ1SZA3V7PMiGiHauCw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172222>

It is not expected.

Alices repo is fubar'd. gitk doesn't work. The info about master being
ahead of remote etc is wrong or git push tells me it worked, though it
doesn't seem to.



stephen@bishop:/tmp/git/alice{master}$ git status
warning: refname 'HEAD' is ambiguous.
warning: refname 'HEAD' is ambiguous.
# On branch master
# Your branch is ahead of 'origin/master' by 2 commits.
#
nothing to commit (working directory clean)

stephen@bishop:/tmp/git/alice{master}$ git push
Everything up-to-date

stephen@bishop:/tmp/git/alice{master}$ git status
warning: refname 'HEAD' is ambiguous.
warning: refname 'HEAD' is ambiguous.
# On branch master
# Your branch is ahead of 'origin/master' by 2 commits.
#
nothing to commit (working directory clean)


On Wed, Apr 27, 2011 at 1:32 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Wed, Apr 27, 2011 at 2:29 PM, Stephen Kelly <steveire@gmail.com> wrote:
>> On Wed, Apr 27, 2011 at 11:48 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> No problems here:
>>
>> I had another go.
>
> And is that the expected behavior or not? BTW. I used 1.7.5.
>
> --
> Felipe Contreras
>

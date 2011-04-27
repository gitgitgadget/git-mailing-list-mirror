From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Wed, 27 Apr 2011 14:49:47 +0200
Message-ID: <BANLkTikxS-_9h4rBdbbJ2e-RkjMWyiC1Mg@mail.gmail.com>
References: <ih1449$ul6$1@dough.gmane.org> <7v62tjs66r.fsf@alter.siamese.dyndns.org>
 <20110120203840.GA11468@sigill.intra.peff.net> <7vbp3bqmiy.fsf@alter.siamese.dyndns.org>
 <20110120215456.GB11468@sigill.intra.peff.net> <AANLkTikBbSt5_WdbuE8a96w1pWBCYLNjMCUCBThjdLdG@mail.gmail.com>
 <7vk4hyp38i.fsf@alter.siamese.dyndns.org> <AANLkTikmbWkpjioARZrmySpLM8t7kqCX0v1+NKibk_ar@mail.gmail.com>
 <AANLkTinRcmevXz3zV0wtxd7+Q3F4zcH2AZOQk1XVxYXa@mail.gmail.com>
 <BANLkTim1gW_L-9DKo9p_VFQFUBUGWAPxoA@mail.gmail.com> <BANLkTinKDHM-RU2wqZECFcjQEoRWADnTGQ@mail.gmail.com>
 <BANLkTimFas5YLt37RLuCppkQ4ZGhmj56Cg@mail.gmail.com> <BANLkTinkR+jEKkno30fiHBZ-PMVvvv7FxQ@mail.gmail.com>
 <BANLkTi=DgXrWZ0ObBYi2mgk-+8w8iXM7VQ@mail.gmail.com> <BANLkTimLnggco_+mQZ2_T_myAHsDD-=g1w@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 14:50:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF4C7-0002qZ-Ia
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 14:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759050Ab1D0MuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 08:50:10 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50476 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758830Ab1D0MuH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 08:50:07 -0400
Received: by pvg12 with SMTP id 12so1148597pvg.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 05:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=3CapTDW1mY32FMWvRMTmsl2b+AehylEdn02bw1XGtY8=;
        b=ubrTTu4MMeHMrdNeBH7aEP9DkmscKkbY418OSGztG2IVPuPcu2WMuKj5f07yAXbOYJ
         pLRpfKIiO08P2hhYCvC0G8co/UhsAJ8WJH1MK0jt3iivjqWQ2KrP1R0omoqVOVDSeaci
         t5Ed7cRzwJruNC0uqk7ugyyZkBFFciLBkf5GQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=sW4JNvTVLovA+pBpUjUkGWmGzk5ha9XB8tGI4UstdHPfLxfSAjshdpAUI8ZooniuJq
         S5ELPaEdpbSxB/NDRGJ8hTBomTj4JukOFVE/960Iv0E+1WakRCV2SNw6I0KOkhbNZdrl
         evy4V9J+9C4qiK+wyoJhWLqdfZGuKbqEpERQk=
Received: by 10.68.48.161 with SMTP id m1mr2185499pbn.489.1303908607082; Wed,
 27 Apr 2011 05:50:07 -0700 (PDT)
Received: by 10.68.46.5 with HTTP; Wed, 27 Apr 2011 05:49:47 -0700 (PDT)
In-Reply-To: <BANLkTimLnggco_+mQZ2_T_myAHsDD-=g1w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172235>

On Wed, Apr 27, 2011 at 2:21 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Wed, Apr 27, 2011 at 1:29 PM, Stephen Kelly <steveire@gmail.com> wrote:
>> On Wed, Apr 27, 2011 at 11:48 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> No problems here:
>>
>> I had another go.
>>
>> mkdir remote
>> cd remote/
>> git init --bare
>> cd ../
>> git clone remote/ alice
>> cd alice/
>> echo test >> file
>> git add file
>> git commit -am w
>> git push origin master
>> echo test >> file
>> git commit -am w
>> git branch HEAD
>
> I'll stop you here. You reproduce the issue a lot simpler:
>
> git init foo &&
> cd foo &&
> echo "foo" > bar &&
> git add bar &&
> git commit -m. &&
> git branch HEAD &&
> gitk
>
> No need to involve remote branches. While remote branches makes the
> issue worse, because you can get in a situation where gitk doesn't
> when someone else made a nasty branch, and you fetched it.
>
> The real problem is that "git rev-parse HEAD" outputs "warning:
> refname 'HEAD' is ambiguous." to stderr (even if stderr is a non-tty),
> and gitk does not like that.
>
> This can be fixed by either doing "git -c core.warnambiguousrefs=0
> rev-parse HEAD", which strikes me as ugly, or by making sure that we
> don't issue this warning when not attached to a tty:

Of course, a third (and probably even better) option is to make gitk
warn about the ambiguous refname (like other commands will), but not
treat it as a fatal problem. But I'm not motivated enough to give that
solution a stab myself.

Not outputting that warning might be a regression for other users of
rev-parse (and/or the underlying mechanics).

From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.15
Date: Sat, 21 Nov 2009 08:59:23 -0500
Message-ID: <2c6b72b30911210559v561fd3d8s1e4ad70a8c94cf68@mail.gmail.com>
References: <20091120133117.GA26917@diku.dk> <20091120135004.GA3919@debian.b2j> 
	<2c6b72b30911200755l16b306cey16efb42fe9ba27da@mail.gmail.com> 
	<20091120162543.GB3919@debian.b2j> <2c6b72b30911201829i52ffa022qff827bdf317ad447@mail.gmail.com> 
	<20091121035858.GC3919@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 21 14:59:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBqVJ-00018C-Br
	for gcvg-git-2@lo.gmane.org; Sat, 21 Nov 2009 14:59:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754459AbZKUN7i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Nov 2009 08:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754339AbZKUN7i
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 08:59:38 -0500
Received: from mail-iw0-f178.google.com ([209.85.223.178]:61438 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762AbZKUN7h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Nov 2009 08:59:37 -0500
Received: by iwn8 with SMTP id 8so3148222iwn.33
        for <git@vger.kernel.org>; Sat, 21 Nov 2009 05:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=iIrMmjt6h5DygILWtMTSRhaO1UibAeCrWSHn6BXyaME=;
        b=YbpZ0vSw77dV9umJ1Nv2+XqQ+zQJJR8fkCAB56Sqy7BkoVrKR7HXXL7pSFVCn2kLsL
         PX6Ht4EzSgk7Hl9e0Nc9HZJO4tpyOgaMXA3MjnBkaGjls96BiqIbfVV4/5vYjL5MCMbq
         5r56R0jeIW8eV2fy8kcqOkezS2KafUaQUP+hU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=xvsgqn7J8iNX5K0RtlWPoOz7OV7DYJkTMYdSrQbPuthfFlgG/qVsHdqnOOTssAzevF
         OVhvz1064X0ZPkfQeC2Y/+Or88GQvUZNKKlUNicmUFjCvHrX4IotCMt57psxWqAL/THf
         kJhUK2ZVLjadB3zbnmCVXF+2Lvnm2f3mr/KrI=
Received: by 10.231.121.69 with SMTP id g5mr2607280ibr.44.1258811983099; Sat, 
	21 Nov 2009 05:59:43 -0800 (PST)
In-Reply-To: <20091121035858.GC3919@debian.b2j>
X-Google-Sender-Auth: 673f8e6903cced61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 20, 2009 at 22:58, bill lam <cbill.lam@gmail.com> wrote:
> On Fri, 20 Nov 2009, Jonas Fonseca wrote:
>> On Fri, Nov 20, 2009 at 11:25, bill lam <cbill.lam@gmail.com> wrote:
>> > On Fri, 20 Nov 2009, Jonas Fonseca wrote:
>> >> install-release-doc-man:
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0for doc in $(MANDOC); do \
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git checko=
ut origin/release $$doc; \
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0done
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(MAKE) install-doc-man
>> >
>> > Thanks it works. =C2=A0Could you also commit this to git?
>>
>> Done, but using git-checkout-index ...
> the line
> =C2=A0git read-tree release
> raised error perhaps I didn't checkout a branch for it, replacing it
> with
> =C2=A0 git read-tree origin/relase
> or
> =C2=A0 git read-tree remotes/origin/relase
>
> seems working.

Ah, stupid me.

> Another question, while it can open a file with editor in tree-view, =
I
> cannot find in tigmanual how to directly save a file. =C2=A0Any idea?

There is no such action/keybinding. I guess it should be easy to
extend the current functionality to query for a file name and save to
that instead of a temporary file.

--=20
Jonas Fonseca

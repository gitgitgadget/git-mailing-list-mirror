From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: ACLs for GIT
Date: Tue, 17 May 2011 21:11:44 +0530
Message-ID: <BANLkTik6dP9su_K5WxUYkcGUL76J5ObvMg@mail.gmail.com>
References: <4DD02876.1040404@bbn.com>
	<20110515201608.GX6349@kiwi.flexilis.local>
	<4DD12517.1000308@bbn.com>
	<BANLkTikwEivOiQVV-B=g3pP_StXAa8CVwg@mail.gmail.com>
	<BANLkTi=9vp+ibVa3tQzXbZSeYATKwmF60Q@mail.gmail.com>
	<BANLkTimPbQe7DGmR0VvDkU3=ZNjcAu7axw@mail.gmail.com>
	<BANLkTi=W2CtA2YaV_spru1E9pTWgoge3Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Martin L Resnick <mresnick@bbn.com>,
	"R. Tyler Croy" <tyler@monkeypox.org>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 17 17:59:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMMgL-0003DT-Tt
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 17:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755546Ab1EQP7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 11:59:33 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:57070 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755341Ab1EQP7c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 11:59:32 -0400
Received: by vxi39 with SMTP id 39so437266vxi.19
        for <git@vger.kernel.org>; Tue, 17 May 2011 08:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=RsvXWIAmCeX14aKmFYTXmfD1Ovl1EJlSGr9TtboRIFg=;
        b=PUd+8oXaBZMDfrjzNyJO2lF+l7wEY3/Ij/s1AwmS2MmM0fYY1ynQg0JyqI30FRTQHO
         hXqe1N9zx1iTgODE++cmLQDgqgC11+A/CNlfZcrGvI1p9WwArYH3eHysO2ahz8uFtubr
         FXlZ4l2XKTAkYdl2JQcyRvTDkkXALH1VHPaYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=D/Zq10J+dsWxVn/xktFfZcxjskK/OO0wv7/HwjRtoA09njscmiWRd1U+0N3t37p5wF
         +kWToNRWsD2bJe6iIJGj9NDdK2USrRJo5zXqWIc8aIIU18R5atiOQqxgo8WqfhgwMLbS
         QAEtYaecjBa6OuFMcOorAqvKuPlDnd5iZYBmM=
Received: by 10.52.68.147 with SMTP id w19mr782070vdt.152.1305646905005; Tue,
 17 May 2011 08:41:45 -0700 (PDT)
Received: by 10.52.164.101 with HTTP; Tue, 17 May 2011 08:41:44 -0700 (PDT)
In-Reply-To: <BANLkTi=W2CtA2YaV_spru1E9pTWgoge3Kw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173810>

On Tue, May 17, 2011 at 7:36 PM, Shawn Pearce <spearce@spearce.org> wrote:
> On Tue, May 17, 2011 at 05:08, Sitaram Chamarty <sitaramc@gmail.com> wrote:

> Yes. Or, he has a SHA-1 he suspects is a tree or blob and lists that
> in a tree he pushes to a branch he can write to. Now he can fetch that
> branch back, and obtain that object whose SHA-1 he has but whose
> contents he does not have.

Good point.  Not too hard too I guess, unlike this one:

> There is another attack that is incredibly improbable, but that JGit

[snipped lots of complicated stuff]

> assume this theoretical attack is too improbable to succeed. (And it
> is given what we know about SHA-1 today.)

IMO most of the theoretical attacks are just that.  They advance the
state of the art but I've not heard of any of them actually being used
in a real life scenario.  The sad fact is there are much weaker links
to be found if you look around and you don't need all this.

>> Having two repos is still the best plan ;-)
>
> Yes, but tell that to Gerrit Code Review users. They really use the
> branch ACL features. :-)

Interesting.  I do a fair amount of git consulting and training
(inhouse) and this has only come up once so far.  I haven't seen it as
being that common at all.

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC - draft] List of proposed future changes that are backward incompatible
Date: Sun, 15 Feb 2009 15:01:48 -0800 (PST)
Message-ID: <m3fxifticm.fsf@localhost.localdomain>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org>
	<alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Feb 16 00:03:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYq19-0006lc-L7
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 00:03:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631AbZBOXBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 18:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753618AbZBOXBw
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 18:01:52 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:36316 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601AbZBOXBv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 18:01:51 -0500
Received: by fxm13 with SMTP id 13so5212377fxm.13
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 15:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=g18rHMoIKaiXV9rvvLKaJlY/a5p5L4PGxGRqg3Idr8c=;
        b=f34HpMjgfIoMR+JLC2jOj5YlNs1fWHRtTjCt5rg+Q5aTeS4d9iCSTQ8jbqBj3DBD3L
         ygAeTl2BTF5y6FzZVDYZs9JTFQz4bIn+lE/1ly158JH1p87U6kZ6m2fUjHiLXXIqqDYK
         COCGp36qmj50DGtleWjo57eg/e9keFbrSPI5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=KmII9avx8qVymCcBGRKXF/M0gmo2Oga6m8e78l/TlDNBDZM35qZ3vsgkuVoITy/pZy
         e0Z7AklRcdoaYoRvFQ25wwVEwBC1UnbI5j1L5oEL7+qkfWmzCNSoefMvgQ+74EMiPIyz
         m7vsxujm/eyPMbc0IoGAbViqv4Z8c4QOblM0I=
Received: by 10.103.172.9 with SMTP id z9mr2502176muo.109.1234738908991;
        Sun, 15 Feb 2009 15:01:48 -0800 (PST)
Received: from localhost.localdomain (abwt47.neoplus.adsl.tpnet.pl [83.8.243.47])
        by mx.google.com with ESMTPS id w5sm6603453mue.3.2009.02.15.15.01.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Feb 2009 15:01:48 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n1FN1lpB030373;
	Mon, 16 Feb 2009 00:01:47 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n1FN1joD030363;
	Mon, 16 Feb 2009 00:01:45 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110080>

david@lang.hm writes:

> On Sun, 15 Feb 2009, Junio C Hamano wrote:
> 
> > Thanks.
> >
> > * git-push to update the checked out branch will be refused by default
> >
> >  Make "git push" into a repository to update the branch that is checked
> >  out fail by default.
> >
> >  http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007
> 
> If I understand this one, it will cause grief for quite a few people.
> 
> I have a public repository that I push to and then have a trigger that
> checks out the current version, compiles it, publishes the compiled
> version, sends an announcement, etc
> 
> if I am understanding the purpose of this change, you would prohibit
> the update from taking place.

No, you just have to configure it to enable it.  In the meantime
(before the change) you would get warnings unless you configure it.

> > * git-send-email won't make deep threads by default
> >
> >  Many people said that by default when sending more than 2 patches the
> >  threading git-send-email makes by default is hard to read, and they
> >  prefer the default be one cover letter and each patch as a direct
> >  follow-up to the cover letter.
> >
> >  http://article.gmane.org/gmane.comp.version-control.git/109790
> 
> I have mixed feelings about this one, if some messages get delayed in
> transit the deep threads still keeps them in order, while the 2-layer
> option doesn't.

That is whay you should use --numbered (and I think it should be
default for --no-chain-reply-to), using [PATCH m/n] prefix.

Note that usually you would have problems if patch arrive out of
order, unless your enail client / news reader is able to rethread.

> 
> that being said, I don't think it's that significant to change the
> default.

It is much, much nicer when there is discussion on the patches in
patch series to have 'shallow' threading (cover letter + patches
numbered being reply to cover letter).

Unless you don't get review of patches, then deep threading might look
as nice...


> 
> one thing that would help new users is if there was a way to create a
> git config file that explicitly listed all the defaults. either as a
> sample config, or to expand the existing config file with all the
> defaults listed, but commented out.
> 
> I find that having such a config file helps me find config options I
> never thought to look for.

That is a very good idea... if next to impossible now, I think, as
there is (I guess) no single place that stores default values.  But
perhaps I am mistaken.

-- 
Jakub Narebski
Poland
ShadeHawk on #git

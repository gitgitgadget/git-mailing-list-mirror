From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: ks/precompute-completion
Date: Fri, 23 Oct 2009 13:20:19 -0700 (PDT)
Message-ID: <m3d44deu93.fsf@localhost.localdomain>
References: <7veiovly35.fsf@alter.siamese.dyndns.org>
	<4AE0190E.8020803@gmail.com>
	<fabb9a1e0910221011r957246dx3162cd675ff16800@mail.gmail.com>
	<4AE0DAB3.1030103@gmail.com>
	<fabb9a1e0910221555k287b45ebwb15ac97851b845f9@mail.gmail.com>
	<fabb9a1e0910221556s694a344ag8e5ae07c35351ee4@mail.gmail.com>
	<4AE0E542.8010501@gmail.com>
	<fabb9a1e0910231127i3ab469qebdc17168a58f22a@mail.gmail.com>
	<7vd44eaqc5.fsf@alter.siamese.dyndns.org>
	<fabb9a1e0910231216j2a024ac5mf5b5ccb5322722f8@mail.gmail.com>
	<7v1vktc1uk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, gitzilla@gmail.com,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 22:25:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1QhC-00036Z-9A
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 22:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbZJWUUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 16:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbZJWUUS
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 16:20:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:23521 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbZJWUUR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 16:20:17 -0400
Received: by fg-out-1718.google.com with SMTP id d23so399972fga.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2009 13:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=RjeWijYuCZN7unTlqNYsKn7kI3jw8gf5deT/fpasPBc=;
        b=IA/MwDbfMFWFNPZayrNf6C6Dx/WQmT5PvjGRsVAWVPSQULmPirPAu+IEdkOyO/rcuW
         YnfrUNSwsvV+HsiMLa6sRBTgX8jXw3TLZoYMCg2URKUUBPWcfSmJ25jYSuREesPuZyAr
         DI5u+044x+z21Khw66Li22tX9Q0vUq+GgSsP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=h9AwOHInrR0g38bSk25ow+xeUExk6AIPEpNPmkPfgD8PqqRcPug0xGt6BBoijawUkE
         AuBWjuokYFRcIi3dYii5vS9xxN9h16iPfJhKyh8fitcUVOjMFj5cB0QKVWvPgO1e21HI
         hGdyP8r0ub8AuhRC1fs0enmBO3ckqqqO31/vw=
Received: by 10.86.225.38 with SMTP id x38mr1225065fgg.59.1256329221097;
        Fri, 23 Oct 2009 13:20:21 -0700 (PDT)
Received: from localhost.localdomain (abwd230.neoplus.adsl.tpnet.pl [83.8.227.230])
        by mx.google.com with ESMTPS id d8sm2127817fga.18.2009.10.23.13.20.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Oct 2009 13:20:19 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n9NKLkuV007944;
	Fri, 23 Oct 2009 22:21:46 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n9NKLiR1007941;
	Fri, 23 Oct 2009 22:21:44 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7v1vktc1uk.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131127>

Junio C Hamano <gitster@pobox.com> writes:

> Sverre Rabbelier <srabbelier@gmail.com> writes:
> 
> > This is my main concern, adding 'bash_completion' as a target to all:
> > would be ok; why would 'make clean' break it? As long as you don't add
> > "make -C contrib/completion clean' to the main clean target there's no
> > problem?
> 
> "make clean" should remove it, because it is a normal build product,
> if you make your "make all" build completion scripts.
> 
> The word _should_ is used in the RFC2119 sense: there may exist valid
> reasons in particular circumstances to ignore a particular item, but the
> full implications must be understood and carefully weighed before choosing
> a different course.

If we take similar approach to the way gitweb can be build to the bash
completion script, which means building it via

  make contrib/completion/git-completion.bash

(and not make this target part of "make all"), then there is, I think,
no reason for "make clean" to remove it, isn't it?

-- 
Jakub Narebski
Poland
ShadeHawk on #git

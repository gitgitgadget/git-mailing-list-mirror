From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI revamp
Date: Tue, 4 Nov 2008 12:18:00 +0300
Message-ID: <20081104091800.GB24100@dpotapov.dyndns.org>
References: <20081030002239.D453B21D14E@mail.utsl.gen.nz> <20081031003154.GA5745@sigill.intra.peff.net> <7v3ai9226q.fsf@gitster.siamese.dyndns.org> <1225691960.20883.41.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sam Vilain <samv@vilain.net>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>,
	Tom Preston-Werner <tom@github.com>,
	"J.H." <warthog19@eaglescrag.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kai Blin <kai@samba.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Nov 04 10:19:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxI4T-00014h-Fk
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 10:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168AbYKDJSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 04:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753912AbYKDJSJ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 04:18:09 -0500
Received: from fk-out-0910.google.com ([209.85.128.187]:39280 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754168AbYKDJSH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 04:18:07 -0500
Received: by fk-out-0910.google.com with SMTP id 18so3660154fkq.5
        for <git@vger.kernel.org>; Tue, 04 Nov 2008 01:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ng+epZnz7EpJWorT33txTPlFKOcsiyjSiiHdIrFTh8k=;
        b=cyv8WVY5ef1N2tuBZbxHupgoCpkj0gxswEV8rEW58kkSc0BJJkg4WwozTzHNifz6KF
         f8HWYd9+PE9Ikwgxe7yQNPXKu1QW1eDqV0A5+oeUTgnYCbcTKScI5oc0nrqjWQUbm/Sh
         UYSSVocHbYLLArkfSHMosPMILekkw8EjjRrDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iBopi7QPNNvXeOYgsuu/xyz6YcW/DQC8XTRjAeqPLxMxlmeBujhufwSq51sO2FvbVS
         U79SPzlVvWKm1pegT/RETFvakR1uTni87WH1JQdGONhqvAVhCXNDX5ii3kcBp5gTQUAW
         GmO/9StR/hFo68zYFB1zTa0JeSIZ3c3P3H4O0=
Received: by 10.181.197.2 with SMTP id z2mr272282bkp.100.1225790285398;
        Tue, 04 Nov 2008 01:18:05 -0800 (PST)
Received: from localhost (ppp85-141-189-211.pppoe.mtu-net.ru [85.141.189.211])
        by mx.google.com with ESMTPS id 22sm11790298fkr.4.2008.11.04.01.18.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Nov 2008 01:18:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1225691960.20883.41.camel@maia.lan>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100063>

On Mon, Nov 03, 2008 at 06:59:20PM +1300, Sam Vilain wrote:
> 
> I can see that some people want this behaviour by default; but to me
> "push the current branch back to where it came from" seems like far more
> a rational default for at least 90% of users.

I think it depends on one's workflow. If you use a centralized workflow
as with CVS then yes, 90% cases you want to push the current branch. On
the other hand, if people push their changes to the server only for
review, it means that accidentally pushing more than one intended is not
a big deal. The only one who does publishing to the official repository
is the maintainer, and the maintainer is most likely to run some tests
after merging all changes, which takes some time. So, it is rarely push
the current branch, it is usually the branch that has been tested, so
the name of the branch should be specified explicitly anyway.

Dmitry

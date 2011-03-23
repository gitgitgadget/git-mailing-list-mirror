From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-completion: Add git help completion for aliases
Date: Wed, 23 Mar 2011 05:11:41 -0700 (PDT)
Message-ID: <m3y646ujgy.fsf@localhost.localdomain>
References: <4D871972.7080008@elegosoft.com>
	<7vhbawno11.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.1103212302000.1561@bonsai2>
	<7v4o6vmvzs.fsf@alter.siamese.dyndns.org>
	<20110322085027.GF14520@neumann>
	<AANLkTi=zbsNxLSCcWQorZCnRFuDPujqYzW7B0xJx2FHp@mail.gmail.com>
	<20110322100903.GG14520@neumann>
	<AANLkTik8BaAJCnCRdDNTdu=nV1Q7cFLiwOuV_4wdXUE6@mail.gmail.com>
	<20110322202518.GA30604@neumann>
	<AANLkTikLHRkE6aapS00q=4=4FSzjY1XQQQp=pRu12yP3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-15?q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jakob Pfender <jpfender@elegosoft.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, lee.marlow@gmail.com,
	markus.heidelberg@web.de, spearce@spearce.org, bebarino@gmail.com,
	ted@tedpavlic.com, tlikonen@iki.fi, trast@student.ethz.ch
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 13:11:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Muj-0006a5-US
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 13:11:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754756Ab1CWMLp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2011 08:11:45 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46810 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab1CWMLo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 08:11:44 -0400
Received: by bwz15 with SMTP id 15so6610608bwz.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 05:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=uNqe0JHb1QIhJy5MrAybYC/1L+sMqnTLQwUlDmSE0BY=;
        b=hordsS4ZCW9xapeI1MB/WYDO9LjhwJOv8USU79/R4Q/swjmzlyyVzX7t1Nm0t0NwMv
         NRgrxx9/IzA+aOXAAPbktren7oljcaivYzhlwhnCs995Ba+Qdc4E0oE7pOcOwJG1LVFm
         RjeBgm7VsZOTIPrHjqFMe5B7Rrr0kq3uPjH00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=MtoWWhkyeiHJ3fU94Nd/7RfVEsaB+8XWMPP3DRxbd04cTJKpOqisPXguOE5vdeFIyu
         WSnr6HG36pjx+nEhjkz2++BoUYIWYYnAVNIpkzUEZ0V35OikvlL/6qVZO6e9C6uhje+x
         jHZk3wOXOQKb2TGJIyPBAmQtHhDBMfOo62Pxw=
Received: by 10.204.170.193 with SMTP id e1mr6118126bkz.136.1300882302999;
        Wed, 23 Mar 2011 05:11:42 -0700 (PDT)
Received: from localhost.localdomain (abvf64.neoplus.adsl.tpnet.pl [83.8.203.64])
        by mx.google.com with ESMTPS id w3sm5874710bkt.17.2011.03.23.05.11.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 Mar 2011 05:11:41 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p2NCAKRZ016312;
	Wed, 23 Mar 2011 13:10:36 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p2NC9IQq016286;
	Wed, 23 Mar 2011 13:09:18 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTikLHRkE6aapS00q=4=4FSzjY1XQQQp=pRu12yP3@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169822>

Erik Faye-Lund <kusmabite@gmail.com> writes:
> 2011/3/22 SZEDER G=E1bor <szeder@ira.uka.de>:
> > On Tue, Mar 22, 2011 at 11:28:01AM +0100, Erik Faye-Lund wrote:

> > > But even so, at least 25% of the git user base is on Windows,
> > > according to the latest Git User Survey. That makes this stuff ma=
tter.
> >
> > The other point of view is that it will cause a regression without =
a
> > compensating benefit for maybe more than 75% of the user base ;)

[...]
> (Warning: speculation ahead)
> Also, I suspect the numbers of Windows developers are
> underrepresented, for two reasons;
> - I suspect that Windows developers are less likely to be subscribed
> to the mailing lists where the Git User Survey are promoted.
> - I suspect that most Windows users use EITHER Cygwin OR MinGW, but I
> intentionally picked the largest of the Windows categories instead of
> adding them up because the Git User Survey allowed people to answer
> both MinGW and Cygwin.
>=20
> User Survey people, if your read this: please have a separate
> operating system question next year. It's very valuable information!

This information can be extracted from survey data, so there is no
need for separate question.

Prior to adding this information to GitSurvey2010 page on git wiki,

  https://git.wiki.kernel.org/index.php/GitSurvey2010#09._On_which_oper=
ating_system.28s.29_do_you_use_Git.3F
  https://git.wiki.kernel.org/index.php?title=3DGitSurvey2010&diff=3D14=
112&oldid=3D12212

you could get this information by going to 'Analysis' page

  http://tinyurl.com/GitSurvey2010Analysis

selecting last filter: 'F13 - OS: MS Windows (any)', writing down
number of responses: 2671, and calculating percentage relative to
number of all responses to Q9, i.e. 8541, and you get 31.27% of
people using Git on MS Windows (not counting 'other, please specify'
responses, but they are very few).

Or you could have extracted this information from responses data,
which is available on GitSurvey2010 page...

--=20
Jakub Narebski
Poland
ShadeHawk on #git

From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 0/9] i18n: add PO files to po/
Date: Thu, 6 Oct 2011 10:29:57 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1110061025590.18528@ds9.cixit.se>
References: <1317668297-2702-1-git-send-email-avarab@gmail.com> <20111003220659.GA19537@elie> <CACBZZX5uz5cdoWebYOY-Omu0drnQasJB-12DMZyZ_NX17jzhmg@mail.gmail.com> <7vaa9gbdyc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?ISO-8859-2?Q?Marcin_Cie=B6lak?= <saper@saper.info>,
	Sam Reed <sam@reedyboy.net>,
	Jan Engelhardt <jengelh@medozas.de>,
	=?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	=?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 11:30:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBkHk-0005xb-PF
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 11:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935776Ab1JFJac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 05:30:32 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:48529 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S935693Ab1JFJab (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 05:30:31 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p969U0Yv026181
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 6 Oct 2011 11:30:00 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id p969Tvbt026177;
	Thu, 6 Oct 2011 11:29:59 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <7vaa9gbdyc.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Thu, 06 Oct 2011 11:30:00 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182936>

Junio C Hamano:

> These two are somewhat mutually exclusive. I _suspect_ that Jonathan might 
> have been hinting me to eject everything under the current po/ directory, 
> and bind that part of the tree as a submodule from another repository, 
> which would give us "git log -p" cleanliness automatically.

That sounds like a good idea, actually. That way you can also chose which 
version of the po/ tree to include without having to do crazy cherry-picking 
and stuff, and it makes it easier to maintain externally and such.

I have experience working with Translation Project, both as a software 
maintainer requesting translation, and as a translator doing translations, 
and I am interested in setting up a po repository for Git and use TP to 
maintain translations (or directly, for those that would prefer that).

-- 
\\// Peter - volunteered, because localization is a good thing

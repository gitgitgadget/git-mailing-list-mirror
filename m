From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: "git stash list" shows HEAD reflog
Date: Sat, 13 Mar 2010 22:49:33 +0100
Message-ID: <4B9C086D.10004@lsrfire.ath.cx>
References: <op.u9gl97fstuzx1w@cybershadow.mshome.net> <4B9BCD6E.4090902@lsrfire.ath.cx> <alpine.DEB.2.00.1003130939240.796@narbuckle.genericorp.net> <4B9BF171.2000102@lsrfire.ath.cx> <alpine.DEB.2.00.1003131312540.796@narbuckle.genericorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Vladimir Panteleev <vladimir@thecybershadow.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Dave Olszewski <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 13 22:49:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqZDI-0006yo-EM
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 22:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759335Ab0CMVtg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Mar 2010 16:49:36 -0500
Received: from india601.server4you.de ([85.25.151.105]:35496 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759327Ab0CMVtf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 16:49:35 -0500
Received: from [10.0.1.100] (p57B7E76C.dip.t-dialin.net [87.183.231.108])
	by india601.server4you.de (Postfix) with ESMTPSA id 99D662F8045;
	Sat, 13 Mar 2010 22:49:33 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <alpine.DEB.2.00.1003131312540.796@narbuckle.genericorp.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142109>

Am 13.03.2010 22:21, schrieb Dave Olszewski:
> Maybe, although I'm not sure if dying here is the right behavior.  Is=
 an
> empty reflog really an error?

Yeah, that might be a bit heavy-handed.  *ahem*

> I was testing a patch along the lines of
> what Vladimir proposed, which was simply to not set the default rev i=
f a
> valid user-specified argument was found, whether or not it contains
> commits.

Sounds more like it.  How did the tests go?  Does it result in empty
output (which is what I would expect from an empty reflog, now that I
stopped and thought about it for a second)?

Ren=E9

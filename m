From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Is there a place for benchmarking scripts?
Date: Thu, 27 Oct 2011 18:01:40 +0200
Message-ID: <4EA98064.3060706@lsrfire.ath.cx>
References: <4EA7D7E3.2020009@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Oct 27 18:02:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJSP1-0006ca-UG
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 18:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132Ab1J0QBy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Oct 2011 12:01:54 -0400
Received: from india601.server4you.de ([85.25.151.105]:60395 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901Ab1J0QBy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 12:01:54 -0400
Received: from [192.168.2.104] (p4FFDAB8C.dip.t-dialin.net [79.253.171.140])
	by india601.server4you.de (Postfix) with ESMTPSA id 7F04B2F8034;
	Thu, 27 Oct 2011 18:01:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <4EA7D7E3.2020009@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184297>

Am 26.10.2011 11:50, schrieb Michael Haggerty:
> I've been doing a lot of benchmarking of git performance in the prese=
nce
> of lots of references.  I've written a few scripts to automate the
> benchmarking [1].  They are not beautiful and would require a couple =
of
> local adjustments [2,3].  They are too time-consuming to be made part=
 of
> the usual test suite.  I wouldn't want to commit to maintaining them.
> But they have certainly been useful to me, and they generate readable
> output [4].
>=20
> My question is: would such benchmarking scripts be welcome within the
> git project?  If so, where should I put it?  Is any benchmarking
> code/framework already in use?

That would be nice.  A whole performance regression testing suite would
be even nicer and can perhaps be built piece by piece.

We have contrib/ and we have the test-* commands; t/ doesn't seem to fi=
t
too well with its focus on OK or fail.

Ren=E9

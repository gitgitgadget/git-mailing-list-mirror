From: Jonas Berlin <jonas.berlin@outerspace.dyndns.org>
Subject: Re: [PATCH v2] completion: fix issue with process substitution not
   working on Git for Windows
Date: Thu, 27 Oct 2011 13:40:43 +0300
Message-ID: <20111027134043.56519ca4@outerspace.dyndns.org>
References: <CAJzBP5QYKOf4OUMm4vfVay=b7F_fHJf40JgzDAZZa7p0fxLpyA@mail.gmail.com>
	<1319656389-9515-1-git-send-email-stefan.naewe@gmail.com>
	<20111027090530.GA23424@goldbirke>
	<20111027132754.1503b98b@outerspace.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?ISO-8859-1?B?R+Fib3I=?= <szeder@ira.uka.de>,
	Stefan Naewe <stefan.naewe@gmail.com>, spearce@spearce.org,
	git@vger.kernel.org, gitster@pobox.com
To: Jonas Berlin <xkr47@outerspace.dyndns.org>
X-From: git-owner@vger.kernel.org Thu Oct 27 12:51:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJNYA-0004DY-4e
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 12:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755042Ab1J0KvB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Oct 2011 06:51:01 -0400
Received: from mx.slashbox.net ([213.250.117.195]:54212 "EHLO mx.slashbox.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754118Ab1J0KvA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2011 06:51:00 -0400
X-Greylist: delayed 614 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Oct 2011 06:51:00 EDT
Received: from outerspace.dyndns.org (cs78186190.pp.htv.fi [62.78.186.190])
	by mx.slashbox.net (Postfix) with ESMTPSA id 1F98B1BF4A7;
	Thu, 27 Oct 2011 13:40:45 +0300 (EEST)
In-Reply-To: <20111027132754.1503b98b@outerspace.dyndns.org>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184292>

On Thu, 27 Oct 2011 13:27:54 +0300
Jonas Berlin <xkr47@outerspace.dyndns.org> wrote:

> On Thu, 27 Oct 2011 11:05:30 +0200
> SZEDER G=E1bor <szeder@ira.uka.de> wrote:
> > The $output variable is not declared as local and therefore it leak=
s
> > into the environment.  But instead of declaring it local, why not
> > eliminate it altogether, and use the "$(git config ....)" command
> > substitution as here string?
>=20
> Wouldn't this work:
>=20
> 	git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream=
)$' 2>/dev/null | tr '\0\n' '\n ' | \
> 	while read key value; do
> 		...
> 	done

Sorry, please disregard, I didn't notice it was already dismissed in v1=
 of the PATCH..

- xkr47

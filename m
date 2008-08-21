From: Keith Amidon <keith@nicira.com>
Subject: Re: How can a custom merge tool get access to file shell variables?
Date: Thu, 21 Aug 2008 16:31:26 -0700
Organization: Nicira Networks
Message-ID: <1219361486.16860.50.camel@kea-nicira-lt.nicira.com>
References: <1219169604.12921.17.camel@kea-nicira-lt.nicira.com>
	 <1219170004.12921.19.camel@kea-nicira-lt.nicira.com>
	 <1219170751.12921.27.camel@kea-nicira-lt.nicira.com>
	 <20080821221524.GA25429@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 01:32:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWJds-00035A-6c
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 01:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbYHUXbc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Aug 2008 19:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752488AbYHUXbc
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 19:31:32 -0400
Received: from dime139.dizinc.com ([66.7.205.111]:49056 "EHLO
	dime139.dizinc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbYHUXbb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Aug 2008 19:31:31 -0400
Received: from adsl-75-36-168-248.dsl.pltn13.sbcglobal.net ([75.36.168.248]:45431 helo=[192.168.1.16])
	by dime139.dizinc.com with esmtpsa (SSLv3:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <keith@nicira.com>)
	id 1KWJck-00070s-GK; Thu, 21 Aug 2008 19:31:27 -0400
In-Reply-To: <20080821221524.GA25429@hashpling.org>
X-Mailer: Evolution 2.22.2 
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - dime139.dizinc.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - nicira.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93225>

=EF=BB=BFHi Charles,

Thanks for your reply to my issue.  To answer your question, I did read
the git mergetool man page too.  For some reason I felt that the
information in the git config page was more complete/specific for this
case.  Anyway, now I understand how it works (and quoting issues I
haven't had to worry about because I don't have weird filenames aside),
the setup actually works very nicely.  If you would be interested and
could provide some guidance on roughly what you would like to see I'd b=
e
happy to take a crack at an initial modification to the git mergetool
man page to include an example similar to mine below with proper quotin=
g
so paths with spaces in them work, etc.

Thanks again for your response and for the excellent work you and
everyone involved in git development have been doing.

             --- Keith

P.S. -- Sorry if you get two copies Charles.  My previous version of
this message was rejected by the mailing list because I forgot to send
w/o HTML.

On Thu, 2008-08-21 at 23:15 +0100, Charles Bailey wrote:
> Did you also try the git mergetool man page (not that it's much
> better!)?
>=20
> The point of the custom mergetool patch was to make using a new,
> previously unknown merge tool a 'simple' configuration exercise rathe=
r
> than a patch or scripting exercise. At the time, an 'eval' approach
> was the compromise between ease of implementation and preventing
> environmental pollution.
>=20
> It's not the most beautiful of solutions, especially since escaping
> quotes and spaces in either .gitconfig or in a git config command lin=
e
> of something that is later going to be expanded by the shell is
> something of a mind bender.
>=20
> An example in the documentation would be a really good idea - you are
> not the first person to have asked about how to use the custom merge
> tool feature. I'm feeling a little guilty about not adding my name to
> the man page when I submitted the patch. It's not Ted's fault that th=
e
> custom merge tool section is badly explained; it's mine.
>=20

From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Simplify strbuf uses in fast-import.c using the proper
 functions.
Date: Wed, 05 Sep 2007 01:46:39 +0200
Message-ID: <46DDEE5F.8070800@lsrfire.ath.cx>
References: <20070904115317.GA3381@artemis.corp> <11889144743483-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 01:47:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISi7D-000821-7E
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 01:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023AbXIDXqw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 4 Sep 2007 19:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754852AbXIDXqv
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 19:46:51 -0400
Received: from main.gmane.org ([80.91.229.2]:33765 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753977AbXIDXqu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 19:46:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ISi6a-0003Xi-Vu
	for git@vger.kernel.org; Wed, 05 Sep 2007 01:46:48 +0200
Received: from p508edaf7.dip.t-dialin.net ([80.142.218.247])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 01:46:48 +0200
Received: from rene.scharfe by p508edaf7.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 01:46:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p508edaf7.dip.t-dialin.net
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <11889144743483-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57659>

Pierre Habouzit schrieb:
>   This is just cleaner way to deal with strbufs, using its API rather=
 than
> reinventing it in the module (e.g. strbuf_append_string is just the p=
lain
> strbuf_addstr function, and it was used to perform what strbuf_addch =
does
> anyways).
> ---
>  archive-tar.c |   65 ++++++++++++++---------------------------------=
----------
>  1 files changed, 16 insertions(+), 49 deletions(-)

Apart from the wrong subject I really like this patch. :-D

Thanks!
Ren=E9

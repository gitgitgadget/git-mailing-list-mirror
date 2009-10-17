From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/3] format_commit_message(): fix function signature
Date: Sat, 17 Oct 2009 23:04:24 +0200
Message-ID: <4ADA3158.6000909@lsrfire.ath.cx>
References: <1255681702-5215-1-git-send-email-gitster@pobox.com> <1255681702-5215-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 23:04:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzGSC-0006D9-8D
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 23:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815AbZJQVE1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Oct 2009 17:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753759AbZJQVE1
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 17:04:27 -0400
Received: from india601.server4you.de ([85.25.151.105]:34625 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698AbZJQVE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2009 17:04:26 -0400
Received: from [10.0.1.101] (p57B7C517.dip.t-dialin.net [87.183.197.23])
	by india601.server4you.de (Postfix) with ESMTPSA id 7287E2F803D;
	Sat, 17 Oct 2009 23:04:30 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1255681702-5215-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130578>

Junio C Hamano schrieb:
> The format template string was declared as "const void *" for some un=
known
> reason, even though it obviously is meant to be passed a string.  Mak=
e it
> "const char *".

Yes.  I seem to have introduced that type in commit 7b95089c, but I
can't see (even less remember) why.  Also note that commit message and
header file call the parameter "template", while it's called "format" i=
n
commit.c (where the function used to live back then).  What was I think=
ing?

Thanks for cleaning up after me.

Ren=E9

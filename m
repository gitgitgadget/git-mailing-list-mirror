From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] t9143: do not fail when unhandled.log.gz is not created
Date: Fri, 10 Dec 2010 05:31:23 +0800
Message-ID: <20101209213123.GA25684@dcvr.yhbt.net>
References: <4D0133AF.40000@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 22:31:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQo5J-0001k6-2n
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 22:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756636Ab0LIVbY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Dec 2010 16:31:24 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:48749 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755329Ab0LIVbY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 16:31:24 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id C68421F8D2;
	Thu,  9 Dec 2010 21:31:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4D0133AF.40000@web.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163324>

Torsten B=F6gershausen <tboegi@web.de> wrote:
> Do not depend on internal implementation details of svn,
> which right now uses perl to create a .gz file.
> So this test case will even work in the future,
> when svn changes its implementation.
>
> Signed-off-by: Torsten B=F6gershausen <tboegi@web.de>

Thanks Torsten, I needed to fix whitespace mangling from
your mailer to get it to apply cleanly.

Acked-by: Eric Wong <normalperson@yhbt.net>

It's pushed out to git://git.bogomips.org/git-svn along with an
older patch from Steven:

Steven Walter (1):
      git-svn: allow the mergeinfo property to be set

Torsten B=F6gershausen (1):
      t9143: do not fail when unhandled.log.gz is not created

--=20
Eric Wong

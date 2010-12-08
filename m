From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] t9143: do not fail when unhandled.log.gz is not created
Date: Wed, 8 Dec 2010 13:41:15 -0800
Message-ID: <20101208214115.GA29131@dcvr.yhbt.net>
References: <4CFA27E0.8070308@web.de> <20101206192326.GA12383@dcvr.yhbt.net> <4CFFB188.6000006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <totte.enea@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 22:41:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQRlJ-0008WK-4z
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 22:41:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397Ab0LHVlQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Dec 2010 16:41:16 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:36039 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753455Ab0LHVlP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 16:41:15 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FBC51F503;
	Wed,  8 Dec 2010 21:41:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4CFFB188.6000006@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163225>

Torsten B=F6gershausen <totte.enea@gmail.com> wrote:
> If you agree, I will send a V2 version of the patch, which
> will use the following:
> ---------------------------
> if test -r .git/svn/refs/remotes/git-svn/unhandled.log.gz
> then
> 	test_expect_success 'git svn gc produces a valid gzip file' '
> 		 gunzip .git/svn/refs/remotes/git-svn/unhandled.log.gz
> 		'
> fi

Yes, it's definitely a better test.  Thanks!

--=20
Eric Wong

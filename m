From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] grep: simple test for operation in a bare repository
Date: Thu, 04 Feb 2010 00:50:54 +0100
Message-ID: <4B6A0BDE.2050908@lsrfire.ath.cx>
References: <4B69BD7C.4010608@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 04 00:51:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncp03-0000Fb-N3
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 00:51:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757898Ab0BCXvH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 18:51:07 -0500
Received: from india601.server4you.de ([85.25.151.105]:32862 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757659Ab0BCXvE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 18:51:04 -0500
Received: from [10.0.1.100] (p57B7CCAF.dip.t-dialin.net [87.183.204.175])
	by india601.server4you.de (Postfix) with ESMTPSA id DF7142F803C;
	Thu,  4 Feb 2010 00:51:00 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <4B69BD7C.4010608@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138916>

Am 03.02.2010 19:16, schrieb Ren=E9 Scharfe:
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> ---
>  t/t7002-grep.sh |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)

Err, no, that won't do.  Sorry.

The test script fails to demonstrate the issue I've run into.  It runs
successfully, but running git grep manually fails:

	$ cd t/trash\ directory.t7002-grep/.git/bare_test_repo/
	$ git grep bla HEAD
	fatal: This operation must be run in a work tree

I have to dig a bit deeper and try to come back with a better test scri=
pt.

Ren=E9

From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] diff: don't run pager if user asked for a diff style exit code
Date: Mon, 13 Aug 2007 11:57:32 +0200
Message-ID: <13516449-DEDB-41A1-8880-42CB124A6C0A@wincent.com>
References: <17875.88.10.191.55.1186873960.squirrel@secure.wincent.com> <46BF478F.7030603@lsrfire.ath.cx>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Aug 13 11:58:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKWgY-0006am-Ff
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 11:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762172AbXHMJ5q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 13 Aug 2007 05:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756198AbXHMJ5p
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 05:57:45 -0400
Received: from wincent.com ([72.3.236.74]:60651 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759147AbXHMJ5l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Aug 2007 05:57:41 -0400
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l7D9vaSs013036;
	Mon, 13 Aug 2007 04:57:37 -0500
In-Reply-To: <46BF478F.7030603@lsrfire.ath.cx>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55756>

El 12/8/2007, a las 19:46, Ren=E9 Scharfe escribi=F3:

> Push pager setup down into builtin-diff.c and don't start the pager
> if --exit-code or --quiet (which implies --exit-code) was specified.

Great stuff, Ren=E9. The change looks much simpler than I thought it =20
would.

Cheers,
Wincent

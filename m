From: "Wincent Colaiuta" <win@wincent.com>
Subject: Re: --exit-code (and --quiet) broken in git-diff?
Date: Sun, 12 Aug 2007 06:24:55 -0500 (CDT)
Message-ID: <24332.88.10.191.55.1186917895.squirrel@secure.wincent.com>
References: <17875.88.10.191.55.1186873960.squirrel@secure.wincent.com>
    <46BED5AA.7050900@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Aug 12 13:25:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKBZY-0002G2-5U
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 13:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934527AbXHLLY6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 12 Aug 2007 07:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934536AbXHLLY6
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 07:24:58 -0400
Received: from wincent.com ([72.3.236.74]:58387 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934527AbXHLLY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 07:24:57 -0400
Received: from s69819.wincent.com (localhost [127.0.0.1])
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l7CBOtHD016309
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 12 Aug 2007 06:24:55 -0500
Received: (from apache@localhost)
	by s69819.wincent.com (8.12.11.20060308/8.12.11/Submit) id l7CBOtSt016307;
	Sun, 12 Aug 2007 06:24:55 -0500
Received: from 88.10.191.55
        (SquirrelMail authenticated user win%wincent.org)
        by secure.wincent.com with HTTP;
        Sun, 12 Aug 2007 06:24:55 -0500 (CDT)
In-Reply-To: <46BED5AA.7050900@lsrfire.ath.cx>
User-Agent: SquirrelMail/1.4.8-6.el3
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55675>

Ren=E9 Scharfe wrote:
>
> git diff passes the output through your pager by default, so you see =
the
> exit code of that instead of diff's.  Set PAGER=3Dcat or redirect the
> output to /dev/null to get rid of it.

Ah, thanks very much Ren=E9!

Best wishes,
Wincent

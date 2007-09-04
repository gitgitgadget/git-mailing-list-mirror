From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Rework strbuf API and semantics.
Date: Tue, 4 Sep 2007 19:18:46 +0200
Message-ID: <16188017-44C2-4854-8EF5-23271E8091BA@wincent.com>
References: <20070904115317.GA3381@artemis.corp> <11889144741644-git-send-email-madcoder@debian.org> <Pine.LNX.4.64.0709041642350.28586@racer.site> <20070904161843.GB3381@artemis.corp>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Sep 04 19:19:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISc3q-0006le-DG
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 19:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766AbXIDRT3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 4 Sep 2007 13:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754451AbXIDRT3
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 13:19:29 -0400
Received: from wincent.com ([72.3.236.74]:41222 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751701AbXIDRT3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2007 13:19:29 -0400
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l84HJP0s018687;
	Tue, 4 Sep 2007 12:19:26 -0500
In-Reply-To: <20070904161843.GB3381@artemis.corp>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57618>

El 4/9/2007, a las 18:18, Pierre Habouzit escribi=F3:

>   ooooh, now I'm guilty of not knowing all git APIs very well =20
> yet :) Indeed,
> this should just be:
>
>     void strbuf_grow(struct strbuf *sb, size_t extra) {
>         if (sb->len + extra + 1 < sb->len)
>             die("you want to use way to much memory");
>         ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
>     }

"too much memory", not "to much memory"

Cheers,
Wincent

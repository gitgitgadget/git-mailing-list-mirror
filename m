From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 07/25] parse-options: make some arguments optional, add
 callbacks.
Date: Tue, 16 Oct 2007 18:38:36 +0200
Message-ID: <4714E90C.80305@lsrfire.ath.cx>
References: <1192522616-16274-1-git-send-email-madcoder@debian.org> <1192523998-19474-1-git-send-email-madcoder@debian.org> <1192523998-19474-2-git-send-email-madcoder@debian.org> <1192523998-19474-3-git-send-email-madcoder@debian.org> <1192523998-19474-4-git-send-email-madcoder@debian.org> <1192523998-19474-5-git-send-email-madcoder@debian.org> <1192523998-19474-6-git-send-email-madcoder@debian.org> <1192523998-19474-7-git-send-email-madcoder@debian.org> <20071016084510.GI6919@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 18:39:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhpRe-0002i1-1s
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 18:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbXJPQiv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Oct 2007 12:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbXJPQiv
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 12:38:51 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:60300
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750754AbXJPQiu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 12:38:50 -0400
Received: from [10.0.1.201] (p57B7EF1C.dip.t-dialin.net [87.183.239.28])
	by neapel230.server4you.de (Postfix) with ESMTP id 8A19F873B9;
	Tue, 16 Oct 2007 18:38:48 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071016084510.GI6919@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61205>

Pierre Habouzit schrieb:
> This bit is to allow to aggregate options with arguments together whe=
n
> the argument is numeric.
>=20
>     +#if 0
>     +		/* can be used to understand -A1B1 like -A1 -B1 */
>     +		if (flag & OPT_SHORT && opt->opt && isdigit(*opt->opt)) {
>     +			*(int *)opt->value =3D strtol(opt->opt, (char **)&opt->opt, 1=
0);
>     +			return 0;
>     +		}
>     +#endif

I don't like it, it complicates number options with unit suffixes (e.g.
--windows-memory of git-pack-objects).

Ren=E9

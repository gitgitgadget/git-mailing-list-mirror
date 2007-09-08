From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/3] Add strbuf_rtrim (to remove trailing spaces).
Date: Sat, 08 Sep 2007 18:18:20 +0200
Message-ID: <46E2CB4C.8050209@lsrfire.ath.cx>
References: <20070902224213.GB431@artemis.corp> <11892523992761-git-send-email-madcoder@debian.org> <1189252399433-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Sep 08 18:18:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IU315-0004dz-T0
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 18:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891AbXIHQSd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 8 Sep 2007 12:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753153AbXIHQSd
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 12:18:33 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:41036
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752381AbXIHQSd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Sep 2007 12:18:33 -0400
Received: from [10.0.1.201] (p57B7D040.dip.t-dialin.net [87.183.208.64])
	by neapel230.server4you.de (Postfix) with ESMTP id 47EDF873B5;
	Sat,  8 Sep 2007 18:18:31 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1189252399433-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58129>

Pierre Habouzit schrieb:
> diff --git a/strbuf.c b/strbuf.c
> index acc7fc8..565c343 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -28,6 +28,13 @@ void strbuf_grow(struct strbuf *sb, size_t extra) =
{
>  	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
>  }
> =20
> +void strbuf_rtrim(struct strbuf *sb)
> +{
> +    while (sb->len > 0 && isspace((unsigned char)sb->buf[sb->len - 1=
]))
> +        sb->len--;
> +    sb->buf[sb->len] =3D '\0';
> +}

Please use tabs instead of spaces to indent, just like you did in your
other patches. :)

Ren=E9

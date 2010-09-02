From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 10/25] gettextize: git-merge basic messages
Date: Thu, 2 Sep 2010 15:09:40 -0500
Message-ID: <20100902200940.GB2531@burratino>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
 <1283456446-22577-11-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 22:11:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrG8I-0007od-3V
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 22:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756603Ab0IBULc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 16:11:32 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62516 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715Ab0IBULb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 16:11:31 -0400
Received: by fxm13 with SMTP id 13so588565fxm.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 13:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=c/Sab3ZCoephaJVOo88qGz7UB7uBlbBDHtgoVUSC7IQ=;
        b=F7F7rjwNrB6e+mQ8dCWwQaV/UM3ZqKQBykutDRP/u9LhRnsdffy+KA6gxqr74a4f+K
         s+k1/ogmTS2iyzsPTIq4fxhNdlTW4RefFeGCB1txpvZumNcPA+xVws9f+n22SAZxU5Dx
         u9DQlDaN/y3xcvFCCnV7VWMm+576YPWbeoEfU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=iNfbhxSK0xAMx5Z5hOzKRc5gpgVgB2GslrUj9p18pROuD0QzVbVITgBUHAirB9E+rV
         elXza0SYbByUS92e8cS7EVAEcI60dWFWtJP5sPdp8GpA1PCA6igy4GXCAcu0xImgjRE7
         BO8Flto59deAnzX7/WkZIPHgPYk/asuTZBow4=
Received: by 10.223.104.7 with SMTP id m7mr1763364fao.99.1283458290424;
        Thu, 02 Sep 2010 13:11:30 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r10sm455613faq.29.2010.09.02.13.11.27
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 13:11:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283456446-22577-11-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155192>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -116,13 +116,13 @@ static struct strategy *get_strategy(const char=
 *name)
>  		exclude_cmds(&main_cmds, &not_strategies);
>  	}
>  	if (!is_in_cmdlist(&main_cmds, name) && !is_in_cmdlist(&other_cmds,=
 name)) {
> -		fprintf(stderr, "Could not find merge strategy '%s'.\n", name);
> -		fprintf(stderr, "Available strategies are:");
> +		fprintf(stderr, _("Could not find merge strategy '%s'.\n"), name);
> +		fprintf(stderr, _("Available strategies are:"));

Another basic question (sorry for my ignorance): do translators prefer
whole paragraphs or line-by-line messages like this?  (Of course that
is not a topic for this patch; I am just curious.)

> @@ -513,7 +513,7 @@ static int git_merge_config(const char *k, const =
char *v, void *cb)
>  		int is_bool;
>  		shortlog_len =3D git_config_bool_or_int(k, v, &is_bool);
>  		if (!is_bool && shortlog_len < 0)
> -			return error("%s: negative length %s???", k, v);
> +			return error(_("%s: negative length %s???"), k, v);

What branch are you translating?  I am hoping the omgwtfbbq??! message
gets a chance to be tweaked before release.

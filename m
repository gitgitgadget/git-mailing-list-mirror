From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH/RFC 1/3] diffstat width: #define defaults in diff.h
Date: Sun, 28 Nov 2010 22:44:25 -0200
Message-ID: <AANLkTim6ddTgcYqfZQFK+wzYo2dm-nhVh-DFO5S3Ei4o@mail.gmail.com>
References: <4CF2EAD1.8030007@case.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthew Ruffalo <mmr15@case.edu>
X-From: git-owner@vger.kernel.org Mon Nov 29 01:44:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMrr7-0005Uw-3H
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 01:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435Ab0K2Ao2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Nov 2010 19:44:28 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42757 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754303Ab0K2Ao1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Nov 2010 19:44:27 -0500
Received: by bwz15 with SMTP id 15so3433606bwz.19
        for <git@vger.kernel.org>; Sun, 28 Nov 2010 16:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3V+riq35KC3/Fkda9CGtSnQTftcprdxPCPDMgnlyy2w=;
        b=Hvytr6Y5Kn1iLUcs/M2BddKPkQz+odt1vG9kPcanlxjlr4rIkwZDoB2bi43la/GfYO
         k+ihJFMK2WyUNRSpp2tHj1Ac5FtRHdlJICvUre2emgogJhKhZ/Ns72u2JJBaP02Ajgrq
         AHJ/ZH1+w6rNQZZpE4ZJPA488ikH6KLFPXSyo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=u+RlMyHByM02hn0A21TRJHUswGUzkCOF5mdqh1vZJ73RS5AU+x/oTw+Zx3BFOKNP8j
         1ASoiEDeHIk1WO/g4lr+47j8vFiKabthnUa/GBcVWl9EX+2F7HZJgyKWl1kM+5peVzSC
         nqQvSZLizl1bBORz38kzZ3qFMgWWCoZ3POBtE=
Received: by 10.204.79.142 with SMTP id p14mr4294343bkk.175.1290991465814;
 Sun, 28 Nov 2010 16:44:25 -0800 (PST)
Received: by 10.204.58.71 with HTTP; Sun, 28 Nov 2010 16:44:25 -0800 (PST)
In-Reply-To: <4CF2EAD1.8030007@case.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162371>

On Sun, Nov 28, 2010 at 9:50 PM, Matthew Ruffalo <mmr15@case.edu> wrote=
:
> diff --git a/diff.h b/diff.h
> index 0083d92..7b509c5 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -86,6 +86,9 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct
> diff_options *opt, void *data)
> =C2=A0#define DIFF_XDL_SET(opts, flag) =C2=A0 =C2=A0((opts)->xdl_opts=
 |=3D XDF_##flag)
> =C2=A0#define DIFF_XDL_CLR(opts, flag) =C2=A0 =C2=A0((opts)->xdl_opts=
 &=3D ~XDF_##flag)
>
> +#define DIFF_STAT_DEFAULT_WIDTH =C2=A0 =C2=A0 =C2=A0 80
> +#define DIFF_STAT_DEFAULT_NAME_WIDTH =C2=A050
> +

If this is only used in diff.c, can this be moved to diff.c instead?

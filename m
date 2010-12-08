From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 1/2] get_sha1_oneline: allow to input commit_list
Date: Wed, 8 Dec 2010 13:11:09 -0200
Message-ID: <AANLkTim1AN9TWiAFem4U0V7GuU45QfLEbNk_-k6rdtyQ@mail.gmail.com>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com>
	<1291820319-12455-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 16:11:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQLfp-0001my-TI
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 16:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755484Ab0LHPLM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Dec 2010 10:11:12 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:33854 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248Ab0LHPLL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Dec 2010 10:11:11 -0500
Received: by bwz16 with SMTP id 16so1397391bwz.4
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 07:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rldY6CDqLFoDRHAF6x7kyOXrx+GBqxXg+AeVUfq0kmM=;
        b=DIpk9JM7uHfUj2oMgv8wBMT9cT1QZl17J/oAoRa+lD/RbrFVXtCWI98ceExwfCuLpV
         nCzx143OKHa+fg7iGeXDMLN6bzr8ygmRelHM0iGcYRLZq0UFZnzxfyMVsysslNy78Azx
         e+x0Zm/iWAlGgx/TQv3ulpPl5Tm6QSvykmNVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dI86zPcvDQHodGmYitQC8rD63Koch6BgCduI/tZKqZAp1jFZxww1536Yo9eE8ywyGO
         92vqiYQMpcMSuOlMi6vi/eyW0+hzmDIq5FnHhel9fng2OZY9k546xoDdEGwkmuRFLxu+
         BoY6L8tq18tbnHQ281+QscsaUIb7ecFvtv8lk=
Received: by 10.204.76.137 with SMTP id c9mr1965254bkk.40.1291821069426; Wed,
 08 Dec 2010 07:11:09 -0800 (PST)
Received: by 10.204.58.71 with HTTP; Wed, 8 Dec 2010 07:11:09 -0800 (PST)
In-Reply-To: <1291820319-12455-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163198>

2010/12/8 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> -static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
> +static int get_sha1_oneline(const char *prefix,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 unsigned char *sha1,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 struct commit_list *list_)
> =C2=A0{

micronit: can we have a better name for |list_|, the suffix _ is very
ugly and uncommon :(

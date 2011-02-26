From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v4 64/73] gettextize: git-describe basic messages
Date: Sat, 26 Feb 2011 10:55:55 +0100
Message-ID: <201102261055.58539.jnareb@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org> <1298418152-27789-65-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 26 10:56:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtGt0-0002lP-JJ
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 10:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705Ab1BZJ4M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Feb 2011 04:56:12 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39177 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656Ab1BZJ4L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 04:56:11 -0500
Received: by fxm17 with SMTP id 17so2476947fxm.19
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 01:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=l6FldT3OrJcovzvaJwZPSt8TUhFZ2s7qqYmRzvosjYs=;
        b=bnv9c2i+6tme/1iu6xyEw2VaCsngFeFulU3FF9s5ERv7JQujdMpQECIqEGvb3yV9aA
         YyFN9ChskhJ0eK+HTxM2e8trSFijGItAjpYvtJQh9jY/YeBt1pgAGaXeQnjBD6IeuLVu
         npiax18SSQ0/p+XA6Er275hgTwJAWsEk9sb4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ra9Ix5vc3tBbHj4GPx8BGqIW9Y64QYwbclNtG3RSj4t2scU2vpZCGumHM5qgtQVfQo
         ZsGrTl8iIVlzGP8G+HxxnENgHzMHUbxKou+7m0NWhIX3AkVSpSk5K8f9ybUUBg0NTIDy
         hJPUXnHtGd8qS4dpEoyOb4xl6wXnvYGkqXsuo=
Received: by 10.223.103.4 with SMTP id i4mr3410905fao.123.1298714169901;
        Sat, 26 Feb 2011 01:56:09 -0800 (PST)
Received: from [192.168.1.13] (abwr26.neoplus.adsl.tpnet.pl [83.8.241.26])
        by mx.google.com with ESMTPS id y3sm687272fai.14.2011.02.26.01.56.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 Feb 2011 01:56:08 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1298418152-27789-65-git-send-email-avarab@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167965>

On Wed, 23 Feb 2011, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (strcmp(n->tag->tag, all ? n->path + 5 : =
n->path))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0wa=
rning("tag '%s' is really '%s' here", n->tag->tag, n->path);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0wa=
rning(_("tag '%s' is really '%s' here"), n->tag->tag, n->path);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0n->name_checked =3D 1;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}

Don't we need to use order notation to be able to change order of those
two parameters, i.e. use

  +                       warning(_("tag '%1$s' is really '%2$s' here")=
, n->tag->tag, n->path);

Perhaps also some comment for translators describing placeholders?

--=20
Jakub Narebski
Poland

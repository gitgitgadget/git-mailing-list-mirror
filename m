From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Having keywords without value is not a global error.
Date: Fri, 26 Feb 2010 09:19:28 +0100
Message-ID: <81b0412b1002260019r3d5268f2x4b48051409e0c8f5@mail.gmail.com>
References: <c28821e9079f35e7267a1e7381ccf7793c12bf24.1267156694.git.sdrake@xnet.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Steven Drake <sdrake@xnet.co.nz>
X-From: git-owner@vger.kernel.org Fri Feb 26 09:19:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkvQ8-0000Mm-2m
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 09:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935532Ab0BZITb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Feb 2010 03:19:31 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:63160 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935455Ab0BZITa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2010 03:19:30 -0500
Received: by bwz1 with SMTP id 1so160964bwz.21
        for <git@vger.kernel.org>; Fri, 26 Feb 2010 00:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fwOnZ+rMhcu3/Fz7gaSiOk+eGYFBMlIz9A5pqPMPKKY=;
        b=iehs4ECmksXpdwUNOZvU2XhjRmNNgyslK60M2heqPbbfu6yQsM0MjxuoagM6tugsdj
         Nxcwcn6paPA2y58gFxCVi5r4mrmW48RSJ30UusU7HBRX6zNBNzxhLeOmpTofEUvohtk7
         vlsL9jFVqvwSy+BJT1soWSNO5OagEC+2qBLvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Cpv7+O1kxxG6/nrTij6uJRcbfNXEyKWFDO+iVGPo+NXZP1+TJKN+uXMlrzrFoaI6Cq
         4RFwnJnXfmt7iQ9kLHopEju/zqOGMnV06ZHEgt4mbCmj0dGz51AN5UVfYfc5JqK6pAsH
         N6ZQ2At/xbgzt1nvwYiAlguHYYVauMryt2ORQ=
Received: by 10.204.16.83 with SMTP id n19mr30586bka.96.1267172368441; Fri, 26 
	Feb 2010 00:19:28 -0800 (PST)
In-Reply-To: <c28821e9079f35e7267a1e7381ccf7793c12bf24.1267156694.git.sdrake@xnet.co.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141113>

On Fri, Feb 26, 2010 at 05:00, Steven Drake <sdrake@xnet.co.nz> wrote:
> It is not a good Idea to give a config_error for _any_ keyword withou=
t a
> value as it means that
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[section]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0keyword
>
> sytle can not be using for setting bool type keyword.

Typo: sytle (style?)

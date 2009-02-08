From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv3 1/3 (resend)] gitweb: Modularized git_get_project_description to be more generic
Date: Sun, 8 Feb 2009 13:34:42 +0100
Message-ID: <200902081334.42780.jnareb@gmail.com>
References: <87zlgxp595.wl%seb@cine7.net> <200902081210.49328.jnareb@gmail.com> <87tz75p3ej.wl%seb@cine7.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-2?q?S=E9bastien_Cevey?= <seb@cine7.net>
X-From: git-owner@vger.kernel.org Sun Feb 08 13:36:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW8tm-00046T-LP
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 13:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbZBHMez convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2009 07:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752509AbZBHMez
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 07:34:55 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:41051 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbZBHMey (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 07:34:54 -0500
Received: by bwz5 with SMTP id 5so493616bwz.13
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 04:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=fWH2ncys6kbJXUg9XWtoJTcPkh2PccIotc4cS0QfBzQ=;
        b=lqlhXGbFwiyscxg6+xwYrHPdnE2J3HIRdnrLONx7VKV8aUAk9+zHl0iC0U3B6RMt9l
         q9cJhbHNdggucl6IHvqJdwhDNGz40DKSb/zlH7IPaex+AkvBjUvUwynYuNocXSniYXai
         6X3JmooZC3tZmz8aDvGOdD3LelQVn1EkMZQdw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=MGQQA4l2fWxmD7+7Sz/P7NlVVFrcZvD8HXDWJxj2VaoTS9/A42RuF6HtWt+T6EP9fe
         Vtb1/UsjWtDqcZr/RxXBjg2NaUHJrcibYF/eZiM1VWSsurwpLshKbRtexkcBX3JZ4ahY
         PuOcGoUBiYcflA8AiWK7w3+wP34dC0mIgpWRc=
Received: by 10.223.105.208 with SMTP id u16mr947565fao.14.1234096491759;
        Sun, 08 Feb 2009 04:34:51 -0800 (PST)
Received: from ?192.168.1.13? (abwm89.neoplus.adsl.tpnet.pl [83.8.236.89])
        by mx.google.com with ESMTPS id z10sm2864423fka.33.2009.02.08.04.34.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Feb 2009 04:34:51 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <87tz75p3ej.wl%seb@cine7.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108969>

Dnia niedziela 8. lutego 2009 12:35, S=E9bastien Cevey napisa=B3:
> At Sun, 8 Feb 2009 12:10:48 +0100, Jakub Narebski wrote:
>=20
> > Due to changes to gitweb, while first patch in (earlier version of)=
=20
> > series applies cleanly, second patch didn't, and git could not find
> > base to fall back to 3-way merge (because second patch is based on
> > state after first patch, and situation after first patch changed).
> > It is much easier to rebase series if youhave them as commits, and
> > not as series of emails.
>=20
> Sure, I'll make sure of being rebased onto git master HEAD (or should
> I rebase onto another development branch?) next time.  But is this
> resend properly merging and working for you?

They got imported correctly, at least.

Thanks again!

--=20
Jakub Narebski
Poland

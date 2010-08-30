From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Odd encoding issue with UTF-8 + gettext yields ? on non-ASCII
Date: Mon, 30 Aug 2010 08:41:36 -0500
Message-ID: <20100830134136.GA2315@burratino>
References: <AANLkTi=cb5zyKyogdunB6NzWDk99V2hSg-c0vQpwKM-Z@mail.gmail.com>
 <AANLkTikHbxrmj3R1LDghVvMA1KNEdfeiXj44cq1KRN7M@mail.gmail.com>
 <20100828214641.GA5515@burratino>
 <20100828215956.GB5515@burratino>
 <alpine.BSF.2.00.1008282213420.67930@x.fncre.vasb>
 <20100828221655.GB5777@burratino>
 <AANLkTimn+-5Vys+jg=ryDfwdJ=WZfGwgZ+065M_=TF8r@mail.gmail.com>
 <20100829204519.GB1890@burratino>
 <AANLkTin4A6B9zqSYHsWQ+GLWRqLvzJWAQ0F2WC85zDqC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marcin Cieslak <saper@saper.info>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 15:48:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq4ik-0004yO-DU
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 15:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831Ab0H3NsP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 09:48:15 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56233 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676Ab0H3NsP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 09:48:15 -0400
Received: by pzk9 with SMTP id 9so2052966pzk.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 06:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=bXow1mp8ceEim9+f+mTOIZi5RTDlHPfcrWpI7eET8yI=;
        b=vvra+phQioFyP011fIFOZmcLpphzR/OcykOtoV5ysSwF2WML6XZeF0l79H68mbLIGz
         iIlcom93ZTw42It3k5OF26OeHiqbgcthvZfdtg0pitAFV4/y4rI9nIiXk5E1xT/8QruQ
         2YcGs67oZegcnP1w6bx6o7YD4706L/fpmCmB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=kkhC5fwmWxpxvt62JzR5wtKU6DhpbaDDTb2VJQINFBX4dvU1Yo2MZGHsJqOumhdv7N
         Ul0Tio3OEQJIaGTDQpcafDV4OOG5N89DtZV/lMJEwEfGiXnH9rzDPd9iOMTLm9gyg4bE
         ErdEzCPmhtR0v9ExrIDxUhu5+Co3CTgf7hOwU=
Received: by 10.142.161.3 with SMTP id j3mr4570166wfe.145.1283175804492;
        Mon, 30 Aug 2010 06:43:24 -0700 (PDT)
Received: from burratino ([128.135.11.176])
        by mx.google.com with ESMTPS id a16sm2384599vcm.42.2010.08.30.06.43.21
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 06:43:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTin4A6B9zqSYHsWQ+GLWRqLvzJWAQ0F2WC85zDqC@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154801>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> We can even keep the "Content-Type: text/plain; charset=3DUTF-8\n" an=
d
> *not* use LC_CTYPE if we add a bind_textdomain_codeset("git", "UTF-8"=
)
> call to gettext.

Oh!  I'd personally prefer to do that for now. :)  (Not because of the
known printf problem but because I like to reduce possible unknowns.)

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 06/17] gettext: localize the main git-init message
Date: Tue, 31 Aug 2010 10:48:36 -0500
Message-ID: <20100831154836.GK2315@burratino>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
 <1283203703-26923-7-git-send-email-avarab@gmail.com>
 <20100831151044.GF2315@burratino>
 <AANLkTimVGJugnxFzk9Vy2BOZiH=PXWmNs108qs1oSwdy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 17:50:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqT6e-0003eY-B2
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 17:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475Ab0HaPuY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 11:50:24 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51485 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932426Ab0HaPuV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 11:50:21 -0400
Received: by vws3 with SMTP id 3so5475678vws.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 08:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=iRqk9taChsqDhESqzvr9wtZk6iodHHHv6+XMk6aMKJI=;
        b=oIhhJao0uqgCmtCb3qpq5wI0EYHxYhj4vfY6MEE0G9Nk+++svcNL/rNH54y/dobQuC
         YHzKHiT3XMaZP9UPDRhrY2ZtdoirESbClvVbE0YmlJEJ93xuHabLipc9hwgAih5T96uw
         kYrOSP664jJpXqLTFB4peTDt0YeetpisEV01g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=DfZOGS6D8F/CGo9VRZ45ucpmbbD8GW7F9f/h9fy6obfBEkyDNuCdKTQ1yiBEptiInR
         T1lMVg1BlnUFDe75u+2A1tJyYUEWUzwjF56eC3RMWaJlvYkL/DVgQP9RzIPOhTkPW+Jk
         34HJ6E7xdBanxTW4Vyc/WUt5UgCwu2JGxSASY=
Received: by 10.229.184.14 with SMTP id ci14mr4337637qcb.124.1283269820475;
        Tue, 31 Aug 2010 08:50:20 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id f15sm9843074qcr.13.2010.08.31.08.50.19
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 08:50:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimVGJugnxFzk9Vy2BOZiH=PXWmNs108qs1oSwdy@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154918>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>>> This is because everything from "/* TRANSLATORS: " to "*/" will
>>> extracted as-is xgettext(1) and presented to translators, including
>>> newlines and leading "*"'s.
[...]
> As I was (trying) to get across in the the commit message it'll make
> the *'s part of the message. I.e.:
>=20
>     TRANSLATORS: * The first '%s' is either "Reinitialized existing"
>     or * "Initialized empty", the second " shared" or "", and * the
>     last '%s%s' is the verbatim directory name.

Ah, so you meant "not including newlines but including leading '*''s".

Hmm, this is annoying.  Searching existing projects, it seems that
a lot of people are just not using the TRANSLATORS: feature except
for one-line comments.

Thanks for the explanation.

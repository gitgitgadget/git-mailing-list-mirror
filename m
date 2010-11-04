From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: [PATCH] diff,difftool: Don't use the {0,2} notation in usage strings
Date: Thu, 04 Nov 2010 22:30:41 +0100
Message-ID: <878w18hj3y.fsf@gmail.com>
References: <87wrp12p00.fsf@gmail.com>
	<AANLkTinyPkGmsgbGM9qpXMNcZRzOXvtjDDEkJ-i3nWXz@mail.gmail.com>
	<87fwvl2d4d.fsf@gmail.com> <87hbfxgg86.fsf_-_@gmail.com>
	<20101104174917.GA30628@sigill.intra.peff.net>
	<20101104180242.GA16431@burratino>
	<20101104181357.GA31016@sigill.intra.peff.net>
	<20101104183851.GA16865@burratino>
	<20101104185545.GB31016@sigill.intra.peff.net>
	<87d3qkhm3d.fsf@gmail.com>
	<20101104204304.GA4641@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Mark Lodato <lodatom@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 04 22:32:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE7Pt-0005Ww-3M
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 22:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257Ab0KDVcM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 17:32:12 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41468 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931Ab0KDVcK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 17:32:10 -0400
Received: by fxm16 with SMTP id 16so1873824fxm.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 14:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :in-reply-to:references:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=VcbU+fJJMuFisEAdgJDIq5NaEp1t5kJKlVlDOXu8akk=;
        b=Hn0XXkrwTmXOIBH4KxQVWd82unCgmY1zZWvhzrM6EgZXNOnFRpFqQLbzE2VJWmITwd
         wCcjVSp89z8EWduQxFyU/po8DvKPMva39csCUHN6hw/X332sz5E3dFbUVQBzm5FCx+EP
         zI68VN8heqglvh6GxZqYdamPbqW+jlQsFITFA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        b=ajVeCUHmwxdd2ytTxI5SuCp96MnATBtbF+kVGn0VqwzJGb3PmlIbebnzsXnpIPcp+v
         0OB/KAighhbxgeeEypXwPfeA2y0KWeRmdybhO2cWSqeHIhWGoIz4FR7l2Gt8Hc7lD0qI
         euF4mknocIqPCBS0GD+Cl5GFaphqMFXqYS2GY=
Received: by 10.223.78.199 with SMTP id m7mr236277fak.11.1288906328470;
        Thu, 04 Nov 2010 14:32:08 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id k4sm278426faa.8.2010.11.04.14.32.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 14:32:07 -0700 (PDT)
In-Reply-To: <20101104204304.GA4641@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 4 Nov 2010 16:43:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160772>

Jeff King <peff@peff.net> writes:

> My main argument against that would be that if we are planning on
> changing it to something totally different right now anyway, your pat=
ch
> will just end up making textual conflicts for Junio to resolve. :)

Right. I hoped you'd come up with a patch yourself, which now happend,
so, thank you. :-)

> Yeah, sorry to come in late to the discussion. I missed the other thr=
ead
> entirely. I think getting rid of {M,N} is fine. In general, your
> proposed replacement is better. It's just that in this case it seemed=
 to
> be obfuscating a subtle point that the original syntax (as ugly and
> incomprehensible as it was) called out.
>
> So yes, go ahead with your coding guidelines patch. I'll summarize wh=
at
> Jonathan and I discussed with a new patch.

In that case the v2 [1] is still a valid review target, thanks.

=C5=A0t=C4=9Bp=C3=A1n

[1] Earlier in the thread and here for anyone interested:
http://article.gmane.org/gmane.comp.version-control.git/160733

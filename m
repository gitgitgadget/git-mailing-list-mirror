From: =?ISO-8859-1?Q?J=E9r=E9mie_NIKAES?= <jeremie.nikaes@gmail.com>
Subject: Re: Git fast-import : Warning duplicated ref: refs/remotes/origin/master
Date: Mon, 30 May 2011 22:32:21 +0200
Message-ID: <BANLkTi=+v0Jt2+xgxy=qV+BT7pOUMpoMtw@mail.gmail.com>
References: <BANLkTinTuEppMGO16z2sMkjV8FveCbrwEQ@mail.gmail.com>
 <20110529232405.GA8369@elie> <BANLkTinhH7ksP8EZV+Sd4ryCT1_bhVhgaw@mail.gmail.com>
 <20110530173517.GA13539@elie> <vpqzkm4gef2.fsf@bauges.imag.fr> <20110530201351.GB14427@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Mike Hommey <mh@glandium.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 22:32:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR98p-0003jT-Fk
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 22:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754610Ab1E3Ucm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2011 16:32:42 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:43520 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734Ab1E3Ucl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2011 16:32:41 -0400
Received: by pvg12 with SMTP id 12so1733736pvg.19
        for <git@vger.kernel.org>; Mon, 30 May 2011 13:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=pOmm9OFWiSCba62FFP7IsOlkyBRyDq8PGwu0z8Z15WY=;
        b=Fa6r30l6/FyUExOC6RMWWDpSb4Sh85dc0lQqPrOmOtozTJObt9ppKJ8YX7Ixt04LXS
         GVOdhvUULMIUVkEvRncqsYYl5ioCjb4Epu/uF3tCVWOtXG2TXIwJ+wE4ccaU/WIdXpXo
         1ysHylG5jJjeCvLfZWslL0wWj9ugKILnt7PLY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=kimQy3Ruc0Kcm0M7k77bS6BK6go9zcm3qk8Sm6LelWkF31hD3u5Z7gwY6nVcWtF6UM
         /xUz06FAz7UWXuzvegJa8xOSlAEeERuWBpikjoPlZRNlPxyh4ChPDixnj1hsTR/9kSjp
         fb2sGyOmlQ1s7mb31TEFnVdlgJFQ3SH1oHHbw=
Received: by 10.142.230.20 with SMTP id c20mr732040wfh.357.1306787561097; Mon,
 30 May 2011 13:32:41 -0700 (PDT)
Received: by 10.142.234.5 with HTTP; Mon, 30 May 2011 13:32:21 -0700 (PDT)
In-Reply-To: <20110530201351.GB14427@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174778>

> Matthieu Moy wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:

>> If so, I don't understand why the distinction between 1) and 2) is
>> necessary, and why not to fetch directly into refs/remotes/origin/. =
IOW,
>> in which case is refs/remotes/origin/master different from
>> refs/mediawiki/origin/master for example?
>
> That's a good question. =A0One answer is that fetching to elsewhere
> allows the transport machinery to take care of rejecting non-fast-for=
ward
> fetches and pretty-printing the ref update information:
>
> =A0From mediawiki::http://localhost/mediawiki
> =A0 =A0479ee21..accd2c1 =A0master =A0 =A0 -> origin/master
>
> I think in the long term, importing to no ref at all as Sverre
> suggested and teaching the transport-helper to do the ref update woul=
d
> make more sense.

Well yes that would indeed make more sense. It feels weird to have to
do it like this.
Anyways, thanks a lot again for your help, a rfc patch should come
relatively quickly with the project in its current state.

Regards,
--=20
J=E9r=E9mie Nikaes

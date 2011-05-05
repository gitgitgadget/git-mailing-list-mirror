From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: t5541: Bad file descriptor
Date: Thu, 5 May 2011 20:51:29 +0200
Message-ID: <BANLkTin82XVOQaE4i9BJu3Eyr5v_8MOaOg@mail.gmail.com>
References: <3340686A-18D8-4279-87F0-580262DD4DFA@gernhardtsoftware.com>
 <7voc3hbtgu.fsf@alter.siamese.dyndns.org> <20110505054611.GA29033@sigill.intra.peff.net>
 <20110505061634.GB29033@sigill.intra.peff.net> <BANLkTin8YUwoMmxXLske=5nuvW+idBOuig@mail.gmail.com>
 <BANLkTi=y+34s+yO9LVuiUxB5Xz3v7Pc2Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 20:52:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI3et-0007OE-MS
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 20:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187Ab1EESwL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 14:52:11 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:54331 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932153Ab1EESwJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 14:52:09 -0400
Received: by qwk3 with SMTP id 3so1680940qwk.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 11:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=XhWj/AAHTk6gGH9mQygaMxzdQTOnYPEDyqWWdgu9Q7Q=;
        b=QzdsdH49ZiuymFczDanGbrxRMwGJixbjX9/0opYmpTitUQh6osq2tsjv2EID5SZRPj
         lvo/NcWIZeyOpfJ3848qQYKEidbG0qpDAYlnymU21HtXmRLL5qixBjm5TuBP3mYHt731
         DM0dxibPRfi8VaQeWXy/gQPUSm/VbvtMB5qng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=l+22/El5BzfKloidFqZh9dTdPAzpExjOVhEWEolNCobo0EQTD2SY05CqNbKTPifzFe
         WICH6Wl5ZiKhcesETsn5qDUYCy5aQWY0py58HUflwHuEIW6iGw643NZnBcE2NY2EHrAE
         YAPw6QGeJ1ZqXT3K/LBh34BbUs6Py/us4pa7k=
Received: by 10.229.63.143 with SMTP id b15mr1845462qci.136.1304621529121;
 Thu, 05 May 2011 11:52:09 -0700 (PDT)
Received: by 10.229.75.70 with HTTP; Thu, 5 May 2011 11:51:29 -0700 (PDT)
In-Reply-To: <BANLkTi=y+34s+yO9LVuiUxB5Xz3v7Pc2Mw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172877>

Heya,

On Thu, May 5, 2011 at 19:59, Avery Pennarun <apenwarr@gmail.com> wrote=
:
> I was running one, didn't think anybody cared about it though. =C2=A0=
Please
> point me at the necessary docs for this test and I can set up a new
> one in my copious spare time (tm). =C2=A0I can't promise to monitor i=
t
> though, so that might be more of a problem :) =C2=A0gitbuilder does p=
roduce
> rss feeds that are easy to track.

I don't think there are any docs as such, but see t/lib-httpd.sh.
Should be easy enough to deduce which variables to set to what from
that.

--=20
Cheers,

Sverre Rabbelier

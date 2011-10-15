From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv3] daemon: give friendlier error messages to clients
Date: Sat, 15 Oct 2011 01:16:43 -0700 (PDT)
Message-ID: <m3r52e7js7.fsf@localhost.localdomain>
References: <7vsjn9etm3.fsf@alter.siamese.dyndns.org>
	<1317678909-19383-1-git-send-email-pclouds@gmail.com>
	<20111012200916.GA1502@sigill.intra.peff.net>
	<20111013044544.GA27890@duynguyen-vnpc.dek-tpc.internal>
	<20111013182816.GA17573@sigill.intra.peff.net>
	<7vvcrs181e.fsf@alter.siamese.dyndns.org>
	<20111014131041.GC7808@sigill.intra.peff.net>
	<20111014192326.GA7713@sigill.intra.peff.net>
	<20111014210251.GD16371@elie.hsd1.il.comcast.net>
	<20111014211244.GA16429@sigill.intra.peff.net>
	<20111014211921.GB16429@sigill.intra.peff.net>
	<CAMK1S_g0aKUa=+ndAm7rqeoPAobjVb6oJ1Z4DqSeNrdauXNH3w@mail.gmail.com>
	<7vk486x0hq.fsf@alter.siamese.dyndns.org>
	<CAMK1S_gkB49qhnt8U=3G3UPnjo2vzFx5mL4cOM1Ubu68ySJrDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 15 10:17:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REzQT-0005eL-Nw
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 10:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820Ab1JOIQs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Oct 2011 04:16:48 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48860 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707Ab1JOIQq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Oct 2011 04:16:46 -0400
Received: by bkbzt19 with SMTP id zt19so957020bkb.19
        for <git@vger.kernel.org>; Sat, 15 Oct 2011 01:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=PWXhjE8Jad/KaJBtmWHQ0iT/mDtenWe8ZnDw7GTx31w=;
        b=IXtHWLKnP7m0Z6xGW7p/GSLucvLRhcMjyC6bGAXSeqPUZx9luMznynsLfCUbd9d+Wu
         qqhg9GgqUZrtQ0a3LGzoXtqQh537z7QMyJ8eiukjh/30CY6FTRoOe4m9tN3ZrCqae4sy
         soJw1r5YNI5BX4NLIyBZbfZg4dgEmQHoAu8Vk=
Received: by 10.223.92.144 with SMTP id r16mr9558521fam.23.1318666604808;
        Sat, 15 Oct 2011 01:16:44 -0700 (PDT)
Received: from localhost.localdomain (abvs179.neoplus.adsl.tpnet.pl. [83.8.216.179])
        by mx.google.com with ESMTPS id f10sm8845589fac.14.2011.10.15.01.16.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Oct 2011 01:16:43 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p9F8Fspa030214;
	Sat, 15 Oct 2011 10:16:04 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p9F8FL5W030209;
	Sat, 15 Oct 2011 10:15:21 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAMK1S_gkB49qhnt8U=3G3UPnjo2vzFx5mL4cOM1Ubu68ySJrDA@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183646>

Sitaram Chamarty <sitaramc@gmail.com> writes:
> On Sat, Oct 15, 2011 at 11:25 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> Sitaram Chamarty <sitaramc@gmail.com> writes:
>>
>>>> Because there is a risk of leaking information about
>>>> non-exported repositories, by default all errors simply say
>>>> "access denied". Sites which don't have hidden repositories,
>>>
>>> I suggest that even the "secure" version of the message say somethi=
ng
>>> like "access denied or repository not exported". =A0You're still no=
t
>>> leaking anything, but it reduces confusion to the user, who otherwi=
se
>>> may not realise it *could be* the latter.
>>
>> I kind of like the suggestion, but I am afraid that "access denied,
>> repository nonexistent or not exported" can soon easily get long eno=
ugh to
>> be unmanageable.
>=20
> When someone who *does* have access makes a typo, "access denied"
> makes it harder to realise it, because it subtly implies the repo
> *does* exist and it's an ACL issue.  I've seen lots of frustrating
> back-and-forth between admin and user before someone eventually
> noticed the typo.
>=20
> "Access denied or no such repo" is much better.  (The "not exported"
> nuance is not relevant in this context; you can safely ignore it.)

To join this bike-shedding:

  "Access denied or repository not available"

or just

  "Repository not available"

--=20
Jakub Nar=EAbski

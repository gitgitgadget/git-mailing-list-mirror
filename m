From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH 0/7] Make "$remote/$branch" work with unconventional refspecs
Date: Mon, 6 May 2013 21:17:11 +0200
Message-ID: <CA+gHt1AiFgzjN0ZjEhQNUsQ1XfES36ChUNCHjGyUJsEWTSfpCQ@mail.gmail.com>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
 <7vr4hmuk20.fsf@alter.siamese.dyndns.org> <CALKQrgdp9DVDBLNwCAmQHbEfZDvhdsmSW3sh1BRo1XEnyqPPaA@mail.gmail.com>
 <7v8v3tuu6i.fsf@alter.siamese.dyndns.org> <CALKQrgf6NcT2tEGMTczxR2WspOi4NjrN_kxmKN-QyE2Py3iSaQ@mail.gmail.com>
 <7vvc6xt5ov.fsf@alter.siamese.dyndns.org> <CA+gHt1Aq+Hi5Uf-s+q5WaigHXP1Qyq100N=C4x4pwFf8-Q=GcA@mail.gmail.com>
 <CA+gHt1DAy+OF-A8PiANM8k3=HdpsH8B-EWV5a3Dqv9svxCbZfA@mail.gmail.com> <7vd2t4rq2p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 06 21:17:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZQun-0000BL-Lp
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 21:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523Ab3EFTRd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 May 2013 15:17:33 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:53507 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312Ab3EFTRd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 May 2013 15:17:33 -0400
Received: by mail-lb0-f177.google.com with SMTP id 13so3672757lba.8
        for <git@vger.kernel.org>; Mon, 06 May 2013 12:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=W1upGpvdE4bkZ88rasS+2Wd2fW003+Ej0Giqn4gxQNA=;
        b=Ot2G1YDi/nGwZMHAdoXaUJZhfptvo0zYiCMgeKDC6mhxnv7HVyCyOkOUO6Yn68NkFD
         a5MRiHRAagyVa2kfWYksDdkYAplgPKb/3c6qHK/tYx4de4juX3HvYws88+6Cx/qjPIQ5
         Nc0e5bCbj2crPQOiZ4V7AkHzSvXOa960NzAg1IsWU6+10FEUlLcaLblPrmwQT2AcBrz1
         JeqjkdI/vEJzg0Vi1u8v8xwczVKXSaO0bF6NV6i+NPWe+2iN5pwGNVxOEKvGcxRLxXKR
         ZW3FnNyYWEHhyM/QaQa4YvcNNXeodMXPUaQHuYr65ZzNClh4i+yjF3SimnuBCd+jI913
         L+PA==
X-Received: by 10.112.163.105 with SMTP id yh9mr8604909lbb.63.1367867851515;
 Mon, 06 May 2013 12:17:31 -0700 (PDT)
Received: by 10.114.184.180 with HTTP; Mon, 6 May 2013 12:17:11 -0700 (PDT)
In-Reply-To: <7vd2t4rq2p.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkx9ETyw60F1lRPkApfPtUCQVWaebxfML6PlHmZDjsf20N3WiNE+NdDKbbxrs8LI8GdTJSa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223489>

El 06/05/2013 19:11, "Junio C Hamano" <gitster@pobox.com> va escriure:
>
> Santi B=E9jar <santi@agolina.net> writes:
>
> > The next question could be: why not make it work with $url too? As =
in:
> >
> > $ git merge git://git.kernel.org/pub/scm/git/git.git//master
>
> You need to remember "merge" is a local operation, working in your
> local repository.  Like it or not, the UI of Git makes distinction
> between operations that are local and those that go to other
> repositories (e.g. "git pull").
>

Of course! In fact I wanted to say "git pull".

Santi

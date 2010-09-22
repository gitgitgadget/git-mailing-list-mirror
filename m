From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 000/160] [PULL] Update ab/i18n (again)
Date: Wed, 22 Sep 2010 19:36:42 +0000
Message-ID: <AANLkTinMkc6nH2+tLBVym7pSSzvTEBbgiqJSD5w3G3kz@mail.gmail.com>
References: <1285015029-23103-1-git-send-email-avarab@gmail.com>
	<7vsk11sjf9.fsf@alter.siamese.dyndns.org>
	<AANLkTimKp+u2QGhR=zFYTSALcxRUr=LQewYRK83uh+U1@mail.gmail.com>
	<7veiclshoe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 22 21:36:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyV7a-0008MC-Um
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 21:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755344Ab0IVTgo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Sep 2010 15:36:44 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60454 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834Ab0IVTgn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Sep 2010 15:36:43 -0400
Received: by gyd8 with SMTP id 8so304858gyd.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 12:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WZCL3OvyKnFwjVExsIKJ6uief1PJPRstDDZqKY3EgpQ=;
        b=SDvh2jgMtPoWy8qEpjOsJZp0kqZNgIueOlaynOch4Ld3QVjM9zi8N8GILVD4RHM6DW
         FPN8AJgalaW1unvontvx9z3jxAusdQDpT1cGLKa+aIq+HoWmWfuU+JfOdRjeRNJmILKg
         g83CJSag8rcDi+ETk1I/vYF+jEcJwHd4g9ntc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Pjc3TbrjkIupnGI0aIWS1HTF6OiD5M1pyCH49RiGzZHYx4M0zgBfcoSS6OPkrpstSB
         41G4OBJ/UQDNxeGdHL4LNgT13+v45PSpgM/3JysPozjzfrTY+Xzxh/++uSM5XETFchEO
         cr4P8at/8IT4uVi19vM3y0XZFbtjmKM36yXFU=
Received: by 10.100.57.17 with SMTP id f17mr728180ana.35.1285184202489; Wed,
 22 Sep 2010 12:36:42 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Wed, 22 Sep 2010 12:36:42 -0700 (PDT)
In-Reply-To: <7veiclshoe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156831>

On Wed, Sep 22, 2010 at 19:26, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Oops, I didn't try running "make doc". I could write a
>> Documentation/git-sh-i18n.txt manpage, but it would probably be bett=
er
>> to just remove the patch adding it to command-list.txt, no?
>
> If it is not a documented end-user level command, it shouldn't be in =
the
> list.

Ok. I've ejected that patch out for now, and fixed a two minor bugs
One NO_GETTEXT_POISON test was in the wrong patch, and I completely
removed the test that checked that $GIT_ROOT/share/locale wasn't there
under NO_GETTEXT=3DYesPlease from the series altogether.

I've updated the ab/i18n ref at GitHub, you can pull that.

> Don't you however want to help developers by describing what the
> helper offers, similar to how e.g. Documentation/git-sh-setup.txt doe=
s?

Yes, but not today if that's OK. For now it's documented in
po/README. But I want to move all those docs to manpages in the
future. I'll submit something for that later, but not now :)

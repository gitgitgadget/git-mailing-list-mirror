From: Elijah Newren <newren@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2011, #02; Sat, 11)
Date: Mon, 13 Jun 2011 22:27:50 -0600
Message-ID: <BANLkTin-sAXAZ4ZJ9z77SSYx+xYTYeZMww@mail.gmail.com>
References: <7voc23sfxd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 06:27:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWLEL-0000p3-7o
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 06:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171Ab1FNE1w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jun 2011 00:27:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42018 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800Ab1FNE1v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2011 00:27:51 -0400
Received: by fxm17 with SMTP id 17so3221609fxm.19
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 21:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MsQKU7hUhi7eGK/n7+Jbu8qugV8bUkZmV/szD/NJfjc=;
        b=l/HfjXILgnSCwjWOofkB2HbsxcO/waSyweTkUl9gkkJSONq9Y7a9qIBhy1bicQPL2O
         tnUGTcMo65oz6QT8sfMlapZkkGtKaAyWAQbsLWa8pn7nN9HX/x2Xi+B21UnQv9s2GuY2
         couv+okdZQDjKesewRC9dt8YkQIgiiUjXpRSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Gk0O38WvpHtlCiuYQLTBZJLiKgHDja4FB/bAlZpFd0fYFpWEiJcZRmBf8K2BeA/oSG
         CJYtbPAO33JcmcOZA9QI5ojw9C6qOOF74LBtlHzzU4MB2R6OnJDIaLngo0S3UBr4CxiI
         UkxrvEhhCVYuDoZgvyKhQautb6STfkUoXc9Qc=
Received: by 10.223.13.10 with SMTP id z10mr60496faz.69.1308025670527; Mon, 13
 Jun 2011 21:27:50 -0700 (PDT)
Received: by 10.223.54.90 with HTTP; Mon, 13 Jun 2011 21:27:50 -0700 (PDT)
In-Reply-To: <7voc23sfxd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175743>

Hi,

On Sun, Jun 12, 2011 at 12:49 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Here are the topics that have been cooking. =C2=A0Commits prefixed wi=
th '-' are
> only in 'pu' while commits prefixed with '+' are in 'next'.
>
> --------------------------------------------------
> [Stalled]
>
> * jk/maint-merge-rename-create (2011-03-25) 3 commits
> =C2=A0- merge: turn on rewrite detection
> =C2=A0- merge: handle renames with replacement content
> =C2=A0- t3030: fix accidental success in symlink rename
>
> Peff wanted to reroll this. Perhaps will discard to make room for Eli=
jah's
> merge-recursive series in the meantime.

Peff: Do you want any help rerolling, updating, reviewing, etc.?  I
don't want to cause any undue problems with my merge-recursive series,
and besides, the idea you have in this series looks like it may be
interesting.

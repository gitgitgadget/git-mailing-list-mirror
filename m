From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v8 3/4] submodule: fix sync handling of some relative
 superproject origin URLs
Date: Mon, 4 Jun 2012 09:52:05 +1000
Message-ID: <CAH3AnrrUNq9q54dxQidAKD5oAmTSs2hJnWR09jWxmZFYgnfKFw@mail.gmail.com>
References: <1338716810-9881-1-git-send-email-jon.seymour@gmail.com>
	<1338716810-9881-4-git-send-email-jon.seymour@gmail.com>
	<7v1ulwxd0o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, j6t@kdbg.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 01:52:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbKbI-00021C-0r
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 01:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260Ab2FCXwI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Jun 2012 19:52:08 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:43852 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755257Ab2FCXwH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jun 2012 19:52:07 -0400
Received: by wgbdr13 with SMTP id dr13so3515000wgb.1
        for <git@vger.kernel.org>; Sun, 03 Jun 2012 16:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=a+SW1MKbfTqZGOVV3WdUFTPy8Eff6FUyjagiDFv80fQ=;
        b=j2SmibqsWRcL4tsYzo+EumiAVzkuCE05RUddIE9dPXQRsbn9oIGREJFUA3/TGuT7IO
         R/FWJaLnD/YpKf5QqCj/sQ63PgTxhQ2DQigxJJeJo8Z1IjGw1Cj8bGO3M1wz0zlPbkP2
         +VNDc9iHhqbhdrpq8c76Q2qKAup+W5i7Dsl6hpF59sroUiu7BHCDIjeJP8b6LG1iqjLT
         g0/FckNByXjWJytZmkSAF5SmdK0zkgnLNzOeTxLeMB9vnHfV+00WUAC0nFnDQiD9AcJF
         pIDY0/I0jnmdoBmoJJyUWiPGFAsFDPJ6YQz1d0dHWM1WvtAb27TJW7u/Z3OYZa9s3sVF
         YCsw==
Received: by 10.216.143.105 with SMTP id k83mr8611000wej.99.1338767525646;
 Sun, 03 Jun 2012 16:52:05 -0700 (PDT)
Received: by 10.180.146.166 with HTTP; Sun, 3 Jun 2012 16:52:05 -0700 (PDT)
In-Reply-To: <7v1ulwxd0o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199114>

On Mon, Jun 4, 2012 at 8:10 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
> Style: please align case/esac and the labels on case arms (see how
> two existing nested case statements in this function are written).

Thanks.

> Didn't we add some workaround for implementations of sed that do not
> match and replace a possibly empty pattern? =C2=A0Am I seeing the sam=
e
> breakage as c5bc42b (Avoid bug in Solaris xpg4/sed as used in
> submodule, 2012-04-09) addressed with this patch?

Have modified accordingly. It may not have mattered *much* in this
case since I think
normalisation during git submodule add would have ensured at least one =
matching
character, but then I don't pretend to understand the nature of the
Solaris issue and
that would in any case, not protect against a manual .gitmodules edit.

I'll re-roll in a day or so after Jens (and/or others) have had a
chance to comment.

jon.

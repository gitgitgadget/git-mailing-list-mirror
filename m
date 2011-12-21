From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Makefile: Change the default compiler from "gcc" to "cc"
Date: Wed, 21 Dec 2011 02:06:52 +0100
Message-ID: <CACBZZX629-hP6kPR1rHQ1E7SoXHSE0a_S8G0Lm0m4=aizk+6hA@mail.gmail.com>
References: <1324424447-7164-1-git-send-email-avarab@gmail.com> <7vr4zyiyih.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 21 02:07:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdAeP-00067j-Ts
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 02:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739Ab1LUBHQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Dec 2011 20:07:16 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53333 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895Ab1LUBHO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Dec 2011 20:07:14 -0500
Received: by wgbdr13 with SMTP id dr13so13386117wgb.1
        for <git@vger.kernel.org>; Tue, 20 Dec 2011 17:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=5s9iA7tyKRqjjxUp3xp03/hewpqDbbvfID/LMHZ4gA8=;
        b=Ki7+9e2b+xclFcanPD7CR5C1gf6hJ572a1PHYax6zGlSOyyvfvCXE3yQXBiI8W8CX3
         r3EQMBeK9Dv6gqYhvgAlDj8c8irQox8evRxnG5KRarp2C0bc02wylTyBasR/cELbA/lH
         gXw7tJAiZU3QJk1dnULOtzLBBU2pUBVSTVXps=
Received: by 10.227.208.133 with SMTP id gc5mr4172674wbb.25.1324429633189;
 Tue, 20 Dec 2011 17:07:13 -0800 (PST)
Received: by 10.223.77.91 with HTTP; Tue, 20 Dec 2011 17:06:52 -0800 (PST)
In-Reply-To: <7vr4zyiyih.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187539>

On Wed, Dec 21, 2011 at 01:01, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> However unlike Linux Git is written in ANSI C and supports a multitu=
de
>> of compilers, including Clang, Sun Studio, xlc etc. On my Linux box
>> "cc" is a symlink to clang, and on a Solaris box I have access to "c=
c"
>> is Sun Studio's CC.
>>
>> Both of these are perfectly capable of compiling Git, and it's
>> annoying to have to specify CC=3Dcc on the command-line when compili=
ng
>> Git when that's the default behavior of most other portable programs=
=2E
>
> Would this affect folks in BSD land negatively?

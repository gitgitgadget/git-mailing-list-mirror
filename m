From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH 1/2] tests: Infrastructure for Git smoke testing
Date: Mon, 2 Aug 2010 18:58:14 -0400
Message-ID: <AANLkTinxvMuU86=OavB4phrCOwUQ1GO2yCP562WuMagC@mail.gmail.com>
References: <1280780684-26344-1-git-send-email-avarab@gmail.com> 
	<1280780684-26344-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 00:58:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og3xx-0002MP-3F
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 00:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754412Ab0HBW6g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 18:58:36 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:57974 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753721Ab0HBW6f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 18:58:35 -0400
Received: by wwf26 with SMTP id 26so231235wwf.1
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 15:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=/yqNT/ISR0uFk0vUl3OqZNgxAT/Ii/U0KRvBE6Fl4uo=;
        b=rsjr6lC5xIRMHhaS1TIwWF9bHppTUdKcqlRT9bwLN5YHhhtHqu4NdTj6yoGuIwQYhy
         qdxD3Uratvi6IVyHrBnudI26jOouxU9hN9hM9DCg+H0OoRqaxJpvZwD7lS6smg040+C4
         tUWBpYLdw9o0zgLNY+0M8GYN2UZtX7WpMMFDc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=KiQQgL/6RVitU6QM1eZSxrBsraW+0eJmJmnQQnwFfgBv9jxGADfU4ijuuzI03Sm9+T
         3rRlyFd74V7k5NQLumG0R0vdYENs8RTpwArUAWSO3/51ZvH7eh9vt52QRL3CWuCQflDB
         B/Iyc7ZSCdYnUZ3NawQWexQv3Wx+/aSzPA9VA=
Received: by 10.216.17.130 with SMTP id j2mr3261016wej.47.1280789914158; Mon, 
	02 Aug 2010 15:58:34 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Mon, 2 Aug 2010 15:58:14 -0700 (PDT)
In-Reply-To: <1280780684-26344-2-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152483>

On Mon, Aug 2, 2010 at 4:24 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> The smoker might want to compile git with non-default flags, include
> bisecting functionality or run the tests under valgrind. Doing that i=
s
> outside the scope of this patch, this just adds a report submission
> mechanism. But including a canonical smoke runner is something we'll
> want to include eventually.

You might want to play with gitbuilder:
http://github.com/apenwarr/gitbuilder

It can bisect automatically and it looks like it could integrate
pretty nicely with this system.  (If you're running a gitbuilder, just
have it submit the smoke test with each build it makes.  gitbuilder
will automatically bisect if 'make test' fails, so eventually you'll
submit smoke tests that *don't* fail.)

Have fun,

Avery

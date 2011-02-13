From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] gitignore: add test-mktemp to ignore list
Date: Sun, 13 Feb 2011 01:10:41 +0100
Message-ID: <AANLkTikdC80g4JBvVyg0zgBe8qOZouUgaqbMj04rkzh0@mail.gmail.com>
References: <1297552877-25651-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Arnout Engelen <arnouten@bzzt.net>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 13 01:11:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoPYq-0002fD-99
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 01:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250Ab1BMALY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Feb 2011 19:11:24 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58190 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152Ab1BMALW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Feb 2011 19:11:22 -0500
Received: by gyb11 with SMTP id 11so1597453gyb.19
        for <git@vger.kernel.org>; Sat, 12 Feb 2011 16:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=jsij7xxm/Bp1iUgrndgD34xr3EIBVrLb917ouD8JxwE=;
        b=nSffP6D+ikEnEpvAky8dI26olG1Z8h8KozWRTfF0n+3SMXZiWn1nA4icVAc+4SeDYF
         6iv1kTfzwHjcKfRucP2NtyQdbOpHICKppkrH3Y9KJJ7PKVZ/k036qlJJJ2R0xPCHeGEx
         j4eZP6gcVcnTg1H7JfF7eVqeqsmeY9nvgrSsY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Jozmz7AKdhuT/Iegw/STjPi8fNNix9bJ+hsWUvz1JJ0/T3JoE0Y6m49CIabVsDYJh0
         TeOZ6SAi6jRRTPYwlU3tb/Xbr/Vy5KLl56j6l1IDwG7uoiC53F8eSkec5tpXKJ+t/j9u
         OIs4/bvnx9FdW9krfuT90aGtT1FOTwJ/BP2ps=
Received: by 10.150.133.10 with SMTP id g10mr2518062ybd.222.1297555881685;
 Sat, 12 Feb 2011 16:11:21 -0800 (PST)
Received: by 10.151.158.10 with HTTP; Sat, 12 Feb 2011 16:10:41 -0800 (PST)
In-Reply-To: <1297552877-25651-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166635>

Heya,

On Sun, Feb 13, 2011 at 00:21, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> Change the .gitignore to ignore test-mktemp which is built from
> test-mktemp.c. Arnout Engelen added this in
> 6cf6bb3e47ac2f667fa0b27a4222e903ff6fb77c but did not add a
> corresponding entry to .gitignore.

I really look forward to git learning not to put it's obj files in the
main tree. These patches are just.. gah! (Thanks for sending it
though, just the fact that it's needed is annoying I mean).

--=20
Cheers,

Sverre Rabbelier

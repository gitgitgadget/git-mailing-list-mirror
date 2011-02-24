From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Why doesn't git commit -a track new files
Date: Thu, 24 Feb 2011 15:06:07 +0100
Message-ID: <AANLkTin50SHDPs56JgZc-2e8CELAimsscUS_BXunQXkm@mail.gmail.com>
References: <20110224112246.3f811ac2@glyph>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Marco <netuse@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 15:06:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psbpl-0002N0-U7
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 15:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755606Ab1BXOGR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Feb 2011 09:06:17 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33120 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755038Ab1BXOGQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Feb 2011 09:06:16 -0500
Received: by fxm17 with SMTP id 17so566875fxm.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 06:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MQYKbv6VzZSaauaiWVIUDzegJotOyqhEBLTjngsINas=;
        b=Bjum3G/tZ3y22ygpkVDUuzsBYeaZH8psHfPcDZGbl+CNAWsp708AgDurKOCn/XECwy
         fasmDIhhJSTJGCA8A3MUvq3FPiALqxfTLFC7mByNnwYt0cpVR6e6NIMh7DPsm8g53jgc
         NsPBqtTUCTSMqcXmqvfBXbGfwdhAGM/w2F0eY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QtyGTzHUO8DjQngTp3DrCXRcfvVYu/93ryOPRZh9TbNgP+nlzTJw2OcVrJeuZJ0OV/
         yFM85uDiduZG2KGBxvcbLiZl3lvJ3MXrTGdFVZ98sK0HcrLRpa6YDH8qjyrydBOn2CNW
         MLipJdD+8c663DR2uPPnNc6BHSrD4FLQxdk68=
Received: by 10.223.112.81 with SMTP id v17mr500548fap.102.1298556367463; Thu,
 24 Feb 2011 06:06:07 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Thu, 24 Feb 2011 06:06:07 -0800 (PST)
In-Reply-To: <20110224112246.3f811ac2@glyph>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167806>

On Thu, Feb 24, 2011 at 11:22, Marco <netuse@lavabit.com> wrote:
> I'm new to git and a bit confused about how some commands work.
>
> git add . =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0-- Adds everything *but* deleted files
> git add -A =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 -- Adds everything
> git commit -a -m "whatever" =C2=A0-- Commits everything *but* new fil=
es
>
> I don't understand why there's not switch (is there?) for commit to c=
ommit new
> and deleted files, like -A for git add? Is the only thing to do this =
sth like
>
> git add -A && git commit -m "Message"

You mean commit things you deleted, and untracked files?

That's a good question actually. It would be useful in some cases.

I've scripted around that a few times, maybe a switch for that would be=
 useful.

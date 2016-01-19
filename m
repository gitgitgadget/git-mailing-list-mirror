From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 3/6] worktree.txt: how to fix up after moving a worktree
Date: Tue, 19 Jan 2016 12:20:43 +0700
Message-ID: <CACsJy8BGEOrc85qZj8tahMWzjWBSjT5mp_V0O_UxZnf6vYUOsQ@mail.gmail.com>
References: <1453116094-4987-1-git-send-email-pclouds@gmail.com>
 <1453116094-4987-4-git-send-email-pclouds@gmail.com> <CAPig+cRydwV4VMcfJ1ab50xumU=Ff4k13tN-R2VuEZhP3n=NjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 06:21:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLOjn-000503-8A
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 06:21:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbcASFVQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jan 2016 00:21:16 -0500
Received: from mail-lb0-f194.google.com ([209.85.217.194]:34697 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbcASFVO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jan 2016 00:21:14 -0500
Received: by mail-lb0-f194.google.com with SMTP id oe3so8727239lbb.1
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 21:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=KsAHSufpwv+DKuOcO4wJGqY8CtHqEk0RJTq76HKjCoU=;
        b=GC1tOTSuTIzUtoaH+gxvJ+1rM99y+kUV+aDS3G7msFXGqVWDIfAUcMIltEq3p4J8m7
         XYOejs29hqrTEjgVqWz4zyEXDvDB3lGolsiHBaCgYqrFX37h/X6Q7Q86EzkJMHAQ+8q4
         MshEAmBQp7EPYKAmzEwacAzlkX+gNKT2/RIca2JLvhLssZOD+Bw7fqVkhk1hd9R4sEBf
         U5gEPKld+rk0dkyH4mSPh9KaPTBJG9exCJZdoyMvhni/5lCzpde75Wyqa+LEFv31rh+g
         l9NNyyHfHvmYSbvUQO51gC92b6NoHuEIWN4Fy6hSg3QZYCs1TrjAd/L4wln4ZebwHHol
         WpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=KsAHSufpwv+DKuOcO4wJGqY8CtHqEk0RJTq76HKjCoU=;
        b=jigI2/RphCo7h+WIdgpe0cRrFAAkNySPVwu5pEHmi8qEVFJ/S/VDkqyME/Ft90+KG7
         nrXMhbKGaf1EyND+ZqZd+sVZVxM95D75eSOrRV1iDXTEjZ4CaGk+9o7rFt/MpvSIMHe/
         YO+jR0QkxvD/8hb+JFNzCSQOrafoyEe/0AFOfyjUiIApUeCPbO4dW16pK6D4KhIpW5RN
         pgA4s5A+WTF985KIQnQELIXPEqhS7sjJph1y09ShWeb0zhbisSEa5HtnQI9jbdjcjgb6
         UGVtpEaIcj+AImdAKZ43V/+A5QQpTbRYt07P2EYrgrsz56vKjo6tr5086P96mL3gHekd
         0kRA==
X-Gm-Message-State: ALoCoQkBrz+uzUdVZ8IfC4M0bgdsXDMEVIDpABfkT9HPrPfnXhen5T6OGpqwSrTfREfIQ8ftIT53Q5+Bbwmk6ouVfHWxA/ndGw==
X-Received: by 10.112.136.103 with SMTP id pz7mr9772004lbb.3.1453180873253;
 Mon, 18 Jan 2016 21:21:13 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Mon, 18 Jan 2016 21:20:43 -0800 (PST)
In-Reply-To: <CAPig+cRydwV4VMcfJ1ab50xumU=Ff4k13tN-R2VuEZhP3n=NjQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284348>

On Tue, Jan 19, 2016 at 1:30 AM, Eric Sunshine <ericsunshine@gmail.com>=
 wrote:
> On Mon, Jan 18, 2016 at 6:21 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>> From: Eric Sunshine <ericsunshine@gmail.com>
>
> Let's use sunshine@sunshineco.com instead.
>
> If you want to keep this patch separate from the previous patch, then

I don't want to make you feel sad. So I'll combine the two patches
into one. Noted the email address for helped-by though.

> perhaps add a commit message here saying something like:
>
>     Following the example of af189b4 (Documentation/git-worktree:
>     split technical info from general description, 2015-07-06), keep =
the
>     high-level overview free of low-level details about updating
>     administrative files when moving a worktree, and instead mention
>     $GIT_DIR/worktrees/<id>/gitdir in the "DETAILS" section.
--=20
Duy

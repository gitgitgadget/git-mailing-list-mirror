From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: how to fetch entire heirarchy of refs from a remote?
Date: Thu, 7 Jan 2016 15:23:42 -0800
Message-ID: <CA+P7+xrZKqchLUwp7tPaydsm5cdcHx38oU9=kPjen-A2Pvkx0g@mail.gmail.com>
References: <CA+P7+xqexsOma5c9NfS5ma333UJV=5i1a4GhnwZuU75eaxRd=Q@mail.gmail.com>
 <xmqqpoxd2d74.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 00:24:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHJuZ-0000jw-QT
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 00:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbcAGXYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 18:24:03 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:34482 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580AbcAGXYC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 18:24:02 -0500
Received: by mail-io0-f179.google.com with SMTP id 1so222771116ion.1
        for <git@vger.kernel.org>; Thu, 07 Jan 2016 15:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mfK9US+iBNV2/yFgcu+GXKP5pBEKnpfteRqBHxlTZxc=;
        b=Id70R8KLaQVZccbvjzFCrC0uHBnZZNEipw48IVXe+o2KtVaApIxHzspKAh1bziG8Si
         SAMAs6Fhy0CeRgTRiSnXXP0RVltytZ9QL5k4sUhpOzJD5BnrGSyYeHsdzYQnp4yJatKa
         SVG1w05znibEZKWZaGfpQyNhs58ETc0WxetnIgJ5os5AcM4sxYcYBRZGzrpVvSyH2bp9
         6k1Kkf8D46gFhWTjju/W6p5PKtiGjsjT6n4qjii0cnWwTc9uxx0B648DwUfLo5Eb0LtV
         D1EW4r8hgkMfaz5VtoCOrbvOt5gP6m0iyQspFu6W3KTjR7B89gAwW2uWjThNcAFU2tLE
         sKHA==
X-Received: by 10.107.170.67 with SMTP id t64mr61041132ioe.71.1452209041285;
 Thu, 07 Jan 2016 15:24:01 -0800 (PST)
Received: by 10.107.63.130 with HTTP; Thu, 7 Jan 2016 15:23:42 -0800 (PST)
In-Reply-To: <xmqqpoxd2d74.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283516>

On Thu, Jan 7, 2016 at 3:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> refs/changes/98/47298/3
>> refs/changes/98/57298/1
>> refs/changes/98/57298/2
>> refs/changes/98/73598/1
>> refs/changes/99/44099/1
>> refs/changes/99/69299/1
>>
>>
>> Is it possible to specify a refspec such that all of these will be
>> fetched? I tried doing
>>
>> +refs/changes/*:refs/changes/*
>>
>> but this doesn't work since the * can only be one portion of a refspec
>
> I am not sure if I follow.  With refs/heads/*:refs/remotes/origin/*
> (e.g. following git://github.com/gitster/git for example), I am
> reasonably sure you would get my refs/heads/jk/notes-dwim-doc and
> other topics you authored without the slash between jk and
> notes-dwim-doc getting in the way.
>
>

That appears to be correct, but.. why doesn't:

git fetch origin +refs/changes/*:refs/changes/*

seem to anything at all?

Ideally this owuld fetch all the remote refs in refs/changes and stick
them into my refs, but it appears to do nothing at all.

Regards,
Jake

From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v3] ls-files: Add eol diagnostics
Date: Mon, 23 Nov 2015 20:45:15 +0100
Message-ID: <CAHGBnuO2RQEhK=veSJ7wHoeo_9ngdSt_vJDjYBQxTma1n=Lt5Q@mail.gmail.com>
References: <56501EFA.7050105@web.de>
	<56517AD5.6040909@gmail.com>
	<5653474E.6050909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 23 20:45:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0x3B-0008EQ-Kt
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 20:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905AbbKWTpR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2015 14:45:17 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36158 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbbKWTpQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Nov 2015 14:45:16 -0500
Received: by igcph11 with SMTP id ph11so58420397igc.1
        for <git@vger.kernel.org>; Mon, 23 Nov 2015 11:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=y7CeGrW/MQ9FjqVQxrLRG0izcfbPbqAu9AC1THu8IdQ=;
        b=VHIxTWmc2PRBqhuyTZJT+kgFXvs7W2gEIKWhi4+Evf9OWJT3JxAAIi6VC6mYcFW0HP
         30HiNC5GCx6odKCSHmjVpd3uoRsVu1zmNc8iGRI9eXKHOhSeUsbIfKwPEOV04f/NVBzG
         QHEolzyeJzTLIbZCMCnazdwPZiq+FM941C+VCzvJyfDzPTGYd2rrb8x7rQAyFjME8Sy5
         oJ1Pn/U/Qn1Ugsr0PPTdca6iTyhv73YXbiE9AFX2gxoxJ+zaVExwuRhoK/GLBZNWyKYJ
         CdttkKWcSShZ29VQXoewO8vRQn7ObW2BXFd9Aa0z+DXBcGUQA3QIW9NyjuN01Mz8F9Hi
         ychg==
X-Received: by 10.50.33.74 with SMTP id p10mr16033532igi.47.1448307915383;
 Mon, 23 Nov 2015 11:45:15 -0800 (PST)
Received: by 10.107.33.65 with HTTP; Mon, 23 Nov 2015 11:45:15 -0800 (PST)
In-Reply-To: <5653474E.6050909@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281596>

On Mon, Nov 23, 2015 at 6:05 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:

> or, as another example:
> git ls-files -o --eol
> i/              w/binary        attr/          zlib.o

I see, somewhat convincing I have to agree.

On another note, how about making the prefix either all just one
letter (i.e. "attr/" becomes "a/"), or all multi-letter abbreviations
(i.e. "i/" becomes "idx/" and "w/" becomes "wt/" or "wtree/" or
"tree/")?

--=20
Sebastian Schuberth

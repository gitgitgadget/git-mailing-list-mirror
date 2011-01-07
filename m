From: =?UTF-8?B?SHJ2b2plIE5pa8WhacSH?= <hniksic@gmail.com>
Subject: Re: 'git add' option to non-interactively stage working tree changes
Date: Fri, 7 Jan 2011 21:03:21 +0100
Message-ID: <AANLkTi=iwOGv3PzrRcVGDwwoTXmJ4CuC11vuYsjn4xxV@mail.gmail.com>
References: <AANLkTimLKZnVn8Lr-E-8M8T5mXA55XabCT5rC+broeFJ@mail.gmail.com>
	<m2aajcbiei.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 07 21:03:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbIX2-0006R6-F5
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 21:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755476Ab1AGUDW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jan 2011 15:03:22 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35446 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624Ab1AGUDW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jan 2011 15:03:22 -0500
Received: by iwn9 with SMTP id 9so17534008iwn.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 12:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=RCk7NTlfUDtiuA5qFv2fccLZEGf/QpZ7J5JWqBLSEAM=;
        b=s+Ma4jIVkmED8xzQuDO+uqpFvRFz2i7TeB9zptxWgOMZem8T+2kwtaHzql4qjCDuVX
         D9LYxiTfxTju7MxtwU6fyI6j159Rwu+ww1UkFVxZJNOpMm64TTS2ZrdrMEVdfxCG7pl1
         7baq53WspDFZ6WU8jFsfIpD/CJmye/cTuN+LE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=Eg30dDXI+tZ3d5bWsrYSJoWP44xE13aRKOli3Jls75gHbSG0tz2+85hHBjKO+ZlyzP
         gV2bcFOaTYWc03e0Gb4CjeMqn6k9Anez+pYtQSyGx6zfFDN1+lbVlXmdqXOdfXAEyZJa
         Z8QHgswBZ7DS6xyOVwulWu0wXJZCOA9GSmnek=
Received: by 10.42.167.193 with SMTP id t1mr1318060icy.106.1294430601454; Fri,
 07 Jan 2011 12:03:21 -0800 (PST)
Received: by 10.42.174.67 with HTTP; Fri, 7 Jan 2011 12:03:21 -0800 (PST)
In-Reply-To: <m2aajcbiei.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164753>

On Fri, Jan 7, 2011 at 8:52 PM, Andreas Schwab <schwab@linux-m68k.org> =
wrote:
> Hrvoje Nik=C5=A1i=C4=87 <hniksic@gmail.com> writes:
>
>> Specifying the root may seem innocuous, but it is inconsistent with
>> "git diff" and "git commit [-a]", which don't care where in the tree
>> you are.
>
> You can always use "$(git rev-parse --show-cdup)." as the root.

Thanks for the tip. I'll note that this is not exactly easy to
discover, though, and it's quite some typing. Since git add -p and git
add -i seem capable of determining the root themselves, maybe there
should be a way to do the same for -u? Or even make it the default?

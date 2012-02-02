From: Albert Yale <surfingalbert@gmail.com>
Subject: Re: [PATCH/RFC v4] grep: Add the option '--exclude'
Date: Thu, 2 Feb 2012 09:41:19 -0500
Message-ID: <CALEc4zF_Z1icpjFRU+AQ+UvaQ9VFK9AJ0ne8F=vRax_gOLkE+g@mail.gmail.com>
References: <1328192753-29162-1-git-send-email-surfingalbert@gmail.com> <CACsJy8CC+cwV+DEWPZVJqEtMq1Rd_RZtUTpMCeSmem5B_7vDMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 15:42:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsxrS-0000Wl-Bk
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 15:42:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088Ab2BBOmB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 09:42:01 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59182 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756341Ab2BBOmA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 09:42:00 -0500
Received: by wgbdt10 with SMTP id dt10so2652011wgb.1
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 06:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=0kMzj104iVDLX4umWbABOKTriH+io6FdtWQuO3QGS/0=;
        b=IcXfWTYxnGPLBzenSPYFOPdhgqf+0SBoO+ATHDZmltM9VAJKka0LArlnTb/RcQc1mQ
         YOTOnEqGGdAyXvizgGPWA240Gf1oi0t/fiTh0ekLJ+yQBWTnv6+VowlPBfCoxLwQv5Rd
         LSf960YFfWUaFuridPV4iRoC+1dXsuwsvupcw=
Received: by 10.180.82.227 with SMTP id l3mr3121605wiy.1.1328193719529; Thu,
 02 Feb 2012 06:41:59 -0800 (PST)
Received: by 10.223.117.212 with HTTP; Thu, 2 Feb 2012 06:41:19 -0800 (PST)
In-Reply-To: <CACsJy8CC+cwV+DEWPZVJqEtMq1Rd_RZtUTpMCeSmem5B_7vDMA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189648>

Thank you for this feedback Nguyen. I'll make the change to
git-grep.txt in my next revision.

Albert

On Thu, Feb 2, 2012 at 9:35 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com=
> wrote:
> On Thu, Feb 2, 2012 at 9:25 PM, Albert Yale <surfingalbert@gmail.com>=
 wrote:
>> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
>> index 6a8b1e3..b45706a 100644
>> --- a/Documentation/git-grep.txt
>> +++ b/Documentation/git-grep.txt
>> @@ -22,6 +22,7 @@ SYNOPSIS
>> =A0 =A0 =A0 =A0 =A0 [--color[=3D<when>] | --no-color]
>> =A0 =A0 =A0 =A0 =A0 [-A <post-context>] [-B <pre-context>] [-C <cont=
ext>]
>> =A0 =A0 =A0 =A0 =A0 [-f <file>] [-e] <pattern>
>> + =A0 =A0 =A0 =A0 =A0[-x <pattern>|--exclude <pattern>]
>> =A0 =A0 =A0 =A0 =A0 [--and|--or|--not|(|)|-e <pattern>...]
>> =A0 =A0 =A0 =A0 =A0 [ [--exclude-standard] [--cached | --no-index | =
--untracked] | <tree>...]
>> =A0 =A0 =A0 =A0 =A0 [--] [<pathspec>...]
>
> I'd like to have a careful look at this but haven't found time/energy
> yet. So just a minor comment. Please use the term <pathspec> instead
> of <pattern>. Exclude pattern has complete different syntax than
> pathspec and --exclude followed by "pattern" may give wrong
> impression.
>
> I'd also avoid reuse "-x" if it's common for exclude patterns, but
> finding a new letter may be difficult. Keep in mind this feature in
> the long run benefits more commands than just git-grep and ideally
> they should all use the same letter for short option name.
> --
> Duy

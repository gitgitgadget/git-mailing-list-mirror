From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Make "terminator behavior" the default with --pretty=format: ?
Date: Tue, 22 Feb 2011 17:41:01 -0500
Message-ID: <AANLkTimLGqnxUygBUY6A=gpCa5gbT-g0L7ikW3Xbf+=_@mail.gmail.com>
References: <AANLkTimFYsG3x0uGX32Ozo6C_shHd4k8jnXNhYmy7Q80@mail.gmail.com>
 <1298393039.2286.14.camel@wpalmer.simply-domain> <AANLkTikGYOdJNGNXR1egPyMBhKpT=bby5fmr8MR9QTXt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?SHJ2b2plIE5pa8WhacSH?= <hniksic@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 23:41:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps0vJ-0002lc-Pd
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 23:41:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361Ab1BVWlc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 17:41:32 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:32878 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299Ab1BVWlb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Feb 2011 17:41:31 -0500
Received: by iwn34 with SMTP id 34so1062770iwn.19
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 14:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=LqaIZBBRmTj4fyyZrQQLNWbufgfVWhlyxmIU2f3FdcM=;
        b=B4FqyCrxHcAaXjzZP+T8udqTVTe6IGCeVj53GtLkjvJAiY7wigqgJjXuGHsPI9HFqZ
         VladVtbtfVVsfIbYTJo/fOT4T8VaBYrXdt7yaWFx/JrhGCn/c479bzTxB46UF/r6ENUm
         okKfd8TEqBI1ppV6pK8RL8nxoyhp6laWSP24s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=H1reUCeSnEl5P6aIQmdQKnXkD7mNy5glETV+Q4PHWpSGMMyNHIdtRia9NgSKcNUm14
         0vKVo74X5vMoaaH1l8unAwIP8NJMgDsSUC1ZmszXTK/YcXXUjVY3VRN3zmQXUAcH4T8Q
         erG3/SNF0cMZMt1eu/9cDmbUjPiiKOWywQCWo=
Received: by 10.42.226.69 with SMTP id iv5mr4283591icb.43.1298414491078; Tue,
 22 Feb 2011 14:41:31 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Tue, 22 Feb 2011 14:41:01 -0800 (PST)
In-Reply-To: <AANLkTikGYOdJNGNXR1egPyMBhKpT=bby5fmr8MR9QTXt@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167585>

On Tue, Feb 22, 2011 at 11:51 AM, Hrvoje Nik=C5=A1i=C4=87 <hniksic@gmai=
l.com> wrote:
> On Tue, Feb 22, 2011 at 5:43 PM, Will Palmer <wmpalmer@gmail.com> wro=
te:
>> On Tue, 2011-02-22 at 16:43 +0100, Hrvoje Nik=C5=A1i=C4=87 wrote:
>>> Is there a reason, other than backward compatibility, for
>>> "--prety=3Dformat:" to have separator rather than terminator semant=
ics?
>>
>> The "default behaviour" is the behaviour which occurs when one /does=
n't/
>> specify something. For example: --pretty=3D"%H %an" uses terminator
>> semantics.
>
> I didn't know that you could simply omit the "format:". Is it
> documented anywhere? The docs say:
>
> =C2=A0 =C2=A0 =C2=A0 --pretty[=3D<format>], --format[=3D<format>]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Pretty-print the contents of the c=
ommit logs in a given
> format, where <format> can be one of oneline, short,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 medium, full, fuller, email, raw a=
nd format:<string>. When
> omitted, the format defaults to medium.

In the tformat section is:

 "In addition, any unrecognized string that has a % in it is
interpreted as if it has tformat: in front of it."

Of course, you need to know to read that far into the man page to find
that sentence, and the earlier summary of --pretty never gives any
hint to do so.

Mind submitting a documentation patch?

j.

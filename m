From: Feanil Patel <feanil@gmail.com>
Subject: Re: Push from an SSH Terminal
Date: Fri, 3 Feb 2012 11:40:42 -0500
Message-ID: <CAG94OYxbOYCjd5qNBh8EF2gyezHWMqX1-R2MYgk8gkFYcrMjuQ@mail.gmail.com>
References: <CAG94OYxX5foffvaFLQv7=wXguGC2TLgccdDFrC+ERzv_gXZ=ug@mail.gmail.com>
 <21607.38.96.167.131.1328286083.squirrel@mail.lo-cal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Neal Groothuis <ngroot@lo-cal.org>
X-From: git-owner@vger.kernel.org Fri Feb 03 17:41:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtMCE-0006Tm-7n
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 17:41:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756865Ab2BCQlF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 11:41:05 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:58494 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754193Ab2BCQlD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 11:41:03 -0500
Received: by wics10 with SMTP id s10so2750916wic.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 08:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=t88r5VSWgFwY+IWJil6n6mCA8XgpEzf/tRjyYhg1Knk=;
        b=QZ/ADcuvmbODRkj+01yAnqGOCuzMhhXc5XeNrZDZBRcO1i1fzQSPpu33qyLWwwF3nw
         G/tvixQezqfqmwfnCObZGI9e5mlxfvDZRRDT3s+NfJ1OgMe6Xcbx32ODtcIcHZSHX6Kn
         aH8tMzxd5P/uHZPzta6SjCYZqcfmOl7SnYqUE=
Received: by 10.180.86.105 with SMTP id o9mr12801173wiz.4.1328287262153; Fri,
 03 Feb 2012 08:41:02 -0800 (PST)
Received: by 10.216.20.201 with HTTP; Fri, 3 Feb 2012 08:40:42 -0800 (PST)
In-Reply-To: <21607.38.96.167.131.1328286083.squirrel@mail.lo-cal.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189783>

On Fri, Feb 3, 2012 at 11:21 AM, Neal Groothuis <ngroot@lo-cal.org> wro=
te:
>> The
>> repository is password protected so if I'm physically at Comp B, I g=
et
>> a gui prompt for my username and password. However Comp A does not
>> have X Forwarding setup to Comp B so I can't get the gui interface f=
or
>> the username and password when I try to do the push. =C2=A0Is there =
an
>> alternative way to provide my credentials when doing a git push that
>> does not require a gui?
>
> What protocol are you using to access the repository on Comp C?
>
> - Neal
>

I'm pulling and pushing over HTTP from Comp C.

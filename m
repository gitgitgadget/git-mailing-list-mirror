From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: A flaw in dep generation with gcc -MMD?
Date: Sat, 19 Nov 2011 11:53:38 +0700
Message-ID: <CACsJy8BLJmDc6jGOW+GzYC9yM2DE6U6ONmfakZvcKNxgVNgCnw@mail.gmail.com>
References: <CACsJy8BZMDyf4MCiKxPJ5Z+XS+C-MC82SpMFyWgiXmb9xCnScw@mail.gmail.com>
 <20111118034142.GA25228@elie.hsd1.il.comcast.net> <CACsJy8A44PFtYrm8NQU+48sVkOe8mjJyO9opO5-TwRtAd-TKsQ@mail.gmail.com>
 <buor516m3w7.fsf@dhlpc061.dev.necel.com> <CACsJy8BuCdT3rRjc5u6Ex5RRgSbL_0SFF0GW-dTGqet4sG2cwg@mail.gmail.com>
 <m21ut5dyei.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Miles Bader <miles@gnu.org>, Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Nov 19 05:54:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRcwS-0004Ur-UJ
	for gcvg-git-2@lo.gmane.org; Sat, 19 Nov 2011 05:54:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105Ab1KSEyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 23:54:12 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50043 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829Ab1KSEyL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 23:54:11 -0500
Received: by bke11 with SMTP id 11so4223012bke.19
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 20:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Erl8db0Fu+qJWF8b+unW+HI1cJ5jxAGnQNDoFqlfD10=;
        b=tCF79LI92/Xdacwi123yC92mL7CCsT5sp3At3RUf7G6eWLkuEWW/wOtPToXgJhbEfo
         uIn86/bWM5JlAY0T2Nbr9wLo/ktj4HfYujXZgmXjBm3NWfKx+LE2S5578rw4svmvQw5l
         wJ5GRUu2M4/Qb72UCiIQuEV+K1uamrjQJ1JDs=
Received: by 10.205.131.3 with SMTP id ho3mr6163563bkc.11.1321678450158; Fri,
 18 Nov 2011 20:54:10 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Fri, 18 Nov 2011 20:53:38 -0800 (PST)
In-Reply-To: <m21ut5dyei.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185687>

On Sat, Nov 19, 2011 at 2:27 AM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> OK it's not gcc problem. I upgraded to 4.5.3 and still had the same
>> problem. I used ccache though. Without ccache, gcc produced correct
>> .o.d files.
>
> I'm also using ccache (version 3.1.3) and get correct dependencies.

I use ccache-2.4. Jonathan pointed out 3.x has been fixed elsewhere in
this thread . I'm going to ask Gentoo to stablize one of 3.x version.
-- 
Duy

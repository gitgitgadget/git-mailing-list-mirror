From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Sun, 25 Nov 2012 12:48:31 +0100
Message-ID: <CAMP44s1cG=5D9DppHmB9CpgkgdEzM72KhQ1Q-kWrrDo8ST+r_g@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
	<CACsJy8BbUjrJtfpEvbcK==Y2gFNsFhFBN93CL36J5uVe=Ca4wQ@mail.gmail.com>
	<20121125051809.GA3670@thyrsus.com>
	<CAMP44s0r1J=aOuEpKQ1+ew9FzODwLX-w5z9rG-WN6AjU0o97yw@mail.gmail.com>
	<20121125095429.GB22279@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Sun Nov 25 12:48:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcahe-0004yS-RS
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 12:48:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146Ab2KYLsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 06:48:33 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:56238 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091Ab2KYLsc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 06:48:32 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so9977162oag.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 03:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LaUXp1aRonYOEt8BDCvQcbsuCjTDSjY9cHt65ChVAdU=;
        b=KJeLIqeduAdn8rRKgfplaJNkYUeH/RiYzlmCVfkhPr9vQ8xQzUjR/8hm2kLjNBTkOj
         BNRBslFWL8gLLCPOuMFYJsQ5vbfnNX4lyX+UvBlnmfs7TpLJ+ieRVps5JIQCk+Ov30f3
         QM3V9wTKs6NoQlS0KwivPMesT56yWbjU3Z8xxfG3psvtuTDiUwZ3NBrixev48kDz/fgt
         1dbgVxX1IIIodHPMHFhce8U+yWbs55yZmg+ldKk1ap198DK2KtA61ctGy1gBO4/vtRB1
         mP5L6HmG0CoS58rxPpy2UGuXXkxDUHGphTB2w/1ib/9uhMOUlZQKbWfxY4HQ8wVMWd+c
         P4Lg==
Received: by 10.182.17.72 with SMTP id m8mr6773055obd.55.1353844111887; Sun,
 25 Nov 2012 03:48:31 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Sun, 25 Nov 2012 03:48:31 -0800 (PST)
In-Reply-To: <20121125095429.GB22279@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210366>

On Sun, Nov 25, 2012 at 10:54 AM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com>:
>> On Sun, Nov 25, 2012 at 6:18 AM, Eric S. Raymond <esr@thyrsus.com> wrote:
>> > Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
>> >> These may apply to other languages as well. Where do we draw a line?
>> >
>> > I'm in favor of the general policy of avoiding scripting languages
>> > other than the top three most widely deployed.  At the moment that
>> > means shell, Python, Perl; on present trends, in a few years Perl
>> > (dropping in popularity) might be passed by Ruby on the way up.
>>
>> Top three according to whom?
>
> According to the LOC counts in git's codebase.

Not according to ohloh:

1) shell 33%
2) tcl 9%
3) perl 9.7%

4) python 1.8%

And this is a non-sequitur; you are proposing to change git policies
based on numbers that are a direct result of git's policies?

https://www.ohloh.net/p/git/analyses/latest/languages_summary

-- 
Felipe Contreras

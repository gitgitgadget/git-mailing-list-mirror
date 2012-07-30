From: Mojca Miklavec <mojca.miklavec.lists@gmail.com>
Subject: Re: inconsistent logs when displayed on screen / piped to a file
Date: Mon, 30 Jul 2012 16:58:28 +0200
Message-ID: <CALBOmsage+Gx9=bkH0rX1SvViSbMUPUWuYoifjgEnsjw+0=osw@mail.gmail.com>
References: <CALBOmsYh5AgpRQe28yUcChqemQ7HFMHahesGj_MPwQXDF-EM=Q@mail.gmail.com>
	<50168E93.2090202@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jul 30 16:58:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvrQY-0001LP-O3
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 16:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754375Ab2G3O6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 10:58:30 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:53190 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754096Ab2G3O63 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 10:58:29 -0400
Received: by qaas11 with SMTP id s11so953996qaa.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 07:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SpsrNEZLkW8D2jLapqwc8dPdhO3ISqdA1rbnlSoRvls=;
        b=EC/Isq4zhgWHVfWxm5TAOIvMlVgfk3BHxzMLfOFycZDLMJxTqpzRY0Ah/0yAnj5gd8
         4LqlxNIuCGAd5d2Pw5ZxFbBYJcYfmFT4lk9W0nZodSnAqJI2C/+rOto9JeQfgBV7YDxC
         igV0q14Peyhv8VmrK7gamCtu0QJfLWxxPXsApGdf8Ffqjs3oeBz2C89+Dce15S7+Wwjs
         RLcJdH+NxFmGk6Q2q87sadC+LxFHwGwcs87qLGeMGIhYr35F95uZ/zSBBe5uumgTtrz+
         X2a1gcfOhj/OutxEF8/obZfSbv36rujOXpjfrTywypCEk7Ggzed1EevAv2dBR8M+Xz5M
         azSw==
Received: by 10.224.203.197 with SMTP id fj5mr23344276qab.98.1343660308706;
 Mon, 30 Jul 2012 07:58:28 -0700 (PDT)
Received: by 10.229.242.131 with HTTP; Mon, 30 Jul 2012 07:58:28 -0700 (PDT)
In-Reply-To: <50168E93.2090202@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202562>

On Mon, Jul 30, 2012 at 3:39 PM, Michael J Gruber wrote:
> Mojca Miklavec venit, vidit, dixit 30.07.2012 14:25:
>>
>> I'm trying to use "git log" to generate ChangeLog for a project
>> recently migrated from CVS.
>>
>> The problem is that
>>     git log --summary --stat --no-merges --date=short --decorate=short
>> behaves differently when the result is displayed on screen and when it
>> is piped to a file.
>
> The only difference that I see is the formatting. ("..." is merely an
> abbreviation for a leading path.)
>
> a) probes your terminal for the number of columns and uses all available
> space.
>
> b) goes to a file and has no connected terminal, thus uses a default
> column number. You can change that number using
>
> COLUMNS=YourNumber git log YourArgs > YourFile

Wow, perfect, thank you very much. Setting COLUMNS=200 (the high
number just in case) solved the problem.

Mojca

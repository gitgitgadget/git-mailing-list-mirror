From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: combined diff does not detect binary files and ignores -diff attribute
Date: Mon, 23 May 2011 11:17:14 -0400
Message-ID: <BANLkTinu3AbTmtswn6DLQKAWdLL=gBvAqA@mail.gmail.com>
References: <BANLkTi=FtkiUjwAa7e3KAC5FF3GNxWzd3Q@mail.gmail.com>
	<4DDA618E.4030604@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon May 23 17:17:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOWsi-0006k5-JY
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 17:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756012Ab1EWPRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 11:17:15 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54654 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755905Ab1EWPRP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 11:17:15 -0400
Received: by pzk9 with SMTP id 9so2603467pzk.19
        for <git@vger.kernel.org>; Mon, 23 May 2011 08:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=MontM2myH+t/x3CV5gnqHh80JHONnQkP9R0J2XnFngg=;
        b=W8U03Eva2N+NTaobnZP0okImJkZF0UbBYhO3GOE0wnOwiA75C5P4J8LXl/bx2Qb2+/
         Zojj1IguvAxg4zVi5DsIqsM6Sf0FFyDheYrJVkPrtV7+x93OdNq00v0j2zzSHc9iQt4J
         HZjptHBjeMCiyQlzzJ5jUjAK3Jhltwd+nXLkw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=tPUKvQSvNAeHpSa0m7VLu77YMbagT3IzX20Vs6Vwj1ddMAt5cTSICS4Pmq+gPT06S0
         bmoKPrm3ZN0LETDzpaWNA2d9z/AeVEQziwDW/cAIBTsVgwOx7KtJIZxCr6Ihem8JbFDZ
         q6n1nME298zDP16hNNR/qX7Tk863iQvJnD7qA=
Received: by 10.68.0.102 with SMTP id 6mr2096993pbd.487.1306163834591; Mon, 23
 May 2011 08:17:14 -0700 (PDT)
Received: by 10.142.13.8 with HTTP; Mon, 23 May 2011 08:17:14 -0700 (PDT)
In-Reply-To: <4DDA618E.4030604@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174247>

On Mon, May 23, 2011 at 9:30 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Jay Soffian venit, vidit, dixit 22.05.2011 22:12:
>> In a merge commit, I added some PNGs (so they were new to both
>> parents). I was surprised when I did a "git show" on the commit and
>> had the binary bits spewed to the terminal.
>>
>> I thought it was just git not detecting the PNG as a binary file, but
>> adding "*.png -diff" to .git/info/attributes made no difference.
>>
>> Just reporting this for now, as I don't have time to investigate.
>>
>> j.
>
> We know, but we somehow got stuck, see:
>
> http://permalink.gmane.org/gmane.comp.version-control.git/171613
>
> I don't have the time to follow up on this currently, it got out of
> proportion.

Drat, seems like the perfect being the enemy of the good there. I
wonder if Junio's patch in that thread isn't good enough for now.

Thanks,

j.

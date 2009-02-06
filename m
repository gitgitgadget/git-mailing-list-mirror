From: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
Subject: Re: [PATCH] gitweb: Better regexp for SHA-1 committag match
Date: Fri, 6 Feb 2009 11:31:39 +0100
Message-ID: <b77c1dce0902060231u358587d5o940eb322fde52a68@mail.gmail.com>
References: <200902022204.46651.toralf.foerster@gmx.de>
	 <200902061012.42943.jnareb@gmail.com>
	 <b77c1dce0902060149j25e76250q76c2368bd3ca5857@mail.gmail.com>
	 <200902061126.18418.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 11:33:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVO1D-0008P3-OR
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 11:33:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394AbZBFKbl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Feb 2009 05:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753311AbZBFKbl
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 05:31:41 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:65131 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921AbZBFKbk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Feb 2009 05:31:40 -0500
Received: by fxm13 with SMTP id 13so1018305fxm.13
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 02:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=At5yAoJM/FrQb6qGkWL+/wBnkdEI90PpJhUs0EWr7a0=;
        b=P6+mgUQrczv7xThNC2HkLAilYrRdTddIOk6jYtR91msDN9LTC5zM6NlBeR40J4gKbs
         fmoKZ92hB3tkdDMpgPXeIqDwvzrVyK6ZPHk5CfACI3PvlKV81GWwWGG/RM0Oo9XoYK+d
         4zOvceKPwjF8Qh9yp68UV031gpH5IjuSop9LY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ABfMrP7x6N3K4Fc85fW2OW0vL15t9QPiWK+NK5BbM7/oaTkj/9IK8F2ZD+rh3yT4ZJ
         KZDZNtzcHgTBoPYIx2VYVLxLHA+LHW0uq/GWHkVvGmPtx7qE3YsjNhjK69rGhPcr3Fjj
         xcYv7Fdqqiwz9QME0poIkAGUnfLf5Q5ispZt4=
Received: by 10.181.141.18 with SMTP id t18mr527228bkn.203.1233916299051; Fri, 
	06 Feb 2009 02:31:39 -0800 (PST)
In-Reply-To: <200902061126.18418.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108674>

2009/2/6 Jakub Narebski <jnareb@gmail.com>:
> Dnia pi=B1tek 6. lutego 2009 10:49, Rafael Garcia-Suarez napisa=B3:
>> 2009/2/6 Jakub Narebski <jnareb@gmail.com>:
>
>> > Make SHA-1 regexp to be turned into hyperlink (the SHA-1 committag=
)
>> > to match word boundary at the beginning and the end.  This way we
>> > reduce number of false matches, for example we now don't match
>> > 0x74a5cd01 which is hex decimal (for example memory address),
>> > but is not SHA-1.
>>
>> Further suggestion: you could also turn the final \b into (\b|\@),
>
> You meant \b -> \b(?!\@), didn't you?  Word boundary _not_ followed
> by '@', and not word boundary _OR_ '@' as you wrote...

Ah right, shame on me.

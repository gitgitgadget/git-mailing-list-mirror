From: Alex K <spaceoutlet@gmail.com>
Subject: Re: date change of commit?
Date: Tue, 27 Oct 2009 10:41:47 +0100
Message-ID: <e4a904790910270241g4a165023o30438c5d000b5de4@mail.gmail.com>
References: <e4a904790910250435p3ff50dcfv5c0c6a86c13d17b@mail.gmail.com>
	 <vpq1vkrqttt.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Oct 27 10:41:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2iYr-0006zI-Vc
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 10:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbZJ0Jln convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Oct 2009 05:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752300AbZJ0Jln
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 05:41:43 -0400
Received: from mail-qy0-f174.google.com ([209.85.221.174]:54223 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbZJ0Jlm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2009 05:41:42 -0400
Received: by qyk4 with SMTP id 4so8180638qyk.33
        for <git@vger.kernel.org>; Tue, 27 Oct 2009 02:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=VZWrUEslAeRQx78Gx/dTHC/2BOQ+IiOc1Kb5MBooElI=;
        b=V2Y+HWinIz2rVGLP1F4HbJHEtSQwCgmXXAG3CYBxqAVj8olOcPZ48uVRt0uZ/gojyG
         9mSl7Y0prBrNJA+2M95swau6K0SrabUnbEyMXY4MBZS+kJ9zk9xQ7jaLMmCxRQF0V1yj
         +LddD/aPFkfhi+ioOR5Ts0i7zP/ynn0B/Qvwc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=lLpexrD1cA0jH+PJG/tBYzY38E0sk44mtgJqpg7vtdVrtnOSxAK+WGkcZleMOjGJLA
         dDrih/+NJwqaY/A+NNis4Dbgb1eC5OPH2sQnVBwZ2FNM5Tg6bXzSfvRoop4+uDh7X3Mf
         DHrlMbH7TcU1ZD5hH0u/oWlKAlBwX77p3Owho=
Received: by 10.229.37.130 with SMTP id x2mr597219qcd.15.1256636507051; Tue, 
	27 Oct 2009 02:41:47 -0700 (PDT)
In-Reply-To: <vpq1vkrqttt.fsf@bauges.imag.fr>
X-Google-Sender-Auth: c016e96521e150f9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131318>

Thank you. And how would you use git-filter-branch to create another
branch with a different time stamp? Is it possible to commit under a
different time stamp than the one provided by your default local time?

2009/10/25 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> Alex K <spaceoutlet@gmail.com> writes:
>
>> Hello,
>>
>> Is it possible to change the date of a commit?
>
> See git-filter-branch. This won't change the date of the existing
> commit (which is impossible in Git), but will create another commit
> where only the date has been changed.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

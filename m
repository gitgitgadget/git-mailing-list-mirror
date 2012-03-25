From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] Fix git-completion.bash for use in zsh
Date: Sun, 25 Mar 2012 20:47:45 +0300
Message-ID: <CAMP44s3_aZ39n6L15ZUNyw8B_6ab+=_Hm8-KPz6WM26GweJCmg@mail.gmail.com>
References: <1332327960-5208-1-git-send-email-dev@randomguy3.me.uk>
	<7vaa393mvc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Merry <dev@randomguy3.me.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 25 19:48:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBrXr-000753-1t
	for gcvg-git-2@plane.gmane.org; Sun, 25 Mar 2012 19:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677Ab2CYRrr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Mar 2012 13:47:47 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59459 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756639Ab2CYRrr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Mar 2012 13:47:47 -0400
Received: by eaaq12 with SMTP id q12so1347908eaa.19
        for <git@vger.kernel.org>; Sun, 25 Mar 2012 10:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=NR0agrd+5v62D2t37JYlBjvgdtLAdx3vKBJePCYWqUw=;
        b=PX8Q2R2f2j7uhOEOLIKzvKMNEIK+U/bdnXbnHGBx+t0oqaWbAgVa5hhtl//r+mbHZk
         JUhTDt/B90BUm3vLsxMSbXExBpieu6ILlCBCETK403Lpkhoe8kCYvBU5ova/FD8ZXCzs
         BCGfDa9JC9JBwyfWQi/xgxqukBrjSCN6mOYgBAQjxL2Z7Tvs8AppFSPu7t5pV8mBHWSz
         Lm0X6P6TJezQfBMmWlReeMIrXOrJZ8BSBh0UeqshJCIfyIr0qiv+BIQOBVAhx4tm2iww
         1wOMCWZF7yxqzYy9Ap24cStqsjrjqwRHeHPvm6LkzFTvNQw6X+Z4XgkyPCMesv21yzeo
         4T4Q==
Received: by 10.213.19.207 with SMTP id c15mr1355636ebb.67.1332697665848; Sun,
 25 Mar 2012 10:47:45 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Sun, 25 Mar 2012 10:47:45 -0700 (PDT)
In-Reply-To: <7vaa393mvc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193877>

On Wed, Mar 21, 2012 at 7:05 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Alex Merry <dev@randomguy3.me.uk> writes:
>
>> zsh treats
>> =C2=A0 local some_var=3D()
>> as a function declaration, rather than an array declaration (althoug=
h
>> its documentation does not suggest that this should be the case).
>>
>> With zsh 4.3.15 on Fedora Core 15, this causes
>> =C2=A0 __git_ps1 " (%s)"
>> to produce the message
>> =C2=A0 local:2: command not found: svn_url_pattern
>> when GIT_PS1_SHOWUPSTREAM=3D"auto", due to the line
>> =C2=A0 local svn_remote=3D() svn_url_pattern count n
>
> Thanks, will queue. =C2=A0Felipe, comments?

Looks good to me. Also, I tested this, and it worked.

--=20
=46elipe Contreras

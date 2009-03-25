From: John Tapsell <johnflux@gmail.com>
Subject: Re: branch ahead in commits but push claims all up to date
Date: Wed, 25 Mar 2009 00:26:59 +0000
Message-ID: <43d8ce650903241726s122cc468q4ea9188e1561832@mail.gmail.com>
References: <7001b7a00903240821v2155d234x6a10c80a3e987acb@mail.gmail.com>
	 <7001b7a00903240822w70a57349xcc66a02cef62dc70@mail.gmail.com>
	 <43d8ce650903240918q2ffdba44w241e0f378a11fd3d@mail.gmail.com>
	 <alpine.LNX.1.00.0903241304090.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Irene Ros <imirene@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 01:29:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmGzv-0003SM-44
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 01:29:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756815AbZCYA1b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 20:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756811AbZCYA13
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 20:27:29 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:61876 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805AbZCYA1C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 20:27:02 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1891670rvb.5
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 17:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dhOiXozegOw1yq1fjxg1lv5UmjOuSC5Np3VWeKSYVLs=;
        b=TFqUIW3aNXuU8ek4HxEJs/Iz8MJvqU26hogt4XLdzAhnHjcaAD8iM/66So+Jj6H4rz
         9P6wpPCY/p9Q0kGeKNwlQ3P03YdjZRzkZkIewz0ck7VqF9XcKtX7JJm22chhXtG6uIBx
         kUgQItkfdR62SARXXMYhyZ7o8fX6C1Tjefg8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZuX1mvCbeE8suMLdUKmhSunlneY+VXGuPs7eTQ2bwbIzI0zvXjqb1hC8hMAHh+bHSK
         jDi0QUiiRmwgPLATfiCC6tcezXF/wj6WhC1Kn0QSLU955JipcK9Sfz0gSfMKw22uHyWd
         oV08PV9IF38aMzUzx8yh3gRIOE7VXifgYdEp4=
Received: by 10.143.45.14 with SMTP id x14mr3637209wfj.43.1237940819308; Tue, 
	24 Mar 2009 17:26:59 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.00.0903241304090.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114523>

2009/3/24 Daniel Barkalow <barkalow@iabervon.org>:
> On Tue, 24 Mar 2009, John Tapsell wrote:
>
>> 2009/3/24 Irene Ros <imirene@gmail.com>:
>> > Hi all,
>> >
>> > I've been using git for some time now and haven't run into this is=
sue
>> > before, perhaps someone else here has:
>> >
>> > I have a branch that is ahead of its origin by a few commits:
>> >
>> > $ git status
>> > # On branch myBranch
>> > # Your branch is ahead of 'origin/myBranch' by 10 commits.
>>
>> Tried running: git fetch =C2=A0 ?
>>
>> For some weird reason =C2=A0"git push origin mybranch" =C2=A0doesn't=
 actually
>> update origin/mybranch. =C2=A0It's more annoying :-)
>
> It should, so long as you're using the native transport and
> origin/mybranch actually tracks mybranch on origin.
>
> "git push" doesn't update it, but the code that implements the native
> transport does update it if it succeeds.
>
> (Actually, I'm not 100% sure that, if you update origin through some =
other
> channel with exactly the commit that you now have in mybranch locally=
, and
> then try the push, it will update the local tracking for that branch;=
 is
> that what you've hit?)

I update via http - maybe that's why?  origin/mybranch is never
updated when I push.  It's not just a once-off quirk.

John

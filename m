From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add Russian translation to gitk
Date: Mon, 27 Apr 2009 11:20:37 +0200
Message-ID: <81b0412b0904270220h598fa451vb3ff30f23dd5eab3@mail.gmail.com>
References: <20090426132452.GB30825@blimp.localdomain>
	 <20090427083953.GB15723@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 13:27:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyN16-0001N1-08
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 11:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbZD0JUj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Apr 2009 05:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752163AbZD0JUj
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 05:20:39 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:61260 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbZD0JUj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Apr 2009 05:20:39 -0400
Received: by bwz7 with SMTP id 7so2155702bwz.37
        for <git@vger.kernel.org>; Mon, 27 Apr 2009 02:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UuBVctgdEFSOCpnDi42Z9HjNK3cR8aB2Rp91fVgL4YI=;
        b=wG1OsA1M+3kWs/4+/Kqc+BUNNE3ahtK7O6Hmo/0LIm1VK01KVcygwDR1bE7Nn0XbMw
         c446TMJvUm2y80Y288cSlYbeB5tFSouDhr0E4MxQJw9KwlJb21WdvkAPa4BFZOk1tJlp
         hqifM0LV80QyHpM5US+fAe+U9kbAYYK7o+1jI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=J9CHOQ/K5X41T4esMAUJ8P5eb98QWeK3B5c27cFCuc6AqugkNS47HnfBQm8Php7r92
         C/AV2lknvd02WH86XWGicWE1IAMx6ZA+3enb6QcphbvJ/JTwGOZbpzNSQ2TNDmNHcFjR
         LXnpvMfkqYlDCBoAzeRjy2EwosRB7xeOZIHzM=
Received: by 10.204.117.142 with SMTP id r14mr5046743bkq.197.1240824037758; 
	Mon, 27 Apr 2009 02:20:37 -0700 (PDT)
In-Reply-To: <20090427083953.GB15723@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117661>

2009/4/27 Dmitry Potapov <dpotapov@gmail.com>:
> On Sun, Apr 26, 2009 at 03:24:52PM +0200, Alex Riesen wrote:
>> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
>> ---
>>
>> As with the git-gui translation, if someone understanding russian se=
es
>> this, could you please take a look and drop me a note if you find
>> something "strange"?
>
> The translation uses a single Russian verb "=D0=9F=D0=B5=D1=80=D0=B5=D0=
=B9=D1=82=D0=B8" in different
> meanings (where the original English phrase had "check out", "move",
> "go to", "focus) and that creates some ambiguity. For example:
>
>> +#: gitk:2347
>> +msgid "Check out this branch"
>> +msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BD=D0=B0 =D1=
=8D=D1=82=D1=83 =D0=B2=D0=B5=D1=82=D0=B2=D1=8C"
>
>> +#: gitk:2644
>> +msgid "<Home>\t\tMove to first commit"
>> +msgstr "<Home>\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA=
 =D0=BF=D0=B5=D1=80=D0=B2=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=
=BE=D1=8F=D0=BD=D0=B8=D1=8E"
>
> How one is supposed to know that when we speak about branch, "=D0=9F=D0=
=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8"
> means "check out" but when about some commit then it is "move"? Only
> because gitk does not allow to check out arbitrary commit _yet_?
>
> IMHO, it is very very confusing.
>
> I think "Check out this branch" should be translated as "=D0=9F=D0=B5=
=D1=80=D0=B5=D0=BA=D0=BB=D1=8E=D1=87=D0=B8=D1=82=D1=8C
> =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B8=D0=B9 =D0=BA=D0=B0=D1=82=D0=B0=D0=
=BB=D0=BE=D0=B3 =D0=BD=D0=B0 =D1=8D=D1=82=D1=83 =D0=B2=D0=B5=D1=82=D0=B2=
=D1=8C" (which literally means: Switch worktree
> to this branch).

That looks too long (in a drop-down menu). How about
"=D0=9F=D0=B5=D1=80=D0=B5=D0=BA=D0=BB=D1=8E=D1=87=D0=B8=D1=82=D1=8C=D1=81=
=D1=8F =D0=BD=D0=B0 =D1=8D=D1=82=D1=83 =D0=B2=D0=B5=D1=82=D0=B2=D1=8C"?=
 IOW, drop the "worktree".
Besides, checkout is a bit of complicated operation to describe
it with that level of detail.

From: netroby <hufeng1987@gmail.com>
Subject: Re: New Feature wanted: Is it possible to let git clone continue last
 break point?
Date: Mon, 31 Oct 2011 17:16:01 +0800
Message-ID: <CAEZo+gfvmeQW2pyGF3tH-Zo1Eac0REZAZmYMpBdY2+gvvHvKPg@mail.gmail.com>
References: <CAEZo+gfKVY-YgMjd=bEYzRV4-460kqDik-yVcQ9Xs=DoCZOMDg@mail.gmail.com>
 <CAEZo+gcj5q2UYnak1+1UG7pPzoeaUr=QLsiCiNXbC_n+JQbKQQ@mail.gmail.com> <20111031090717.GA24978@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mail List <git@vger.kernel.org>,
	Tomas Carnecky <tom@dbservice.com>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 31 10:16:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKnyw-0005LY-8n
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 10:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415Ab1JaJQX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Oct 2011 05:16:23 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35880 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932260Ab1JaJQW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2011 05:16:22 -0400
Received: by iaby12 with SMTP id y12so6978994iab.19
        for <git@vger.kernel.org>; Mon, 31 Oct 2011 02:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=MaHQL7vF3qBtX/EnIsy5NVbYF437+ivxwAgPM0TCRoA=;
        b=mRf45EvKR4B8yHQFEt4iiswaqyYVkfbiYP74KsidM0hpSG5So2/nEPRf0HR8ZcEx/C
         OS2Jo/Lp8YU1bbvRGTR7GgEp8RY3UnYhh35PxdiPNz5yE+JZCqguryVJyJykrDGsvzK3
         g4fb7DEs9Kkqe1THqglc2VxciCbrkWbfmzRg0=
Received: by 10.231.68.130 with SMTP id v2mr4948933ibi.71.1320052582248; Mon,
 31 Oct 2011 02:16:22 -0700 (PDT)
Received: by 10.231.33.139 with HTTP; Mon, 31 Oct 2011 02:16:01 -0700 (PDT)
In-Reply-To: <20111031090717.GA24978@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184499>

the example :

i want to clone the freebsd and linux kernel git repo , to view their
source code.

git://github.com/freebsd/freebsd.git

git://github.com/torvalds/linux.git


they are big project, so they are huge.

thanks for your tips. it will let me have a try .


I am current using  256K Adsl , so it is very not stable when clone in =
progress.

netroby
----------------------------------
http://www.netroby.com



On Mon, Oct 31, 2011 at 17:07, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Hi,
>
> netroby wrote:
>
>> Is it possible to let git clone continue last break point.
>> when we git clone very large project from the web,=C2=A0 we may face=
 some
>> interupt, then we must clone it from zero .
>
> You might find [1] useful as a stopgap (thanks, Tomas!).
>
> Something like Jeff's "priming the well with a server-specified
> bundle" proposal[2] might be a good way to make the same trick
> transparent to clients in the future.
>
> Even with that, later fetches, which grab a pack generated on the fly
> to only contain the objects not already fetched, are generally not
> resumable. =C2=A0Overcoming that would presumably require larger prot=
ocol
> changes, and I don't know of anyone working on it. =C2=A0(My workarou=
nd
> when in a setup where this mattered was to use the old-fashioned
> "dumb" http protocol. =C2=A0It worked fine.)
>
> Hope that helps,
> Jonathan
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/181380
> [2] http://thread.gmane.org/gmane.comp.version-control.git/164569/foc=
us=3D164701
> =C2=A0 =C2=A0http://thread.gmane.org/gmane.comp.version-control.git/1=
68906/focus=3D168912
>

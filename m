From: Chris Packham <judge.packham@gmail.com>
Subject: Re: git fast-export/fast-import *facepalm*
Date: Thu, 27 May 2010 16:03:02 -0700
Message-ID: <AANLkTinB3b8MOxz_8IN05bs2XKb3UyH0oDGNi-Pg2Kdg@mail.gmail.com>
References: <AANLkTinV5mEACphA-nW9URce0Mh9xyu3UjWmfBqL6cLN@mail.gmail.com>
	<20100527210328.GN16470@spearce.org>
	<AANLkTik9QxiAjZHigx0YS5ybZwj6U7l0fK-byUmBirnO@mail.gmail.com>
	<AANLkTinrUWtqx34U3-FFnyAXXYFkQiwrXc6USXJYR2xE@mail.gmail.com>
	<AANLkTin-SCsgxAUCCYILIHaq-sLDfCgTDfY_Kvc5UVSt@mail.gmail.com>
	<AANLkTinJd1hZE6LiJRHWYknS7e2YUHtKApTaKfpPPfKJ@mail.gmail.com>
	<AANLkTimQWW3WLqa0vWmKTYKsbVvnZiStEJI0N9N5tfng@mail.gmail.com>
	<AANLkTiksU3sswdSlQJNqlyd1AK4dvRoftLhrghELq8j5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 28 01:03:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHm6b-0003nY-4J
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 01:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757591Ab0E0XDH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 May 2010 19:03:07 -0400
Received: from mail-qy0-f189.google.com ([209.85.221.189]:45529 "EHLO
	mail-qy0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757548Ab0E0XDE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 May 2010 19:03:04 -0400
Received: by qyk27 with SMTP id 27so973256qyk.23
        for <git@vger.kernel.org>; Thu, 27 May 2010 16:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dqWY9ObdK/fKPh/UNf+XKR/r3IZM5OTtgaHQr3sj3i4=;
        b=G/SVfewNITydRA9Pc6SLx8qStRdfOdH2y0eAoL1MnHGQiE0QG1S+VXfR/eR/kM33LZ
         shs9kTVAXIeVHveCRnqjDybhdbcF58AFr9Wah2dVUciWRWeYpK2d5wdYkNpfnIujK3Fq
         fcwnNb6x+OFV6PUf9FXd4nI7bQFMaz59Ssftc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uES8zh+b0RuieEwWf5EzWbLigmhTa0LVdHrHdhOvZHUZu9U+eGoufi8kifWj3m2J2G
         Rt6rcGb/VbeNU/NewfYkOePkrkyrx9dNTyVg7QxUPKVUfcDfTE28yWLZfANxxbes/yAG
         5+0CZ/MFLYB6duC+rqIIBSFPcXbTdhUe++Vt0=
Received: by 10.224.27.150 with SMTP id i22mr6169879qac.183.1275001382116; 
	Thu, 27 May 2010 16:03:02 -0700 (PDT)
Received: by 10.229.26.74 with HTTP; Thu, 27 May 2010 16:03:02 -0700 (PDT)
In-Reply-To: <AANLkTiksU3sswdSlQJNqlyd1AK4dvRoftLhrghELq8j5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147906>

On Thu, May 27, 2010 at 3:57 PM, Chris Packham <judge.packham@gmail.com=
> wrote:
> On Thu, May 27, 2010 at 3:18 PM, Chris Packham <judge.packham@gmail.c=
om> wrote:
>> On Thu, May 27, 2010 at 3:11 PM, Avery Pennarun <apenwarr@gmail.com>=
 wrote:
>>> On Thu, May 27, 2010 at 6:06 PM, Chris Packham <judge.packham@gmail=
=2Ecom> wrote:
>>>> They're showing up with 'gitk --all'. I've made a backup so I can
>>>> expire the reflog and see if they go away.
>>>
>>> gitk --all shouldn't be showing stuff just because it's in the refl=
og.
>>> =C2=A0Does it have a branchname tag next to it? =C2=A0Have you exit=
/restarted
>>> gitk or are you just using its refresh button? =C2=A0The latter doe=
sn't
>>> work very well across branch deletion.
>>>
>>> Avery
>>>
>>
>> The commits do have tags. I'll try deleting them and gc'ing again.
>>
>
> Deleting the tags seemed to do the trick as far as removing the
> detached commits in gitk.
>
> Now git gc seems to be stuck
>
> ~/linux> git --version
> git version 1.7.1
>
> ~/linux> git gc
> Counting objects: 20058 (went away made a coffee, came back still
> stuck at 20058)
>
> I've attached with gdb and have the following trace if its of any use
> (sorry I don't have debug symbols for libz). I've still got the
> debugger attached if anyone wants me to dump out anything else.
>

Looks like its come back now. I guess there was just one object that
was taking a while to pack.

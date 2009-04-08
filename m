From: Ping Yin <pkufranky@gmail.com>
Subject: Re: Any way to edit the file in index directly?
Date: Wed, 8 Apr 2009 12:17:59 +0800
Message-ID: <46dff0320904072117x712f29dj6854ee7219aede9d@mail.gmail.com>
References: <46dff0320904071803k68fddff4j226760392e0c5bcc@mail.gmail.com>
	 <20090408021041.GB18244@coredump.intra.peff.net>
	 <alpine.DEB.1.00.0904080434240.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git mailing list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 08 06:19:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrPGA-0002Lk-Jl
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 06:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbZDHESC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Apr 2009 00:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbZDHESA
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 00:18:00 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:12858 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbZDHESA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Apr 2009 00:18:00 -0400
Received: by wa-out-1112.google.com with SMTP id j5so2261214wah.21
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 21:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lHgQ0T0SX+rCJZ1jES0qwfZuoSHt3/VyiF8VCXBPsq0=;
        b=p8DoGXE+bFAt/vkrhNZpFCOD+xJqOFMFZPUhHi1XwA0tL5GXgNvPWuJmyjOdDdnm5G
         cpRy9I2CdVf8BOvXZVeAGZ1wB1VmDZEuDTphcfBrq71GbtEpNc2qdPGaANlBB0X739Cq
         CokVtNgneDEL1tQ70IWzqE1Nb+D9yLgCNwA9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C5EGxu1ZdJj3fyuV4bFogcetczwPPbNbCEgVDHKQt3PVBRfhk6jJV6g+I8I0yliRoK
         jRbDjRfZGa0KkbIXGbkEh+tB9fKGpPx1qzOA/uElE8w4PQTx2h6HlYtanhpnA25HLBXg
         TA1y3iUUQYplaXa7WgRAhd74WA5VfO9+nMtUQ=
Received: by 10.114.159.17 with SMTP id h17mr477762wae.197.1239164279307; Tue, 
	07 Apr 2009 21:17:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904080434240.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116029>

On Wed, Apr 8, 2009 at 10:39 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 7 Apr 2009, Jeff King wrote:
>
>> On Wed, Apr 08, 2009 at 09:03:03AM +0800, Ping Yin wrote:
>>
>> > There seems to be a patch for this ( add -e?), but i forget where =
to
>> > find it.
>>
>> "add -p" has an "e"dit option for editing the patch. I don't recall =
any
>> way of directly editing the content.
>
> I posted a patch for "git add --edit", which allows you to edit the _=
diff_
> between the working directory and the index, and which applies the re=
sult
> using apply --recount.
>
> But that has nothing to do with "editing the index directly".
>
> But you might want to use a combination of "hash-object -w --stdin" a=
nd
> "update-index --cacheinfo". =C2=A0IOW something like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sha1=3D$(echo Hello | git hash-object -w -=
-stdin) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git update-index --cacheinfo 0644 $sha1 my=
-file
>
> However, Ping, I _strongly_ suspect an X-Y problem here. =C2=A0IOW I =
think you
> are asking about specifics of a certain _solution_, while we probably=
 have
> a better solution for your particular _problem_.
>

Thanks. I think 'add --edit' is just what i meant by saying 'add -e'.
I'll have it a try.

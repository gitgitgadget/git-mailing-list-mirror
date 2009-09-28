From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Deciding between Git/Mercurial
Date: Mon, 28 Sep 2009 14:01:48 +0300
Message-ID: <94a0d4530909280401q4a451697re8954320682662f2@mail.gmail.com>
References: <h9nlhj$heq$1@ger.gmane.org>
	 <94a0d4530909280136s1ff65004q1733bd4ef78bdc07@mail.gmail.com>
	 <alpine.DEB.1.00.0909281059180.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: newsgroups@catchall.shelter13.net, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 28 13:02:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsDzQ-0006fD-Ki
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 13:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbZI1LBq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Sep 2009 07:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752223AbZI1LBq
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 07:01:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:27871 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbZI1LBp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Sep 2009 07:01:45 -0400
Received: by fg-out-1718.google.com with SMTP id 22so1425894fge.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2009 04:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sjpkbFqk9IC10ut8eKtHlmZQqcJgnR/VwlRYPRRlMUc=;
        b=bbVCwxsUA2eKdvQq8iLsmOsqsh7g9RFxFy978m3mg+L3W84Wqvz/N2PHn/xH2oTk0M
         cXTLWGxEPiPak3Ee8aT0YTl/HfMm6iK/3/vksmljROAl2aNfj0yh2vwLcWI8GHM/bEyb
         EAubFM205mTRIIWzVHsktgMVtblsmeDYI5YfM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hOCa9Z0T3AqkyTEMZB9oDy9tgk86Wtl6AqcoDPc2XPtPcIuL4lsUcfjKuSg9+buWEH
         239qRL/NX8rfnVJCixeT1fPDxMDSAmUlCAT8l9wOUrqdRbg417RELMfNR2SB49EprOHv
         BJfks9RNdOG7JB0lxXKhDDrKluDYuLyVptVnQ=
Received: by 10.86.163.5 with SMTP id l5mr3306524fge.3.1254135708730; Mon, 28 
	Sep 2009 04:01:48 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0909281059180.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129249>

On Mon, Sep 28, 2009 at 1:08 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> I tried to refrain from commenting in this thread, because I do not w=
ant
> to encourage people just to use msysGit and never even attempt to fix
> their own issues.
>
> But I cannot let this go uncommented:
>
> On Mon, 28 Sep 2009, Felipe Contreras wrote:
>
>> IMO the key difference between hg and git is the storage model: hg
>> stores deltas, while git stores snapshots. That would mean that cert=
ain
>> operations are theoretically faster in git (e.g. checkout, diff) whi=
le
>> others faster in hg, although with git's packed format I guess there=
's
>> no operation faster in hg. This means that it doesn't matter how muc=
h
>> hg's python code improves, or if they even re-write parts in C, they
>> will never be able to match git's performance (unless they change th=
e
>> storage model, which essentially means changing the whole design --
>> won't happen).
>
> That is wrong. =C2=A0"git log -- <file>" will always be slightly fast=
er in
> Mercurial, for all the reasons you mentioned.

Ok, thanks for pointing that out. I was thinking that maybe 'git
blame' would also be slightly faster on hg, but I really don't know.
Anyway, I think for most operations git would always be faster, and
more importantly; some essential operations will be faster (checkout,
diff <committish>).

--=20
=46elipe Contreras

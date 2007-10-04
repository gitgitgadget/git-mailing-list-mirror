From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: stgit: editing description of patch
Date: Thu, 4 Oct 2007 09:16:46 -0400
Message-ID: <9e4733910710040616l5358099dj1b65b47cf94cf031@mail.gmail.com>
References: <9e4733910710031626kff59666y77ba9001c0fef907@mail.gmail.com>
	 <9e4733910710031914r766efa88pad9f55f9495d127e@mail.gmail.com>
	 <20071004082624.GA17778@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 15:16:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdQZU-0002SB-QY
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 15:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667AbXJDNQt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2007 09:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753817AbXJDNQt
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 09:16:49 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:16165 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753603AbXJDNQs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Oct 2007 09:16:48 -0400
Received: by an-out-0708.google.com with SMTP id d31so29021and
        for <git@vger.kernel.org>; Thu, 04 Oct 2007 06:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=PhT2VKpssS9gV5vgDDv+fxkk64BumTq5HLMBzmZVSn8=;
        b=fdD2YT+AALmvS8dM3ulTRviiIgqFD5A288TDB3IjbZgEXtgAngcd4zxenpVryadKWmKBtwVVvVSiSs9wZPibEzR9KIc2UQDTxR20po+3GuWUKt5RwfKcn9jj8sR1aSQHmKuVMbzr73/n5GpzUUVFcvr7LAi9z+yreJ+rMsGo38M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wbdm/bSa0XGCj4gFNxv+9LLgDFeEpetzcko1YTTIIk7VmmP5YoWNwudeStJuHHF1MJjg99/Ejb25xLjHjsB0V0ANgLCaEtIt1zlR5oC1Z/QiDPf9R0taagrbJ/3KHykpSKvohfn0unxkTAYnnGoDMRRtegyWIj/izXkpGO3aquE=
Received: by 10.142.47.6 with SMTP id u6mr680887wfu.1191503806547;
        Thu, 04 Oct 2007 06:16:46 -0700 (PDT)
Received: by 10.141.70.4 with HTTP; Thu, 4 Oct 2007 06:16:46 -0700 (PDT)
In-Reply-To: <20071004082624.GA17778@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59951>

On 10/4/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> > > On my box all of the patches have names -- stg series shows them.
> > > But when I emailed them half of the patch didn't have the right
> > > subjects.
> >
> > this is controled in the template files
>
> Anything here you'd characterize as a bug?

No, not after I have learned more about stg. The missing subjects were
from other patches I had imported from emails. They has all of the
email headers on them. Once I edited those out the subjects appeared
ok. 'stg edit' should help with this, it was non-obvious to use 'stg
refresh' to edit the patch descriptions.

Why is mailing a patch series so slow?

There also seems to be a disconnect when mailing patches. Locally the
patches have a name, when you email them it uses the short description
for the name by default instead of the local name. This may cause
confusion because the emailed name does not default to the local name.
A parallel issue happens on import.

Now that I am aware of the naming scheme I can deal with it, but this
may be a problem for new users. It might be better to force the short
description and local name to always match.

--=20
Jon Smirl
jonsmirl@gmail.com

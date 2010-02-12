From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: GSoC 2010
Date: Fri, 12 Feb 2010 17:34:52 +0800
Message-ID: <be6fef0d1002120134p7dda53e4h7c970bd852e6ce99@mail.gmail.com>
References: <fabb9a1e1002101223o6a00f7eavb84567c1119c8ebc@mail.gmail.com>
	 <20100212080620.GA31719@dcvr.yhbt.net>
	 <alpine.DEB.1.00.1002121000290.20986@pacific.mpi-cbg.de>
	 <fabb9a1e1002120103j3f37d417ka5b7b7ca3ae8edd@mail.gmail.com>
	 <20100212091635.GA22942@glandium.org>
	 <alpine.DEB.1.00.1002121034320.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mike Hommey <mh@glandium.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 12 10:35:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfrvP-0005kZ-Ec
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 10:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676Ab0BLJez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 04:34:55 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:61629 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431Ab0BLJex (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 04:34:53 -0500
Received: by iwn39 with SMTP id 39so449083iwn.1
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 01:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Wdh/J7EfGXOs8KF1Uey9BcZZfLtt0KRf5SitBknpmOk=;
        b=noAMKZc9AFfxU7sq84uEOPohct3Cv8n2nDt0GBQJCMreCE7+Onn+Kxo9kePy0ZOX88
         miPdm1VZ6aK7XDD204Pfo+ppIBVxxxHVcQp/T75Y+bxDKZaaQhAcW6ZziqkVDA6drsra
         vdCsM/M+AVAhZt39ZDNl+NaPas0SCOnLZCiWM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=D3fArEVdOYoZDnZyxgxr/DyXjy4YCWL/T5k4yU7n/+zi5B4IqIXWRlhNrFySLQxPg9
         ECETF2Jj7AUUgKeE+5AMRrbe/VgkISyouu8PM+vi3Nyju6OtPiw/CSOEdpRcZQOWQvJr
         Qm3/ONlWEV/aXnGAU2dpGwmn2YQnJPRgdguxc=
Received: by 10.231.157.83 with SMTP id a19mr1808656ibx.41.1265967292139; Fri, 
	12 Feb 2010 01:34:52 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1002121034320.20986@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139672>

Hi,

On Fri, Feb 12, 2010 at 5:35 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 12 Feb 2010, Mike Hommey wrote:
>
>> On Fri, Feb 12, 2010 at 10:03:43AM +0100, Sverre Rabbelier wrote:
>>
>> > On Fri, Feb 12, 2010 at 10:02, Johannes Schindelin
>> > <Johannes.Schindelin@gmx.de> wrote:
>> > > Would it not make sense to implement git-remote-svn as a C program?
>> > > That should help matters especially on Windows, where git-svn is
>> > > very slow due to its using MSys (which is a stripped-down Cygwin, as
>> > > you know, jumping through hoops to bring some POSIX-iness to
>> > > Windows).
>> >
>> > It would very much be sense to do so, perhaps we should update the
>> > wiki to say that implementing it in C is strongly preferred?
>>
>> It is already mentioned on the wiki that this would probably be a
>> problem, license-wise. (the svn library is Apache license, which is
>> incompatible with GPLv2)
>
> So git-remote-svn would have to be under an Apache-compatible license, so
> what? It is not as if git-remote-svn was a derivative work of Git, just
> because it abides by a very simple command-line interface that happens to
> be defined in Git, but would work anywhere else, too.

hmm, what about distribution? Will we be able to distribute this
remote helper with the rest of Git's GPL-ed code?

As a side note, if I'm remember correctly, there used to be a
implementation of SHA-1 hashing algorithm from Mozilla  - was that
under MPL? If so, how did we deal with that? (Wikipedia says MPL is
incompatible with GPL, too.)

-- 
Cheers,
Ray Chuan

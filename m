From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: GSoC 2010
Date: Fri, 12 Feb 2010 10:32:44 +0100
Message-ID: <fabb9a1e1002120132q157d2d4dqd7c81d766bd933f6@mail.gmail.com>
References: <fabb9a1e1002101223o6a00f7eavb84567c1119c8ebc@mail.gmail.com> 
	<20100212080620.GA31719@dcvr.yhbt.net> <alpine.DEB.1.00.1002121000290.20986@pacific.mpi-cbg.de> 
	<fabb9a1e1002120103j3f37d417ka5b7b7ca3ae8edd@mail.gmail.com> 
	<20100212091635.GA22942@glandium.org> <alpine.DEB.1.00.1002121034320.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mike Hommey <mh@glandium.org>, Eric Wong <normalperson@yhbt.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 12 10:33:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfrth-0004eU-R0
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 10:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641Ab0BLJdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 04:33:09 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:37400 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab0BLJdH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 04:33:07 -0500
Received: by qyk9 with SMTP id 9so599931qyk.22
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 01:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=953dp6AZZXwJpNMV3kUaRo+ul4xexJQzFvldyRRaTt0=;
        b=mDwDoVWyYNXj8T8d1Epp9log4chAvf1mNZt+kLGBtKjqQPCxsXkEqPmzozM4lf+EfS
         jifTKqyPWtohtGl+Oqjc7bZLTgdRxfx9lXLekAPIcvGYX571QbHiqvCz/Yt1ruMxa7Vd
         72Ory1ndfNIg2IxMmcVHKCB3RaKq8y4J+7TNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Gbbl0jm4EhON6OjXOdkX4sA9bSESYfrMyoU5Q+3mylWkPdtmkbExYu78FwJT+Y0S6h
         smKV8O7BwzSodqaotz5UPz9FaHBoSsG1hUXA4oouLO1vM6l+nA1syGhDQDnAdzh2s9Ci
         XawODbhu5wAlucTNBpkZKv0eymVrxKpTfVwoc=
Received: by 10.224.83.133 with SMTP id f5mr558610qal.223.1265967184106; Fri, 
	12 Feb 2010 01:33:04 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1002121034320.20986@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139671>

Heya,

On Fri, Feb 12, 2010 at 10:35, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Fri, 12 Feb 2010, Mike Hommey wrote:
>> It is already mentioned on the wiki that this would probably be a
>> problem, license-wise. (the svn library is Apache license, which is
>> incompatible with GPLv2)

Yeah, guess who put that there ;).

> So git-remote-svn would have to be under an Apache-compatible license, so
> what? It is not as if git-remote-svn was a derivative work of Git, just
> because it abides by a very simple command-line interface that happens to
> be defined in Git, but would work anywhere else, too.

Excellent point, I think we could safely argue that if we only expose
'import' and 'export' (so adhere to the fast-import/fast-export format
that is already widely used), that it is indeed not a derative work.
Also, becaus of how we set up the remote helpers (as drop in
binaries), we shouldn't have to worry too much about distributing?

-- 
Cheers,

Sverre Rabbelier

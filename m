From: "Mark Levedahl" <mlevedahl@gmail.com>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Wed, 15 Aug 2007 08:42:42 -0400
Message-ID: <30e4a070708150542m3f3f5c62l5e4bf5b3ff098b52@mail.gmail.com>
References: <76795DDC-29A5-4C7E-B56E-A6316A183C75@zib.de>
	 <2383328F-300E-459C-A299-90242DA230F7@zib.de>
	 <e7bda7770708101531n782118e9qb9c6de4e934940ea@mail.gmail.com>
	 <EF7DFA5A-9C3A-4D0B-9533-D1D60AE4A44C@zib.de>
	 <e7bda7770708141704m587dfdbdqfbab51b8ac6fcff@mail.gmail.com>
	 <30FE2B1C-B651-4F1D-B5D9-CD3C3261F531@zib.de>
	 <85fy2l1i1g.fsf@lola.goethe.zz>
	 <ABA1D7D2-92A6-4E8C-AC36-93912621E3D4@zib.de>
	 <86k5rx474o.fsf@lola.quinscape.zz>
	 <20070815073811.GL27913@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Kastrup" <dak@gnu.org>,
	"Steffen Prohaska" <prohaska@zib.de>,
	"Torgil Svensson" <torgil.svensson@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 15 14:42:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILID3-0004iH-5E
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 14:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbXHOMmq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 08:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754550AbXHOMmp
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 08:42:45 -0400
Received: from nz-out-0506.google.com ([64.233.162.230]:46826 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbXHOMmo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 08:42:44 -0400
Received: by nz-out-0506.google.com with SMTP id s18so758584nze
        for <git@vger.kernel.org>; Wed, 15 Aug 2007 05:42:43 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dQTVTw2V5gebZnFQkcQoZHg+/4eDXi7qMttuG8S0S3lliXHOe/N2qZkxT9N+z92lG4CVncD8P9oRacRDOyDhCm8RyZFP6NYUw8scFhRR6a4LD14a0pnzMgKzv5UI4nPeI9hvtS2vM5owGPL8eAjWiBCQJFeYup0pglCPcaqZVIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G4MJ97P9iI9RUDe9dv5jWZ6wTlw3/plJf0IxIu0eViKQmrlZPiROQ9BIt+Ynd8bmp94KnrGEeYKPIqerKeLuFQC0lNQwp6T89fYUN7W4+psQIcDXeEY6I61p4Gb0i40SL1+QVF7DvNvg9LmNNB8bYxFHFXekhYqYYEWQNtDhH9U=
Received: by 10.142.107.1 with SMTP id f1mr20346wfc.1187181763256;
        Wed, 15 Aug 2007 05:42:43 -0700 (PDT)
Received: by 10.143.156.1 with HTTP; Wed, 15 Aug 2007 05:42:42 -0700 (PDT)
In-Reply-To: <20070815073811.GL27913@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55897>

On 8/15/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> David Kastrup <dak@gnu.org> wrote:
> >     Load a Hive, Query, Save, Restore, and Unload a Hive. To install
> >     the Support Tools:
> >
> >     1.
> >
> >
> >     Insert the Windows 2000 CD-ROM into your CD-ROM drive.
>
> Indeed, that step right there will stop many users cold in their
> tracks.

maybe something like ...

case "$(uname -o) in

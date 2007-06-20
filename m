From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Debugging strange "corrupt pack" errors on SuSE 9
Date: Wed, 20 Jun 2007 16:20:09 +1200
Message-ID: <46a038f90706192120q6c64a854re589f27b3bdbc0d5@mail.gmail.com>
References: <46a038f90706191936m121a94e4x1e59dff4fe217988@mail.gmail.com>
	 <alpine.LFD.0.99.0706192313290.20596@xanadu.home>
	 <46a038f90706192117x53420c04o27f05e8fa6c338a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	jonathan.newman@catalyst.net.nz
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jun 20 06:20:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0rfx-0001T3-3I
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 06:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755434AbXFTEUL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 00:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755564AbXFTEUL
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 00:20:11 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:24519 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754307AbXFTEUK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 00:20:10 -0400
Received: by wx-out-0506.google.com with SMTP id t15so59530wxc
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 21:20:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K9v0+AbetOouaCnMxWL8hHlCUpamAzccQYZMIb6kDiCqdKYqe7RT8Pyg+RbjmikzIhbFea/3P3VNtA8Z21XpStlE4ELModF3u74B5dca25cyJaSGdIAv2d+0Aep4hQSKxm8BpU+CwCHE0gkLj7c7ErOSyDQJ17ngf3K/iKHwkPY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W3bEEqw78rf39+2RP+TdCJTNmPBwvxU0YmR/cbAkW0z6L/1J26Yzm3HhWWC1pa0HwivI2GBtZAyOsPW+JytJTydyAsweS/hDNaesbsnV8CZwOsFTJnGw+JEkszeKLCWvEksX03730+n0YRPHYkbUOr4+P5Zul03xhygBrZ+d814=
Received: by 10.90.101.19 with SMTP id y19mr35153agb.1182313209642;
        Tue, 19 Jun 2007 21:20:09 -0700 (PDT)
Received: by 10.90.52.9 with HTTP; Tue, 19 Jun 2007 21:20:09 -0700 (PDT)
In-Reply-To: <46a038f90706192117x53420c04o27f05e8fa6c338a5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50529>

On 6/20/07, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> > But because you push to a local repository (a mounted USB stick is
> > considered a local repo) then you don't get to negociate the pack
> > capabilities of the final destination, and therefore more "bad" delta
> > objects might sneak in again.
>
> How does that work? So any repo we push _from_ can override (and muck
> up) the destination repo, ignoring its config?
>
> That sounds a bit broken - the pack being built for a local
> destination should respect the settings of the destination repo.

OTOH, as a workaround, it _should_ work if I force a repack on the
usb-repo after each push, right? It'll wear the USB disk out, waste
human+cpu time and kill some kittens along the way, but it'll do for
the time being.

cheers,


m

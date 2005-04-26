From: Diego Calleja <diegocg@gmail.com>
Subject: Re: Merge with git-pasky II.
Date: Tue, 26 Apr 2005 23:26:24 +0200
Message-ID: <20050426232624.4a68a720.diegocg@gmail.com>
References: <Pine.LNX.4.58.0504261256150.18901@ppc970.osdl.org>
	<Pine.LNX.4.44.0504261301520.4678-100000@wax.eds.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 23:23:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQXUT-0002WT-ML
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 23:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVDZV0Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 26 Apr 2005 17:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVDZV0Y
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 17:26:24 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:46968 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261797AbVDZV0W convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 17:26:22 -0400
Received: by wproxy.gmail.com with SMTP id 49so134498wri
        for <git@vger.kernel.org>; Tue, 26 Apr 2005 14:26:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=uKeIqS/RQvwJh2AmGdgSMYzDwfgziraxBUqBskLsFSkVqvL+2dgviTdx3JiSVx68/7ACohBscoMEFK5g8gI3AXZwfsqkjzMWiJqu1tWBwQqLIo3uVQwF8z9nIA+M+3fUWB1y0CN3VHKDy/mxzhjKm6qYp1DZoXGbUPtdSk7n8jo=
Received: by 10.54.59.21 with SMTP id h21mr200824wra;
        Tue, 26 Apr 2005 14:26:22 -0700 (PDT)
Received: from estel ([80.103.13.203])
        by mx.gmail.com with ESMTP id 67sm652827wra.2005.04.26.14.26.19;
        Tue, 26 Apr 2005 14:26:22 -0700 (PDT)
To: Bram Cohen <bram@bitconjurer.org>
In-Reply-To: <Pine.LNX.4.44.0504261301520.4678-100000@wax.eds.org>
X-Mailer: Sylpheed version 1.9.9+svn (GTK+ 2.6.4; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

El Tue, 26 Apr 2005 13:31:31 -0700 (PDT),
Bram Cohen <bram@bitconjurer.org> escribi=F3:

> Even if we pretend that these are comparable features, that's far fro=
m
> clearly true. Function moves within a file occur more frequently, but=
 a
> file rename moves *all* the functions within that file.

Renaming or moving files is _so_ rare and unusual that even not impleme=
nting
it (like CVS) is hardly a big issue. Even in the linux kernel people mo=
ved subsystems
around - OSS went from drivers/sound to /sound/oss in 2.6, and a USB su=
bdirectory
moved too, I think.

The patch got bigger. People wasted 30 seconds more of their life becau=
se the .gz
file was bigger - who cares? If it's something it's going to happen eve=
ry 5 years,
I'd rather move them like CVS does rather than wasting a single second
implementing file renaming/moving...

If something so uncommon like file renaming has been implemented, I don=
't see
why people shouldn't implement something really useful like the thing l=
inus
proposes, in fact it doesn't looks like a bad idea at all (and you'd ge=
t
file renaming for free, too). Perhaps it would be hard to implement and=
 get
right, but at least it would be _useful_.

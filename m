From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 09/13] Honour the refspec when updating refs after 
	import
Date: Fri, 6 Nov 2009 01:28:30 +0100
Message-ID: <fabb9a1e0911051628v2ba15be2s9c3fb06879607cc0@mail.gmail.com>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com> 
	<1257364098-1685-10-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.0911041601170.14365@iabervon.org> 
	<fabb9a1e0911041321i1ccec898r53ddafb9405c6331@mail.gmail.com> 
	<alpine.LNX.2.00.0911041624401.14365@iabervon.org> <fabb9a1e0911041745x577f7e4rc678da4d7d559193@mail.gmail.com> 
	<alpine.LNX.2.00.0911050016360.14365@iabervon.org> <alpine.LNX.2.00.0911050145010.14365@iabervon.org> 
	<fabb9a1e0911051551r2e13cfb9me0e668adb962f6bd@mail.gmail.com> 
	<alpine.LNX.2.00.0911051917100.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Nov 06 01:30:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6ChF-0000GD-B6
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 01:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759070AbZKFA2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 19:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759060AbZKFA2q
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 19:28:46 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:47891 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755893AbZKFA2p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 19:28:45 -0500
Received: by ewy3 with SMTP id 3so603749ewy.37
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 16:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=FwhqyL9nbFbNSLvdXS3l1/PBuVkfVvdLhfcLijnYh5w=;
        b=W+QgfekEihB7+e3plnHwIDpamCh1LHZf5ZED0BCXW8aPv2Od2Tdjmw0vztkJ8WHkRt
         zf1LqY74JxCIjBGTRninJRrg0/IcTeMkzXTsErkRrMSyhdCTXU2QaxR48RmRb+hrtje2
         MPJGRZDx04kDTAGbzY7R3gd4Fwrr0Dm+Rajnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Tp/cMSnbPhV/NIUmsaK6q9MSuXzOoGkg/H6UyYXZciB/Jz/94hsHdEsWmWEAavERGh
         nXGUYUASRrYR74QhVMkX3JVeY92AkRq9afBNslgQjCU/A/wBEwZQYGJghUaRWOHX4zAC
         lMWS3bMdVaY9emJL1B4UyK7XKfV3ngM45/PMo=
Received: by 10.216.90.65 with SMTP id d43mr1161956wef.41.1257467330201; Thu, 
	05 Nov 2009 16:28:50 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.0911051917100.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132259>

Heya,

On Fri, Nov 6, 2009 at 01:19, Daniel Barkalow <barkalow@iabervon.org> wrote:
> I didn't understand the version of my patch that contains your changes,
> and I didn't know what was in it.

Either way, I managed to apply your patch, will send a new version of
the series tomorrow.

> I don't know why Junio squashed your
> changes into my patch, particularly when I disagreed with those changes.

Junio didn't squash anything, it's just that pu still contains v4 of
the series, in which I had squashed my changes in.

-- 
Cheers,

Sverre Rabbelier

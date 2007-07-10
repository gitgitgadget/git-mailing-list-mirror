From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [WIP] Get rid of msys in favor of busybox port for windows
Date: Tue, 10 Jul 2007 12:08:33 -0400
Message-ID: <fcaeb9bf0707100908o4be761b9t920cdc65a72d9aee@mail.gmail.com>
References: <fcaeb9bf0707100832j3c2ff076gab5c9bd4f9d3f4a0@mail.gmail.com>
	 <Pine.LNX.4.64.0707101638521.4047@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 10 18:08:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8IGW-0004Zw-AF
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 18:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755496AbXGJQIf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 12:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760079AbXGJQIf
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 12:08:35 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:42729 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759441AbXGJQIe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 12:08:34 -0400
Received: by an-out-0708.google.com with SMTP id d31so272335and
        for <git@vger.kernel.org>; Tue, 10 Jul 2007 09:08:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CRT3ejhI8XydNn2vbVsx3RViE6U9R6aBxnlYhgb4Tj1GyuABMtAAFvDLsBZk2mkYvfmQJjM6aH6MEZuXCg2zVUeFppj1YLV/ghQCPvEKPAXle93DzBoXVEmrvW+d5R+MRItCHaa6JZg37zAEYBUFG1bUX7QrTNjbWuE0PXpnLDc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k5sSuUf3p1IpUxL6BeHwzUFX1y1tA0vVPmnZvRQS9fJ3agpBf4/SYRLVfZL8uNZXahmnnYi4s18pM+K/sIiVhpBbh+cxGmr7AoqB8OuSupRen3thwyDBPbEHmXXLCAp0Kk6JqaSHg7MBDB/e3ioJ7Bm71dLq9q8C1dSOkQPqAmQ=
Received: by 10.100.141.13 with SMTP id o13mr2292010and.1184083713577;
        Tue, 10 Jul 2007 09:08:33 -0700 (PDT)
Received: by 10.100.198.17 with HTTP; Tue, 10 Jul 2007 09:08:33 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707101638521.4047@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52088>

On 7/10/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 10 Jul 2007, Nguyen Thai Ngoc Duy wrote:
>
> > I'm integrating some code from busybox to mingw tree so that mingw port
> > can work without msys. Posix utilities such as sed, awk, head, tail...
> > seem to work well. The main obstacle is ash, which is no where near
> > usable state (fork issues as always). Busybox ash is about 13000 lines
> > of code, not too big.
> >
> > Anyone interested in?
>
> Definitely.
>
> Last time I wanted to assess how much work it is to compile that on MinGW,
> though, it seemed to be too much to be tractable.

The exact answer is "I don't know" :-) I cross compile all the time
however it should build fine on MinGW as it now uses git Makefile.
I'll push the patch into mob soon.
-- 
Duy

From: Phil Hord <phil.hord@gmail.com>
Subject: Re: git-gui Ctrl-U (unstage) broken
Date: Mon, 30 Jan 2012 15:50:25 -0500
Message-ID: <CABURp0qVOJXbF=GP=e62P=Lbe7+93jA_axhxNJfp85kJYo6t7A@mail.gmail.com>
References: <CAA5Ydx-mi7i7mWDYO=Cbw4g1b7LR0hw4Tcqe9gMtBoCkDRuvYA@mail.gmail.com>
 <877h0at7ua.fsf@fox.patthoyts.tk> <20120130192223.GA21444@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Victor Engmark <victor.engmark@gmail.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Jan 30 21:50:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RryBf-0006oN-Oh
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 21:50:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808Ab2A3Uur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 15:50:47 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:57076 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640Ab2A3Uuq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 15:50:46 -0500
Received: by wics10 with SMTP id s10so3830186wic.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 12:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FPv+RXQ9S7qW8+osgbn35sZDc9C/2YBEDfYF5eIf4QQ=;
        b=CbwU/IhBnPhW7I8OVaVWKGAqNiajcpyYyQ2a2ySs4GLjF+bj5QhL8M0mhUL5dM94u0
         +5y3l1hZ1T29i9hUZ6vxzKujDBX25seB7K0j/Vsa8cCC8TcMglPn3A2v3dMmTZ+AyAId
         ajF4NuSKmRJPjlW3rmUKALCkoOLAIMlTX3pRI=
Received: by 10.180.104.4 with SMTP id ga4mr30722856wib.17.1327956645240; Mon,
 30 Jan 2012 12:50:45 -0800 (PST)
Received: by 10.216.155.212 with HTTP; Mon, 30 Jan 2012 12:50:25 -0800 (PST)
In-Reply-To: <20120130192223.GA21444@ecki>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189422>

On Mon, Jan 30, 2012 at 2:22 PM, Clemens Buchacher <drizzd@aon.at> wrote:
> I could reproduce this issue on my Fedora 14 box at dayjob with the
> git-gui package that corresponds to git version 1.7.4.4 (git-gui version
> 0.13.0.8.g8f855 according to git.git).
>
> But I cannot reproduce with the current git version or even with git
> 1.7.1 and git-gui 0.12.0.64.g89d6 on my Arch Linux box, where I have
> Tcl/Tk version 8.5.11.
>
> I have to check which Tcl/Tk version the F14 box uses. But the bug does
> not seem to depend on the git gui version. Have you tried upgrading
> Tcl/Tk?

I haven't tried anything to fix this, but I'll add some data points.

* Ctrl-T / Ctrl-U Ctrl-J have never worked reliably for me on Ubuntu/Gnome.

* Ctrl-A does not work for "Remote > Add..."  since it performs "Edit
> Select All" instead

All the other combos I tried work ok.

Maybe the last one is a clue, though I can't think what Ctrl-T might
be assigned to, and it's not listed in the menus as being assigned to
anything else.  But maybe the works-ness of it is related to the
window focus.

Phil

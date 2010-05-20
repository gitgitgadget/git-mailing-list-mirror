From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] WIP: begin to translate git with gettext
Date: Thu, 20 May 2010 16:02:46 +0000
Message-ID: <AANLkTinksuRQ-XJrusR9PXeP0HowaK-6ZJh8uwxMFUg2@mail.gmail.com>
References: <20100517160503.GA12717@unpythonic.net>
	 <4BF24467.7000204@drmicha.warpmail.net>
	 <20100518164002.GC20842@unpythonic.net>
	 <AANLkTikbl3jDXzdBhd0w6jSXTD-q5kai6Sy6CKLVmRdD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>, Jan Hudec <bulb@ucw.cz>,
	Thomas Rast <trast@student.ethz.ch>,
	Marc Weber <marco-oweber@gmx.de>
To: Jeff Epler <jepler@unpythonic.net>
X-From: git-owner@vger.kernel.org Thu May 20 18:02:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF8Cz-0006QG-Bc
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 18:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326Ab0ETQCs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 May 2010 12:02:48 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56770 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594Ab0ETQCr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 May 2010 12:02:47 -0400
Received: by iwn6 with SMTP id 6so4453592iwn.19
        for <git@vger.kernel.org>; Thu, 20 May 2010 09:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4DnlodSSEIwfleSkJ0EUiMcxU6bahdtu27ENbzbvQ+s=;
        b=HIl1hzmHnA1h4mOhm/Fh2I8GDajbIJFXdt6bcsTz0wXH3nXOd74VgpylDfUCJgqj9r
         e7VTqBS+wTjWbLDMsCnwJAGa7yC6Voo2icDgmezDqjKK592yKRzs4UbSQr2BPVTaplsb
         VOoZeVPJNEGzJ0WN7TEtcv6Ce4u9AoMPtC6VQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XN77BA/389CyuV95Y+8Ed7bwqvUDV4t7894xbFwB8G3yjY8HqeUCmpeb9JlDswQG58
         vvjX4FsOnlZgCxm+suyBylgphr5K4ce582gihp4fsNQrx2pGNAt8ijHOdVUNqUTMlE+z
         VBSTEOWpnCtfajV1f7eHplpwBXUlKNBeHZm4w=
Received: by 10.231.150.2 with SMTP id w2mr227355ibv.37.1274371366743; Thu, 20 
	May 2010 09:02:46 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Thu, 20 May 2010 09:02:46 -0700 (PDT)
In-Reply-To: <AANLkTikbl3jDXzdBhd0w6jSXTD-q5kai6Sy6CKLVmRdD@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147397>

On Tue, May 18, 2010 at 17:02, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> On Tue, May 18, 2010 at 16:40, Jeff Epler <jepler@unpythonic.net> wro=
te:
>> The amount of work to mark all the source files and then to keep the
>> marks up to date should not be underestimated--and that's just the w=
ork
>> to enable translators to localize the software. =C2=A0It is importan=
t to
>> gauge the interest in the git community in actually doing this work.
>
> It's also something you shouldn't overestimate. I've been involved in
> internationalizing several projects that were previously English-only=
=2E
>
> The work of making things translatable can be done incrementally. You
> also don't have to get everything right the first time, the current
> proof of concept translation of `git status` for instance suffers fro=
m
> numerous problems, but it's still better than nothing.
>
> It can be used as-is and then incrementally improved by arranging the
> strings more intelligently in the future.

I did some work on this in my branch:
http://github.com/avar/git/compare/master...topic/git-gettext

=46ixed up the Makefile rules a bit, added appropriate gitignores, and
added a work in progress po/is.po.

Still have to go through the gettext manual to figure out how to
integrate this with our shellscripts.

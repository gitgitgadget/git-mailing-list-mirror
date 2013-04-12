From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 06/10] compat/nedmalloc: fix spelling in comments
Date: Fri, 12 Apr 2013 09:17:08 +0200
Message-ID: <CAHGBnuN=CUNijVjEToq=mDi9uwXLxcRBTiLjN8Keg87enrJ1Mw@mail.gmail.com>
References: <CAPig+cSXC6cA8gc1T=byqeQF_gUYKpHTjpTt54Xog=jtfdgMwA@mail.gmail.com>
	<85f4e2b8e40efb234a7fc0d0ce0d40562690d001.1365719690.git.stefano.lattarini@gmail.com>
	<7v4nfch90r.fsf@alter.siamese.dyndns.org>
	<20130412064837.GA5710@elie.Belkin>
	<20130412070655.GG5710@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	sunshine@sunshineco.com, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 09:17:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQYEW-0002LX-Ho
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 09:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081Ab3DLHRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 03:17:12 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:51206 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823Ab3DLHRK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 03:17:10 -0400
Received: by mail-la0-f43.google.com with SMTP id eg20so1453711lab.30
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 00:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=lNpKkdKfBuL6PwTbHtGHxwaxyeBScqKxeNppWGw2Q/U=;
        b=IhTKVBN4hMQbIxqlSXRGLMsqbFU9OoS8HCv73bcnoM+CJTrFbqyUsS/J7qUqvaZMcZ
         PQDjRsWeuraRLpCuT43TOcaQSRjYXPU2I23x54OVWdtEox0BmuhPBNrvwOU8t7sLtKz0
         GbwMY08z0OrALuKZPcySOKrho+cis2Ckn7S2SPUfR7NTrckoNupaErflBCFVQieFKKeS
         SFM2KK1kFEGouLJUcESG3KglqZxBzHtThC/vwAIVTPfJQInJ5lsbiocUR5HHkH5goRQQ
         tAedN2ZjuyhMiEQM9QdaEn07scgjtOn8CecCibRlHRYe/N1yWeza0n+zhzymwBZWEQKn
         rvlw==
X-Received: by 10.152.26.166 with SMTP id m6mr3110419lag.4.1365751028920; Fri,
 12 Apr 2013 00:17:08 -0700 (PDT)
Received: by 10.114.84.33 with HTTP; Fri, 12 Apr 2013 00:17:08 -0700 (PDT)
In-Reply-To: <20130412070655.GG5710@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220969>

On Fri, Apr 12, 2013 at 9:06 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:

> These don't seem to be fixed yet in https://github.com/ned14/nedmalloc
> (pointed to from http://www.nedprod.com/programs/portable/nedmalloc/).
> Would it make sense to write a note to Ned and then import a fixed
> version from there?

Not necessarily. Last time I checked upstream nedmalloc has diverged
quite a lot from our version (which is why I only cherry-picked a
small change from upstream instead of taking all of it), so we should
make sure not to import any unwanted stuff when going the route of
importing upstream.

-- 
Sebastian Schuberth

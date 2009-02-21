From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [tig PATCH] Predefined external command: git commit
Date: Sat, 21 Feb 2009 18:19:58 +0100
Message-ID: <cb7bb73a0902210919n45ffb74fp6d4fa0dc9cb7ac1@mail.gmail.com>
References: <1235176121-17483-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <2c6b72b30902210819q43cbf184x77d7587a6aa1630a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 18:21:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LavXn-0007eE-Hb
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 18:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399AbZBURUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 12:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753391AbZBURUD
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 12:20:03 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:6957 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269AbZBURUA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 12:20:00 -0500
Received: by nf-out-0910.google.com with SMTP id d21so196565nfb.21
        for <git@vger.kernel.org>; Sat, 21 Feb 2009 09:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=X1DA94ceIncK4LY/EXWYGIyCUjrbp9nuIwupxNhcbJk=;
        b=KgAY2QO4fQePbEHVqUJZcENC3U2Amlg4e2WnWcKlr/ZT944PkMGWZwXyWtIsx5D7S7
         Tu1qPd5JpUMsIOv1LQWUoVPjwQTKrd0cJHRFleao84WhbHbPFvStfluqCTAZ/YO6m2K1
         PnSfd7QoYjEsfLiJsfhmNu0ytfvO8qu0ZMHYU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oc1VViS7lgM/uqO8EjnJfvQCQP7Pll8CeA4TDfg/rEVWhv7R6YFDcsQYm0w5ZahQ/Z
         Ni/fEl41ORYIFrSOkIqVPUYZaiYlc4zULkjqVH27W2ETbBN4TtFDQ7P/PtfJWwlifXNl
         jwaBpHl1FqCIx81/56FoaDmguOJuxNA1Qjci4=
Received: by 10.210.104.20 with SMTP id b20mr1738157ebc.117.1235236798900; 
	Sat, 21 Feb 2009 09:19:58 -0800 (PST)
In-Reply-To: <2c6b72b30902210819q43cbf184x77d7587a6aa1630a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110967>

On Sat, Feb 21, 2009 at 5:19 PM, Jonas Fonseca <jonas.fonseca@gmail.com> wrote:
> On Sat, Feb 21, 2009 at 01:28, Giuseppe Bilotta
> <giuseppe.bilotta@gmail.com> wrote:
>> It might make sense to map 'A' to 'git commit --amend', too, even though
>> that key is currently taken by author display toggle.
>
> We could remap author toggling to 'a' to free 'A'. I assume you want
> 'A' to make it less likely to be pressed by accident?

Actually it was more for consistency (uppercase C, uppercase A), but
it could be considered for that purpose: it makes sense to have
actions that change the repo harder to hit by accident.

> BTW, to make the keybinding more scalable, the option toggling should
> probably be hidden behind a common prefix key, which would open a menu
> with next key searching this menu.

Since t is taken by tree view, we could have 'o' for options. However,
it IS a nice thing to have quick toggles for the most common ones.

> Thanks for both patches.

Thank you for this excellent piece of software. I have some more minor
patches up at git://git.oblomov.eu/tig (gitweb at same address with
http) which I'm going to submit soon.

I honestly wish I could contribute with some more important feature
such as bundle support or automatic color inversion on light
backgrounds.

-- 
Giuseppe "Oblomov" Bilotta

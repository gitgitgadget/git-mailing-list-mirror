From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] contrib: add a pair of credential helpers for Mac OS X's keychain
Date: Mon, 3 Oct 2011 09:13:12 -0400
Message-ID: <CAG+J_DxAaw=vVENFUP5Mq9+inuDEpn_3Le_b7sO97wRUW6aFSA@mail.gmail.com>
References: <1316055113-2353-1-git-send-email-jaysoffian@gmail.com>
	<20110929075627.GB14022@sigill.intra.peff.net>
	<CAG+J_DwntGc+j3duCVqsnoJGV18FqnwXJ99C1XqKope_zbGHAA@mail.gmail.com>
	<20110930221111.GB9384@sigill.intra.peff.net>
	<CAG+J_Dww1yOeq1LHQYMiObPKqrWbk4t8Hn=G9WpYWXFBbHiuhQ@mail.gmail.com>
	<20111003105908.GF16078@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Szakmeister <john@szakmeister.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 03 15:13:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAiKb-0005Se-V3
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 15:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755882Ab1JCNNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 09:13:14 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47954 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754411Ab1JCNNM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 09:13:12 -0400
Received: by yxl31 with SMTP id 31so3449276yxl.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 06:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aS/jankaM+It/FwjOg+U4C8o6EJiGO8qlyGf0R7lbeg=;
        b=KpQCTSk6alUYQcYSOatLYjEkn/At0IIxQxQGhdm09TS/Ob35Nie0wEMNV6guCg+4R6
         ZXbDxqyhjyU/0nLCu8jui5EPtd9grHOn2p3+BjvjwNSXDdi7cOpAycyC6L7O9ILg2myP
         DxXYnc/kP8dfnJXo23o5xQshrqTwIZGnen/mw=
Received: by 10.236.183.170 with SMTP id q30mr87237076yhm.42.1317647592314;
 Mon, 03 Oct 2011 06:13:12 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Mon, 3 Oct 2011 06:13:12 -0700 (PDT)
In-Reply-To: <20111003105908.GF16078@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182661>

On Mon, Oct 3, 2011 at 6:59 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Sep 30, 2011 at 06:42:22PM -0400, Jay Soffian wrote:
>
>> Usually it won't. In the default case, the keychain is unlocked and no
>> permission is needed to add an entry, nor to retrieve that entry by
>> the application which added it. The prompt will only occur if the
>> credential helper is not on the entry's ACL, or if the keychain is
>> locked.
>
> Yeah. I was thinking the ACL prompt would come up more often, but I
> guess most people would hit "allow always", since it would get annoying
> pretty quickly otherwise (I didn't, because I was testing).

In the normal case, the keychain entry would be added via the
credential helper, so they'd never even see the prompt since the
binary which adds an entry is automatically on that entry's ACL.

> Side note: do you know how to edit those ACLs? I couldn't find it in the
> keychain manager. It would be helpful for testing to be able to tweak it
> (as a workaround, I just modified the binary, which apparently the
> keychain code cares about).

Double-click on the entry in Keychain Access, then click the "Access
Control" tab.

j.

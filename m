From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCH] gitk: disable checkout of remote branch
Date: Wed, 4 Nov 2009 22:16:04 +0530
Message-ID: <2e24e5b90911040846y35098a62m2ecd20c54263c494@mail.gmail.com>
References: <2e24e5b90911030800j22b00372r99a56c3f847a3644@mail.gmail.com>
	 <fabb9a1e0911030807h6b76b661pef75628a1255356@mail.gmail.com>
	 <1257295737457-3942366.post@n2.nabble.com>
	 <2e24e5b90911031758t651735f9xe9d078079112cfa6@mail.gmail.com>
	 <1257315478920-3943388.post@n2.nabble.com>
	 <fabb9a1e0911032241u3735fa30heaa195d959879f5a@mail.gmail.com>
	 <20091104072709.GC24263@coredump.intra.peff.net>
	 <1257325697830-3943894.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Tim Mazid <timmazid@hotmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 17:46:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5izr-0004Jc-Fd
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 17:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757342AbZKDQp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 11:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757313AbZKDQp7
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 11:45:59 -0500
Received: from mail-iw0-f180.google.com ([209.85.223.180]:61656 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757315AbZKDQp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 11:45:58 -0500
Received: by iwn10 with SMTP id 10so5065833iwn.4
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 08:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=S+4CZvroTA7nE8b6HiUcplTlNghkWurtMXo/U6qBnok=;
        b=cT8mnle4BbtROcXBssvZfGbvTcMNlDeTIErd8O4/vCYY3fTYJQrM8bSs6I9HibA052
         Jbb//+agoviTQTeMfMpQxMr/o3ICOo2o297UPl8GstZ8ceJ0xYQAu+CM91o2EQs1f9vr
         30nzF57PcmO/1EQ7WK+9r8cwHwnVUjUpeOZCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=V04zaUzHkkxdI4p0mu5wDsY2gLY6ztlo1zCy4K6Fr5kciWY1lzGCi/xF1oZn+Avvs/
         F0ZBWGxPgRaHhEHwW/AtWrwvvUzNWv/duZrRBdaD7MIkOfYgsPGcgZscOI/laqwsCVDa
         2bm6Hx+YEz4yymDxR8o+n2RAyhhsi4MLB91Xo=
Received: by 10.231.1.22 with SMTP id 22mr4247643ibd.56.1257353164043; Wed, 04 
	Nov 2009 08:46:04 -0800 (PST)
In-Reply-To: <1257325697830-3943894.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132096>

On Wed, Nov 4, 2009 at 2:38 PM, Tim Mazid <timmazid@hotmail.com> wrote:

> Hm. I actually meant inside gitk, not git itself. As in, when you click
> inside gitk and try to checkout a remote, it automatically creates a
> tracking branch and checks THAT out instead, whereas command-line git works
> the same way.
> Does that even make sense? :P

It certainly does.  And if gitk is internally running the same
"checkout" command that may happen automatically (in 1.7 or whatever).

I will "watch this space" as they say :)  I stated only my minimum
needs (prevent detached HEAD with even less warning [i.e., zero
warning] than in CLI) and managed minimum code for it.  But any other
solution that achives the same effect is also fine!

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fast-import: Stream very large blobs directly to pack
Date: Fri, 29 Jan 2010 10:37:05 -0800
Message-ID: <20100129183705.GB22101@spearce.org>
References: <20100129012350.GD20488@spearce.org> <fabb9a1e1001291035l5cd09cb6q1f12037f96dce8a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 19:37:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaviX-0006xc-VU
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 19:37:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226Ab0A2ShL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 13:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055Ab0A2ShK
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 13:37:10 -0500
Received: from mail-qy0-f182.google.com ([209.85.221.182]:64788 "EHLO
	mail-qy0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab0A2ShJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 13:37:09 -0500
Received: by qyk12 with SMTP id 12so1016965qyk.21
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 10:37:08 -0800 (PST)
Received: by 10.224.79.234 with SMTP id q42mr498145qak.364.1264790228369;
        Fri, 29 Jan 2010 10:37:08 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm1601831qyk.8.2010.01.29.10.37.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Jan 2010 10:37:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <fabb9a1e1001291035l5cd09cb6q1f12037f96dce8a1@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138336>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Fri, Jan 29, 2010 at 02:23, Shawn O. Pearce <spearce@spearce.org> wrote:
> > index 60d0aa2..8114f93 100644
> 
> Looks like you based it off an old version of fast-import, at least
> not on what is in master atm, since that has my fast-import series.
> Rebasing shouldn't be too hard, you'll just have to move the option
> parsing to the appropriate function.

I was intentionally slating this for maint, to fix a bug a user
reported when handling large streams.

But yea... I guess I also owe Junio a rebased form for master so
he has less merge conflicts to resolve.

-- 
Shawn.

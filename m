From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git fast-import/fast-export
Date: Sat, 6 Mar 2010 13:43:21 -0800
Message-ID: <20100306214321.GD2529@spearce.org>
References: <fabb9a1e1003060702r671b57f4m9308863f566d5fbd@mail.gmail.com> <7v3a0di87z.fsf@alter.siamese.dyndns.org> <fabb9a1e1003061105u70cf87b8h579fe154a24fb8f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Elijah Newren <newren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@fluxnic.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 06 23:08:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No1mV-0007NH-Ps
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 22:43:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591Ab0CFVn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 16:43:26 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52559 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab0CFVnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 16:43:25 -0500
Received: by gwb15 with SMTP id 15so2382523gwb.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 13:43:24 -0800 (PST)
Received: by 10.101.165.29 with SMTP id s29mr5598608ano.211.1267911804762;
        Sat, 06 Mar 2010 13:43:24 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm2799103iwn.7.2010.03.06.13.43.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 13:43:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <fabb9a1e1003061105u70cf87b8h579fe154a24fb8f0@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141617>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Sat, Mar 6, 2010 at 20:02, Junio C Hamano <gitster@pobox.com> wrote:
> > Isn't fast-import designed to be used as a downstream side of a pipe that
> > is fed by an independent program you write (and may link with libsvn)? ?It
> > wouldn't care what license that data producer program is distributed under.
> 
> Yes, I'm not worried about using the 'git-fast-import' or the
> 'git-fast-export' binary, I want to use-and-modify the parsing code to
> work as a fast-import/fast-export frontend to svn _on top_ of using
> those binaries..

Oh.  Yuck.

I guess I can give my blessing to relicense anything in fast-import
that I've written from GPLv2 to GPLv2 or v3.  But as Dscho points
out, there are many authors in even the parsing code.  You will
need to get consent from all of them.

-- 
Shawn.

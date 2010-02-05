From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] push: Use sideband channel for hook messages
Date: Fri, 5 Feb 2010 09:29:16 -0800
Message-ID: <20100205172916.GB27498@spearce.org>
References: <20100205033748.GA19255@spearce.org> <4B6C07E3.5030705@viscovery.net> <20100205153252.GC19255@spearce.org> <4B6C3E9C.7040009@viscovery.net> <40aa078e1002050814m1edb90f8lf3d8d138fa65c332@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Feb 05 18:29:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdRzi-00029q-Cp
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 18:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933573Ab0BER3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 12:29:21 -0500
Received: from mail-iw0-f189.google.com ([209.85.223.189]:46757 "EHLO
	mail-iw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933516Ab0BER3U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 12:29:20 -0500
Received: by iwn27 with SMTP id 27so111109iwn.5
        for <git@vger.kernel.org>; Fri, 05 Feb 2010 09:29:19 -0800 (PST)
Received: by 10.231.161.138 with SMTP id r10mr3289265ibx.34.1265390959058;
        Fri, 05 Feb 2010 09:29:19 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm1215249iwn.6.2010.02.05.09.29.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Feb 2010 09:29:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <40aa078e1002050814m1edb90f8lf3d8d138fa65c332@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139063>

Erik Faye-Lund <kusmabite@googlemail.com> wrote:
> On Fri, Feb 5, 2010 at 4:51 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> > I do agree about the over-engineering aspect. I mentioned it because in
> > one patch in the past Erik Faye-Lund also extended the async
> > infrastructure for bidirectional communication to use it in git-daemon
> > (Windows port).
> 
> Just for reference, here's the latest version I wrote of that patch,
> in case it's useful to have a peak at or something:
> 
> http://repo.or.cz/w/git/kusma.git/commit/682d90a174fc128910c1c8a4f81edb3cf9f0d9e2

Thanks Erik.  This is actually somewhat close to what I need.
I'm going to take your patch and include it in my series, with
some fixups.  I'll CC you on it when I send it out later.

-- 
Shawn.

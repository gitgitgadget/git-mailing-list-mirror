From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v2 0/2] git-gui: (un)stage a range of changes at
	once
Date: Sat, 5 Dec 2009 13:36:13 -0800
Message-ID: <20091205213613.GG5610@spearce.org>
References: <1256160023-29629-1-git-send-email-jepler@unpythonic.net> <20091026193903.GA27319@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff Epler <jepler@unpythonic.net>
X-From: git-owner@vger.kernel.org Sat Dec 05 22:36:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NH2If-0003sz-Qn
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 22:36:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756835AbZLEVgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 16:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756722AbZLEVgK
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 16:36:10 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:54454 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756641AbZLEVgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 16:36:09 -0500
Received: by yxe17 with SMTP id 17so2988975yxe.33
        for <git@vger.kernel.org>; Sat, 05 Dec 2009 13:36:16 -0800 (PST)
Received: by 10.90.62.21 with SMTP id k21mr2208264aga.10.1260048976067;
        Sat, 05 Dec 2009 13:36:16 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 22sm2214310iwn.4.2009.12.05.13.36.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Dec 2009 13:36:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091026193903.GA27319@unpythonic.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134627>

Jeff Epler <jepler@unpythonic.net> wrote:
> I've found another problem, which I'll work on as soon as I find a
> chance.
> 
> When staging multiple "+" lines preceded by a "-" line that must be
> turned into context, the converted "-" line must come after *all* the
> "+" lines, not just the first one.

So the reason this series got stuck was this message, this bug is
enough to suggest we shouldn't apply it to my tree yet, so I've
been waiting for an update on the topic.

Also, I need a Signed-off-by line.

-- 
Shawn.

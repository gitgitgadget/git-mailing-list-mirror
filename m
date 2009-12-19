From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Introduce the GIT_CONFIG_EXTRA environment variable
Date: Fri, 18 Dec 2009 18:09:47 -0800
Message-ID: <20091219020947.GB10687@spearce.org>
References: <4B2C0828.4010505@signalbeam.net> <20091219013246.GD25474@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Moe <moe@signalbeam.net>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Dec 19 03:10:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLola-0002WM-S7
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 03:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbZLSCJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 21:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932675AbZLSCJx
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 21:09:53 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:35503 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932126AbZLSCJv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 21:09:51 -0500
Received: by yxe17 with SMTP id 17so3469620yxe.33
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 18:09:50 -0800 (PST)
Received: by 10.101.174.28 with SMTP id b28mr7420966anp.160.1261188589976;
        Fri, 18 Dec 2009 18:09:49 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm2529045iwn.7.2009.12.18.18.09.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Dec 2009 18:09:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091219013246.GD25474@genesis.frugalware.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135455>

Miklos Vajna <vmiklos@frugalware.org> wrote:
> This is like GIT_CONFIG but it is not read instead of .git/config, but
> in addtition to it.

What file does `git config --add` modify?  Should we be able to
modify the GIT_CONFIG_EXTRA file?

What order is GIT_CONFIG_EXTRA applied in relative to other files
that git config would also have read?

-- 
Shawn.

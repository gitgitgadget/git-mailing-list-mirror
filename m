From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v3 RFC 1/3] Smart-http tests: Improve coverage in test
	t5560
Date: Sat, 2 Jan 2010 12:54:14 -0800
Message-ID: <20100102205414.GL6914@spearce.org>
References: <905315641001021244o522ac092g7fdaaab83a2609e2@mail.gmail.com> <1262465119-96115-1-git-send-email-tarmigan+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tarmigan Casebolt <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 21:54:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRAzP-0003Zm-1t
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 21:54:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178Ab0ABUyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 15:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752191Ab0ABUyU
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 15:54:20 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:49679 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178Ab0ABUyR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 15:54:17 -0500
Received: by ywh6 with SMTP id 6so14217287ywh.4
        for <git@vger.kernel.org>; Sat, 02 Jan 2010 12:54:17 -0800 (PST)
Received: by 10.151.1.20 with SMTP id d20mr6004ybi.119.1262465657228;
        Sat, 02 Jan 2010 12:54:17 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm15907529iwn.14.2010.01.02.12.54.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 02 Jan 2010 12:54:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1262465119-96115-1-git-send-email-tarmigan+git@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136050>

Tarmigan Casebolt <tarmigan+git@gmail.com> wrote:
> Commit 34b6cb8bb ("http-backend: Protect GIT_PROJECT_ROOT from /../
> requests") added the path_info helper function to test t5560 but did
> not use it.  We should use it as it provides another level of error
> checking.
> 
> The /etc/.../passwd case is one that is not special (and the test
> fails for reasons other than being aliased), so we remove that test
> case.
> 
> Also rename the function from 'path_info' to 'expect_aliased'.
> 
> cc: Shawn O. Pearce <spearce@spearce.org>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

-- 
Shawn.

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] http/remote-curl: coddle picky servers
Date: Thu, 21 Jan 2010 07:56:37 -0800
Message-ID: <20100121155637.GA19078@spearce.org>
References: <20100121004756.GA18213@onerussian.com> <20100121050850.GA18896@Knoppix> <be6fef0d1001202247l7467a14ap8181eb3ed830167a@mail.gmail.com> <20100121155136.17b59e8f.rctay89@gmail.com> <20100121140054.GH18213@onerussian.com> <20100121224100.624c9c9d.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 16:56:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXzOp-0007Ib-KF
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 16:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323Ab0AUP4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 10:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752112Ab0AUP4m
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 10:56:42 -0500
Received: from mail-gx0-f217.google.com ([209.85.217.217]:60576 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab0AUP4l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 10:56:41 -0500
Received: by gxk9 with SMTP id 9so113412gxk.8
        for <git@vger.kernel.org>; Thu, 21 Jan 2010 07:56:41 -0800 (PST)
Received: by 10.150.32.19 with SMTP id f19mr2266076ybf.206.1264089400995;
        Thu, 21 Jan 2010 07:56:40 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 9sm389720yxf.59.2010.01.21.07.56.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Jan 2010 07:56:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100121224100.624c9c9d.rctay89@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137659>

Tay Ray Chuan <rctay89@gmail.com> wrote:
> When "info/refs" is a static file and not behind a CGI handler, some
> servers may not handle a GET request for it with a query string
> appended (eg. "?foo=bar") properly.
> 
> If such a request fails, retry it sans the query string. In addition,
> ensure that the "smart" http protocol is not used (a service has to be
> specified with "?service=<service name>" to be conformant).
> 
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> Reported-and-tested-by: Yaroslav Halchenko <debian@onerussian.com>

*grumble* stupid Apache *grumble*

Acked-by: Shawn O. Pearce <spearce@spearce.org>

-- 
Shawn.

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/4] fast-import: use pointer-to-pointer to keep list tail
Date: Thu, 21 Mar 2013 13:43:55 -0700
Message-ID: <20130321204355.GK29311@google.com>
References: <20130321110338.GA18552@sigill.intra.peff.net>
 <20130321110817.GB18819@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 21 21:44:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UImLc-0006xs-79
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 21:44:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152Ab3CUUoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 16:44:01 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:40650 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114Ab3CUUoA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 16:44:00 -0400
Received: by mail-pd0-f169.google.com with SMTP id 3so1265458pdj.0
        for <git@vger.kernel.org>; Thu, 21 Mar 2013 13:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=KvQ0r9mygJwuvTP2qIxPJ8TuP9GE7UhSGzvcx6+vN4A=;
        b=AJu+QJfWMGLob0Rhxlr+n8f8iOs1nZu5dOspQJ0Q5vRFQKDdl1p4uCWm93xEFIZbjJ
         yhDEwhkTrjkg2p0ForgqXlr4GCbTckuhbo8fSPvqdioXNrmjMCuWe5byDoZfDE+5/XYK
         iq0D0wc3cm2ypEimQdFZO/IPVCDqonwN4gXkfrj/mWLYMpMCGb2cNw7KtGBl+GgUc4x2
         8VUQRvKaq6yhDDwJPG2wP7uYBwZd0TH02ZcxJea/Iri62G4z2gR4AqMuKs5HgYp4D+VG
         ynwXUp/rw5Vl4Ogb5jJpD1IU53vdrQYp0agGWRf5ZO+0ychc13VBjnFeM8CLrs0fNmHG
         j0Lw==
X-Received: by 10.68.129.135 with SMTP id nw7mr16698692pbb.58.1363898639828;
        Thu, 21 Mar 2013 13:43:59 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id tm1sm7263129pbc.11.2013.03.21.13.43.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 Mar 2013 13:43:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130321110817.GB18819@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218758>

Jeff King wrote:

> This is shorter, idiomatic, and it means the compiler does
> not get confused about whether our "e" pointer is valid,
> letting us drop the "e = e" hack.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> And it fixes an instance of Linus's "people do not understand pointers"

Heh.  Yes, looks correct.  For what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

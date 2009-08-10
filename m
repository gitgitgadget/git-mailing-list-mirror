From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Optimize git-favicon.png
Date: Mon, 10 Aug 2009 13:57:44 +0200
Message-ID: <200908101357.49967.jnareb@gmail.com>
References: <20090810110002.4448.88448.stgit@localhost.localdomain> <4A8006DD.30504@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Benjamin Kramer <benny.kra@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 13:58:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaTVz-0005BP-7U
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 13:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516AbZHJL6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 07:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753311AbZHJL6A
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 07:58:00 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:48651 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080AbZHJL57 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 07:57:59 -0400
Received: by fxm28 with SMTP id 28so859233fxm.17
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 04:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=iwyHbGNVlPyPN8fsRmVtLTAatDUus33/q/d53LtBIek=;
        b=Qe+JIhgarLQ4rGHeeYlyKsJubUgGutQsWEQhYSYmRZRnU01lHTR7ExojqBlGDnijC5
         LJe23ue5POY55u4SR9fIeYroh/2Q5zVeRsaAp8OHjJ1TYYE8lyMupqUPirth3QecxLrx
         mlV3XK4vRje5oD6EFsoHo+ME+VAYyg9OdBC/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=C4sQvQG399Pl3PWM7Bkgl06R47mZdxZkAF6mGphaaqYWQVL0jK9Sdjsah7AZXFDsiS
         TGocoLUrGVijjrLyPZBAtW70yxwkDp6g2G7QWE8J2tCJVVtWRAsRqGRMU1X4wUqdyZJe
         FJSMkzEYQWZVE1ga2hZ7xbhJz8FpntJlEOOsc=
Received: by 10.86.97.17 with SMTP id u17mr531586fgb.55.1249905479649;
        Mon, 10 Aug 2009 04:57:59 -0700 (PDT)
Received: from ?192.168.1.13? (abvr219.neoplus.adsl.tpnet.pl [83.8.215.219])
        by mx.google.com with ESMTPS id d6sm11728924fga.0.2009.08.10.04.57.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 04:57:59 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4A8006DD.30504@googlemail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125436>

On Mon, 10 Aug 2009, Benjamin Kramer wrote:

> Reduce size of git-favicon.png using a combination of optipng and
> pngout. From 164 bytes to 115 bytes (30% reduction).
> 
> Signed-off-by: Benjamin Kramer <benny.kra@googlemail.com>
> ---
> 
> The contest is now open. Who can do better?
> 
>  gitweb/git-favicon.png |  Bin 164 -> 115 bytes
>  1 files changed, 0 insertions(+), 0 deletions(-)

Can you optimize git-logo.png?  Smush.it wasn't able to do it, but
perhaps different PNG optimization tool will reduce git-logo.png
size...

-- 
Jakub Narebski

Git User's Survey 2009
http://tinyurl.com/GitSurvey2009

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 10/10] remote-curl: always parse incoming refs
Date: Mon, 18 Feb 2013 02:50:33 -0800
Message-ID: <20130218105033.GH7049@elie.Belkin>
References: <20130218091203.GB17003@sigill.intra.peff.net>
 <20130218093056.GJ5096@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 18 11:51:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7OJK-0002E8-Lq
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 11:51:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921Ab3BRKuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 05:50:39 -0500
Received: from mail-pb0-f49.google.com ([209.85.160.49]:44376 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764Ab3BRKui (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 05:50:38 -0500
Received: by mail-pb0-f49.google.com with SMTP id xa12so1603861pbc.22
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 02:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=gaAsE9kUSQyCWeOxcp+jfjtMsQWpkMtdMRLAMyRjaNw=;
        b=OrkAfwwBE1G5WGuEn/wCbcUeeTR3REaeUuG5fU/+OCUQdEKV8kowpOOGwLxaGAObJV
         bTaYG2+VEZWmVgalnBbJuQdtUtV27X1Ucuv01RgvU0dQYVPkCdwLNgleOFdgA7zvVqw7
         297UlKgAE69+ScT7BUu5kueuCNRSReeOD9WVffhG9VK6ix9GL/GFfnhQ4N2XSWijPc+O
         5V6/Ii5u6qajpXeA5jp7jX+ZJga8HyztHU6phMCUlUIFqVIRNQxYxkymhhgUmuOgMloR
         d5cQHBpsWccQSI034pH4XrtIIL1rp63C+kN/eRCsuAYZ4k14RuTOhsYuvSUuqURKO/OY
         1s+w==
X-Received: by 10.68.213.66 with SMTP id nq2mr28664005pbc.29.1361184637989;
        Mon, 18 Feb 2013 02:50:37 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id wm3sm14117479pbc.4.2013.02.18.02.50.35
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 02:50:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130218093056.GJ5096@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216475>

Jeff King wrote:

>  remote-curl.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)

I like.

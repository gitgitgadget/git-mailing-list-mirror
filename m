From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 8/8] Enable GIT_DEBUG_MEMCHECK on git_pathname()
Date: Fri, 18 Nov 2011 00:52:04 -0600
Message-ID: <20111118065204.GD25145@elie.hsd1.il.comcast.net>
References: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
 <1321522335-24193-9-git-send-email-pclouds@gmail.com>
 <CALkWK0ndE1Q_jNSV7CBB5W2NyVhcy7kgNO5woWWOw6CXx3cxcA@mail.gmail.com>
 <20111117134201.GA30718@sigill.intra.peff.net>
 <CACsJy8A25SyLVKv8GwkYaHBJwU5tHqgdJK6L-upF9HWseFzCtQ@mail.gmail.com>
 <20111118012746.GA22485@elie.hsd1.il.comcast.net>
 <CALKQrgfTKmSd8se3n3xq89SXRmNPm3qz3Ckv2mUghot8kStKxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Nov 18 07:52:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRIJP-0001Sy-G2
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 07:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599Ab1KRGw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 01:52:29 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37840 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755025Ab1KRGwO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 01:52:14 -0500
Received: by ghbz2 with SMTP id z2so202536ghb.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 22:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=j9uJkpPncYcan/XsZyJwxfWlv5NzZrfv6SkJt3IBG/Y=;
        b=xryjKtmDRUo7onzJrVF9E2jFIgGIr+gF5WwUDNzbagIpTjbV9ASADYkIqXhtNrHBxE
         ROOmunc4a5MOC04YsApsWpHzLoCsObGhAF0cw6hnT8WlHnC/xoSaCB0rkHiFYFO2rhYR
         BPGKzAkk6k9xeKieaV5iwcOXHkqQSwV4QaHmI=
Received: by 10.101.212.38 with SMTP id o38mr375022anq.150.1321599133742;
        Thu, 17 Nov 2011 22:52:13 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id c44sm9733838yhm.5.2011.11.17.22.52.11
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 22:52:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALKQrgfTKmSd8se3n3xq89SXRmNPm3qz3Ckv2mUghot8kStKxA@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185638>

Johan Herland wrote:

> Acked-by: Johan Herland <johan@herland.net>

Thanks for looking it over.

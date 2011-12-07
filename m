From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/5] Re-roll rr/revert-cherry-pick
Date: Wed, 7 Dec 2011 03:56:36 -0600
Message-ID: <20111207095636.GA13374@elie.hsd1.il.comcast.net>
References: <1323239877-24101-1-git-send-email-artagnon@gmail.com>
 <20111207081734.GG11737@elie.hsd1.il.comcast.net>
 <CALkWK0k+GF9qjwYd_TzA3o8FqAH6G+cxREZ5r9x8E2G5k-mmmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 10:56:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYEFB-0004Ti-3m
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 10:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744Ab1LGJ4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 04:56:48 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41491 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329Ab1LGJ4r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 04:56:47 -0500
Received: by iakc1 with SMTP id c1so688297iak.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 01:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4DDnP2Z/KDyuFZwDSl2znyfIkZNm+CXhw+II6suS27M=;
        b=VQGm9CcUOYyVYMwevK2+j+OlsbIJ1jdKtZKBKULfJrMN+OVaYnV80+BdEjI8WOQkxy
         uxfa816IMGh6qqE7U0v6gyATDhr/9GhJ+ujqy+yZGPhfbJKqEAuZV6e0LaX3nHSv4hAX
         Sd4Bp4NDj6iKbHk0fZihKjHS1pYcA9GLK3m5E=
Received: by 10.42.189.5 with SMTP id dc5mr17824479icb.51.1323251805565;
        Wed, 07 Dec 2011 01:56:45 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id jm11sm4967401ibb.1.2011.12.07.01.56.44
        (version=SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 01:56:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0k+GF9qjwYd_TzA3o8FqAH6G+cxREZ5r9x8E2G5k-mmmg@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186452>

Ramkumar Ramachandra wrote:

> I suppose they were a combination of all three.  I'm sorry- I'll try
> to be more careful and communicative in the future.

Hm, that is not exactly what I was going for, either.  First, I didn't
mean to harp on anything in the past --- it was a request regarding
this current review.  And on the other hand, I am not sure it is a
matter of you being uncareful or uncommunicative, exactly.  It's more
that _I_ am doing a poor job of clearly conveying what Junio described
as easier to learn on one's own at [1].

To put it more concretely:

I am going to be stubborn.  I will not ack a patch unless I can
imagine myself, years from now, after running into a bug in a related
area, not being confused by it.

[1] http://thread.gmane.org/gmane.comp.version-control.git/186402/focus=186415

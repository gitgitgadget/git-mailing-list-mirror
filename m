From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: do not set setgid bit on directories on
 GNU/kFreeBSD
Date: Mon, 3 Oct 2011 14:42:40 -0500
Message-ID: <20111003194214.GA18153@elie>
References: <20111003064120.GA24396@elie>
 <20111003071949.GC17289@elie>
 <7vlit1ga2l.fsf@alter.siamese.dyndns.org>
 <CAGdFq_hQ-qoktgHB6ACF8H2AmeMyfo-bW4VBxfL-CPw5kDMFQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Petr Salinger <Petr.Salinger@seznam.cz>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 21:42:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAoPh-0004c5-JU
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 21:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757441Ab1JCTmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 15:42:53 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56562 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756250Ab1JCTmw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 15:42:52 -0400
Received: by yxl31 with SMTP id 31so3829110yxl.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 12:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MA/8yyPjhDifwWIcGbzoncIN0BKCQt9ch5kTahW2liU=;
        b=Se5M9fW6T3wQsi2kYhB2N4F4X9odtTg/4kgFhrKDpV3YDgAYozeW8hU/Tsr17Z9vkr
         Z7M8c+cpji+TwQmlvMe7xuRKI1YEQhgLtryh/gqyG+8RoklnxEoy5XIa9FIbwEzE/ub8
         PN/vk4TtDGog9LBK5wPXQe/Pv64uXjorjnXHk=
Received: by 10.236.139.138 with SMTP id c10mr2033805yhj.62.1317670971815;
        Mon, 03 Oct 2011 12:42:51 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id w70sm16767456yhk.6.2011.10.03.12.42.50
        (version=SSLv3 cipher=OTHER);
        Mon, 03 Oct 2011 12:42:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGdFq_hQ-qoktgHB6ACF8H2AmeMyfo-bW4VBxfL-CPw5kDMFQw@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182706>

Sverre Rabbelier wrote:

> I would assume PS mailed JN off list?

Yes, that's right.  Sorry for the cryptic message.

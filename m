From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/18] config: Introduce functions to write non-standard
 file
Date: Thu, 28 Jul 2011 19:35:00 +0200
Message-ID: <20110728173500.GA29866@elie.dc0b.debconf.org>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
 <1311871951-3497-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 19:35:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmUUN-0001vt-Ts
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 19:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755880Ab1G1RfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 13:35:11 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58282 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755820Ab1G1RfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 13:35:09 -0400
Received: by fxh19 with SMTP id 19so1465512fxh.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 10:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WW5PDpoukwP8NSu9W3aNQa1PZJpxPOiHX0PJyuEKEGQ=;
        b=Zdiyi0coElnX+g5KEfKBmvsrzTS4texV9bvVey+BxUFIpIqsMgcFdKEvhMrTM/+P1H
         pJVt+g7g0tu/OnZciLZS/T5zZkP974t23iqsgaliE2hXv3zSQcehKjBJ9tQxNx+7vOLj
         FrX7fTDvmpCoevHRLjX99LVRmZ6G8kE6dTlMs=
Received: by 10.223.144.66 with SMTP id y2mr383557fau.0.1311874508117;
        Thu, 28 Jul 2011 10:35:08 -0700 (PDT)
Received: from elie.dc0b.debconf.org ([78.28.140.4])
        by mx.google.com with ESMTPS id e10sm600856fak.42.2011.07.28.10.35.05
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 10:35:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311871951-3497-3-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178104>

Ramkumar Ramachandra wrote:

> Expose thse new functions in cache.h for other git programs to use.

s/thse/these/

Other messages need a spell-check, too.  Aside from that, patches 1-3
look good --- thanks for your perseverance.

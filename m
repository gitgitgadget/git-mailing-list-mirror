From: Brian Gesiak <modocache@gmail.com>
Subject: Re: [PATCH 1/2] t3200-branch: test setting branch as own upstream
Date: Fri, 28 Feb 2014 20:16:13 +0900
Message-ID: <CAN7MxmVxYhF1VXWZNAXyfF8iBNQaqqwoyjmDAP_9_bc5NUUU6A@mail.gmail.com>
References: <1393556659-32717-1-git-send-email-modocache@gmail.com>
	<20140228053703.GA32556@sigill.intra.peff.net>
	<531032DD.9000904@viscovery.net>
	<20140228071401.GA1229@sigill.intra.peff.net>
	<20140228072606.GA622@sigill.intra.peff.net>
	<CAN7MxmXOvkrWPDEUH_Bqz5RVZUS7kuWkwi9kWmdwuwySszd=YA@mail.gmail.com>
	<20140228083718.GA11480@sigill.intra.peff.net>
	<CAN7MxmUUoz-HGFiTfgpvLpkXhvjBn_dYje7unoHE-Y=k3A0aqg@mail.gmail.com>
	<20140228105929.GA18960@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 28 12:16:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJLQU-0008WS-2X
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 12:16:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbaB1LQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 06:16:16 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:60998 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbaB1LQO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 06:16:14 -0500
Received: by mail-ie0-f179.google.com with SMTP id to1so3254279ieb.10
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 03:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mO2OpY91kqyvS2qEiTHkXxZ441ppC68rE7kqYy7r8JE=;
        b=S5P+Zr2cP3ojK3tciveq4wDTXJb0x70ZMCi9AzZUnUmgDEGbCa8oiUYGkpa6+V6x9r
         kBa8b7XSQeReTCyB9VhrvEqKgsaXSKdWNcEvUHr2Pehtr+aUhsek7NCpAhQQBUK93AE0
         XZDEtP7gvhRqtqemFEG5UgBxOVvBwmjb6kB+ZdjuqqIQRN+R4l+xSQUpW78bDO9jNiS3
         fJNqd2p0CaLwerHXZy0vkjWe+NR+ZFd7xbBKmH8zpbs8jYNsh2o3GeeVA3ACchlnScKF
         RTHpFd18YDzOx4gaF7ZiaNHiMP2QdjUSyRm6dpWqvYnukM7EUgeW8g2vX3GfjXQ6ZY9x
         NGuw==
X-Received: by 10.50.93.106 with SMTP id ct10mr3252144igb.21.1393586173812;
 Fri, 28 Feb 2014 03:16:13 -0800 (PST)
Received: by 10.64.55.161 with HTTP; Fri, 28 Feb 2014 03:16:13 -0800 (PST)
In-Reply-To: <20140228105929.GA18960@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242942>

> I just don't want to regress somebody else's workflow due
> to my lack of imagination.

This makes a lot of sense to me, although as-is the function emits a
warning and returns immediately (although with a successful status
code), so I'm also stumped as to what kind of workflow this would be
included in.

In any case, if the jury's out on this one, I suppose the two patches
I submitted are good to merge? Part of me thinks the bump from warning
to error belongs in its own patch anyway.

- Brian Gesiak

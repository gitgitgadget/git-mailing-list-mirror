From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Pointers to CVS 2 GIT imports and gateways
Date: Mon, 9 May 2005 17:41:13 +1200
Message-ID: <46a038f905050822413ece89b9@mail.gmail.com>
References: <46a038f90505081616335c2a61@mail.gmail.com>
	 <427EEB9E.9070701@zytor.com>
Reply-To: Martin Langhoff <martin.langhoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 07:34:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DV0uJ-00009E-Ag
	for gcvg-git@gmane.org; Mon, 09 May 2005 07:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263048AbVEIFlS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 01:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263049AbVEIFlS
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 01:41:18 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:42660 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263048AbVEIFlP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 May 2005 01:41:15 -0400
Received: by rproxy.gmail.com with SMTP id j1so663816rnf
        for <git@vger.kernel.org>; Sun, 08 May 2005 22:41:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NFJXcOCTuCXh/13LO3jr10isUlhUU69/4xd4AbOno7zYckAsHloFhrMTxhbZ+1dqjOEZpuLrNdKgQDxlv3wZkffCrXPNqqTn1K081TJ1I2x8EWXyZM5OIVUi9aoIQQqCs/vIti6KQF6sjTLbJclKcX6Q81ImQRD2eUMhKeOd9WQ=
Received: by 10.38.96.39 with SMTP id t39mr1321279rnb;
        Sun, 08 May 2005 22:41:13 -0700 (PDT)
Received: by 10.38.101.1 with HTTP; Sun, 8 May 2005 22:41:13 -0700 (PDT)
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <427EEB9E.9070701@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 5/9/05, H. Peter Anvin <hpa@zytor.com> wrote:
> What would be the point?  The reason for bkcvs was that bk wasn't
> available to everyone.

Ease of transition for other automated tasks, perhaps? I don't know
what bits and pieces of infrastructure hang from the old BK-CVS
changeset distribution infrastructure.

Some projects do count on CVS gateways even if they use smarter SCMs.
This is not just because of licensing issues -- sometimes portability
and preexisting tools trump SCM changes.

regards,


martin

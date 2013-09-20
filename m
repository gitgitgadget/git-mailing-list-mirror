From: Marek Vasut <marex@denx.de>
Subject: Re: [BUG] git clone -q ends with early EOF
Date: Fri, 20 Sep 2013 15:58:41 +0200
Message-ID: <201309201558.41901.marex@denx.de>
References: <201309181444.19070.marex@denx.de> <20130918181443.GA18821@sigill.intra.peff.net> <xmqqa9j9vriv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 20 15:58:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VN1EP-0003m9-D5
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 15:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505Ab3ITN6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Sep 2013 09:58:45 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:47851 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652Ab3ITN6o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 09:58:44 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3chGjt3RXKz4KK4T;
	Fri, 20 Sep 2013 15:58:42 +0200 (CEST)
X-Auth-Info: 4Gf0omTkusuqKz9+KVbteb+QU3BLJiYbXowtAgCK63s=
Received: from chi.localnet (unknown [195.140.253.167])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.mnet-online.de (Postfix) with ESMTPSA id 3chGjt15DHzbbjY;
	Fri, 20 Sep 2013 15:58:42 +0200 (CEST)
User-Agent: KMail/1.13.7 (Linux/3.10-2-amd64; KDE/4.8.4; x86_64; ; )
In-Reply-To: <xmqqa9j9vriv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235068>

Hi,

> Jeff King <peff@peff.net> writes:
> > The keepalive patch is not in any released version yet, but we have been
> > running it in production at GitHub for a few weeks.
> 
> That is good to hear; I'd feel safer to bump the scheduled
> graduation date to 'master' for the topic in that case.
> 
> Like tomorrow ;-)

I reported the issue on Ubuntu Lunchpad here [1], so I hope they will eventually 
fix it.

[1] https://bugs.launchpad.net/ubuntu/+source/git/+bug/1228148

Best regards,
Marek Vasut

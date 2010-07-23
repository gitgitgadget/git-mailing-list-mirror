From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/7] revert: refactor code to find commit subject in find_commit_subject()
Date: Fri, 23 Jul 2010 11:37:59 +0200
Message-ID: <201007231138.00360.chriscool@tuxfamily.org>
References: <20100722131141.2148.63850.chriscool@tuxfamily.org> <20100722131836.2148.58435.chriscool@tuxfamily.org> <20100722165012.GA4938@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 23 11:38:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcEhn-0005Qv-34
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 11:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489Ab0GWJiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 05:38:05 -0400
Received: from smtp2f.orange.fr ([80.12.242.152]:58079 "EHLO smtp2f.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752867Ab0GWJiD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 05:38:03 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f24.orange.fr (SMTP Server) with ESMTP id 58969800082F;
	Fri, 23 Jul 2010 11:38:01 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f24.orange.fr (SMTP Server) with ESMTP id 4AA7380006FD;
	Fri, 23 Jul 2010 11:38:01 +0200 (CEST)
Received: from style.localnet (ANantes-156-1-42-45.w90-12.abo.wanadoo.fr [90.12.33.45])
	by mwinf2f24.orange.fr (SMTP Server) with ESMTP id 233A6800082F;
	Fri, 23 Jul 2010 11:38:01 +0200 (CEST)
X-ME-UUID: 20100723093801144.233A6800082F@mwinf2f24.orange.fr
User-Agent: KMail/1.13.2 (Linux/2.6.32-23-generic; KDE/4.4.2; x86_64; ; )
In-Reply-To: <20100722165012.GA4938@m62s10.vlinux.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151508>

On Thursday 22 July 2010 18:50:12 Peter Baumann wrote:
> Wouldn't it be better to merge this with  [PATCH 4/7], so we won't create
> find_commit_subject in revert.c and then immediatly move it to commit.c?

Yeah, I could have merged those 2 patches, but except for the first one I 
developed them in the order I sent them. So I didn't think much about merging 
some as it felt natural to send them as is.

Best regards,
Christian.

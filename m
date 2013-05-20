From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH] patch-ids: check modified paths before calculating
 diff
Date: Mon, 20 May 2013 09:16:38 +0100
Message-ID: <20130520081638.GL27005@serenity.lan>
References: <a7088a74742b71a01423f3ddc1a6c7fd89474ed8.1368969438.git.john@keeping.me.uk>
 <20130519193612.GH3362@elie.Belkin>
 <20130519220206.GK27005@serenity.lan>
 <20130520063623.GB2919@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kevin Bracey <kevin@bracey.fi>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 20 10:16:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeLH3-00011c-4j
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 10:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336Ab3ETIQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 04:16:48 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:59990 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755141Ab3ETIQs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 04:16:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 7F462606528;
	Mon, 20 May 2013 09:16:47 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id virwq4h+yWHA; Mon, 20 May 2013 09:16:47 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 5921D6064F2;
	Mon, 20 May 2013 09:16:40 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130520063623.GB2919@elie.Belkin>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224943>

On Sun, May 19, 2013 at 11:36:23PM -0700, Jonathan Nieder wrote:
> I don't know what it should mean to try to use --cherry without
> --no-merges or --first-parent, so I guess this is harmless.

Currently --no-merges doesn't actually get passed down this far.  We do
the patch ID calculations without taking that into account.

From: Elias Persson <delreich@takeit.se>
Subject: Re: git diff-index ignores color config
Date: Wed, 27 Apr 2011 09:20:46 +0200
Message-ID: <1303888846.10130.7.camel@dhcp-141.kontor.deklomp.se>
References: <1303830261.3387.21.camel@dhcp-141.kontor.deklomp.se>
	 <7voc3sewpg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 09:21:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEz3U-0003JL-3U
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 09:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500Ab1D0HUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 03:20:51 -0400
Received: from customer.fxs.se ([62.20.50.25]:45588 "EHLO mail.takeit.se"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753046Ab1D0HUv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 03:20:51 -0400
Received: from [85.24.215.141] (unknown [85.24.215.141])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.takeit.se (Postfix) with ESMTP id D66E54FF05;
	Wed, 27 Apr 2011 09:20:47 +0200 (CEST)
In-Reply-To: <7voc3sewpg.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.32.2 (2.32.2-1.fc14) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172182>

On Tue, 2011-04-26 at 10:42 -0700, Junio C Hamano wrote:
> Isn't that very much on purpose?  diff-{index,tree,files} plumbings should
> not be affected by UI related configuration variables.

Documentation indicates that color is configurable for it though.
I can't say if the issue is with the behavior or the documentation.

I can say I find the pre-commit verifying hook to be a lot more
useful when you can actually see the whitespace issues.

From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] Teach git.el to mark/unmark files by regexp
Date: Sat, 30 Aug 2008 20:41:35 +0200
Message-ID: <87myiuwdk0.fsf@wine.dyndns.org>
References: <1219807480-57122-1-git-send-email-david@endpoint.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Christensen <david@endpoint.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 20:42:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZVPO-0003dC-7T
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 20:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769AbYH3Slp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 14:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753743AbYH3Slp
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 14:41:45 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:40260 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691AbYH3Slo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 14:41:44 -0400
Received: from adsl-89-217-62-226.adslplus.ch ([89.217.62.226] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1KZVOD-0003Yu-Nf; Sat, 30 Aug 2008 13:41:43 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 5E3411E716B; Sat, 30 Aug 2008 20:41:35 +0200 (CEST)
In-Reply-To: <1219807480-57122-1-git-send-email-david@endpoint.com> (David
	Christensen's message of "Tue, 26 Aug 2008 22:24:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
X-Spam-Score: -3.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94404>

David Christensen <david@endpoint.com> writes:

> Adds the functions git-mark-regexp and git-unmark-regexp to git.el.
> Creates a mark-map keymap to support dired-like behavior for
> marking/unmarking via regexp.  Also adds these functions to the
> menubar.

I think that emulating dired behavior is a good idea, but you should go
all the way and make it fully compatible, unmark is supposed to be "* %"
with a prefix arg, and "* DEL" should be git-unmark-file-up.

-- 
Alexandre Julliard
julliard@winehq.org

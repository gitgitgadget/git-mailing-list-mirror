From: Alexandre Julliard <julliard@winehq.org>
Subject: git-checkout regression?
Date: Thu, 28 Feb 2008 15:11:24 +0100
Message-ID: <87wsop188j.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 15:12:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUjUs-00038i-DQ
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 15:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754836AbYB1OLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 09:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754337AbYB1OLk
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 09:11:40 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:44105 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbYB1OLi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 09:11:38 -0500
Received: from adsl-62-167-54-98.adslplus.ch ([62.167.54.98] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1JUjTr-0001JN-6G; Thu, 28 Feb 2008 08:11:37 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 6B34E1E715D; Thu, 28 Feb 2008 15:11:24 +0100 (CET)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -2.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75401>

Since the rewrite in C, "git checkout HEAD file" no longer updates the
index entry for file, it needs an extra git-update-index --refresh. Is
that a deliberate change?

-- 
Alexandre Julliard
julliard@winehq.org

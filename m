From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] Write index file on any checkout of files
Date: Thu, 28 Feb 2008 17:07:51 +0100
Message-ID: <87hcft12ug.fsf@wine.dyndns.org>
References: <87wsop188j.fsf@wine.dyndns.org>
	<alpine.LNX.1.00.0802281058190.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Feb 28 17:09:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUlJH-0008WA-Us
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 17:08:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbYB1QIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 11:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753312AbYB1QIB
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 11:08:01 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:52003 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbYB1QIB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 11:08:01 -0500
Received: from adsl-62-167-54-98.adslplus.ch ([62.167.54.98] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1JUlIY-0006IF-32; Thu, 28 Feb 2008 10:08:00 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id C9A241E715D; Thu, 28 Feb 2008 17:07:51 +0100 (CET)
In-Reply-To: <alpine.LNX.1.00.0802281058190.19665@iabervon.org> (Daniel
	Barkalow's message of "Thu, 28 Feb 2008 10:58:59 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -2.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75419>

Daniel Barkalow <barkalow@iabervon.org> writes:

> We need to rewrite the index file when we check out files, even if we
> haven't modified the blob info by reading from another tree, so that
> we get the stat cache to include the fact that we just modified the
> file so it doesn't need to be refreshed.

That fixes the problem for me. Thanks!

-- 
Alexandre Julliard
julliard@winehq.org

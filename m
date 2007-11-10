From: David Kastrup <dak@gnu.org>
Subject: Re: t7005 and vi in GIT_EXEC_PATH
Date: Sat, 10 Nov 2007 23:09:47 +0100
Message-ID: <85abpl69ck.fsf@lola.goethe.zz>
References: <9A9986E7-E03D-458A-9A19-A3EF0E7B203D@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 23:10:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqyWy-0004SC-7G
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 23:10:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754607AbXKJWKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 17:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754569AbXKJWKE
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 17:10:04 -0500
Received: from mail-in-16.arcor-online.net ([151.189.21.56]:44891 "EHLO
	mail-in-16.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754596AbXKJWKD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2007 17:10:03 -0500
Received: from mail-in-18-z2.arcor-online.net (mail-in-18-z2.arcor-online.net [151.189.8.35])
	by mail-in-16.arcor-online.net (Postfix) with ESMTP id 8CAEE1A4DCC;
	Sat, 10 Nov 2007 23:10:01 +0100 (CET)
Received: from mail-in-17.arcor-online.net (mail-in-17.arcor-online.net [151.189.21.57])
	by mail-in-18-z2.arcor-online.net (Postfix) with ESMTP id 72B73510040;
	Sat, 10 Nov 2007 23:10:01 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-003-069.pools.arcor-ip.net [84.61.3.69])
	by mail-in-17.arcor-online.net (Postfix) with ESMTP id 3A84B2BBF7D;
	Sat, 10 Nov 2007 23:09:53 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id B17BA1C4614A; Sat, 10 Nov 2007 23:09:47 +0100 (CET)
In-Reply-To: <9A9986E7-E03D-458A-9A19-A3EF0E7B203D@silverinsanity.com> (Brian
	Gernhardt's message of "Sat, 10 Nov 2007 17:03:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4745/Sat Nov 10 11:50:27 2007 on mail-in-17.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64381>

Brian Gernhardt <benji@silverinsanity.com> writes:

> If vi is in GIT_EXEC_PATH, then t7005-editor.sh fails because the real
> vi is invoked instead of the test vi script.  This is because the git
> wrapper puts GIT_EXEC_PATH ahead of ".".  I see no easy solution to
> this problem, and thought I should bring it up with the list.

Putting "." at the front of GIT_EXEC_PATH instead of PATH would appear
to do the trick then, wouldn't it?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum

From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Fixing path quoting issues
Date: Thu, 11 Oct 2007 22:53:25 +0200
Message-ID: <85k5pts796.fsf@lola.goethe.zz>
References: <11920508172434-git-send-email-jon.delStrother@bestbefore.tv>
	<470DC05A.8020209@viscovery.net> <854pgytafi.fsf@lola.goethe.zz>
	<470DCC76.7070809@viscovery.net>
	<81156EED-7AC0-4C8B-98B1-8338262459A6@bestbefore.tv>
	<470DD3B8.1080809@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan del Strother <jon.delStrother@bestbefore.tv>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 11 22:53:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig51X-0006Sl-Kf
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 22:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755373AbXJKUwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 16:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755231AbXJKUwk
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 16:52:40 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:34293 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662AbXJKUwj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 16:52:39 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1Ig51J-0007LN-Hy; Thu, 11 Oct 2007 16:52:37 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id A3C441C1F3DC; Thu, 11 Oct 2007 22:53:25 +0200 (CEST)
In-Reply-To: <470DD3B8.1080809@viscovery.net> (Johannes Sixt's message of "Thu\, 11 Oct 2007 09\:41\:44 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60635>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Jonathan del Strother schrieb:
>> How are you going to test that git works on paths with spaces if the
>> test suite doesn't run there?
>
> By writing a specific test?

This is going to be much less thorough.  And it does no harm if the
test scripts demonstrate defensive programming.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum

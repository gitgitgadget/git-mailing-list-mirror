From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Add a test for git-commit being confused by relative GIT_DIR
Date: Sun, 12 Aug 2007 20:44:45 +0200
Message-ID: <85eji8oan6.fsf@lola.goethe.zz>
References: <7vbqddn8zj.fsf@assigned-by-dhcp.cox.net>
	<85tzr5spaj.fsf@lola.goethe.zz>
	<7vvebljz31.fsf@assigned-by-dhcp.cox.net>
	<854pj5s104.fsf@lola.goethe.zz>
	<7vir7kk7jg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 20:45:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKIQx-0000wh-Kl
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 20:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933337AbXHLSos (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 14:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933230AbXHLSos
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 14:44:48 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:53019 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933221AbXHLSor (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 14:44:47 -0400
Received: from mail-in-07-z2.arcor-online.net (mail-in-07-z2.arcor-online.net [151.189.8.19])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 6C91113CF7;
	Sun, 12 Aug 2007 20:44:46 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-07-z2.arcor-online.net (Postfix) with ESMTP id 579B42C6A1A;
	Sun, 12 Aug 2007 20:44:46 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-036-190.pools.arcor-ip.net [84.61.36.190])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 2F3F135E697;
	Sun, 12 Aug 2007 20:44:46 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 980C71C3C79D; Sun, 12 Aug 2007 20:44:45 +0200 (CEST)
In-Reply-To: <7vir7kk7jg.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sun\, 12 Aug 2007 10\:05\:23 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3936/Sun Aug 12 17:10:09 2007 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55698>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>>> Also I do not think you would want to say touch $(pwd)/output
>>> there inside the here text that begins with <<EOF not <<\EOF.
>>
>> But I most certainly do!
>
> Then you would need to shell-quote $(pwd) so that you can have
> your git.git checked out somewhere under "/My Documents/source"
> directory, wouldn't you?

Ok, that's a tough one.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum

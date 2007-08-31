From: Nanako Shiraishi <nanako3@bluebottle.com>
Subject: Re: [RFC] Change handling of RelNotes
Date: Fri, 31 Aug 2007 15:44:58 +0900
Message-ID: <200708310645.l7V6jKJk009287@mi0.bluebottle.com>
References: <316a20a40708301835hc4236d4tdb289b6f705ab86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git mailing list <git@vger.kernel.org>
To: "Stephen Cuppett" <cuppett@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 08:45:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR0Fx-0004Th-Jh
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 08:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759340AbXHaGpW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 02:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758772AbXHaGpV
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 02:45:21 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:49424 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758513AbXHaGpV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 02:45:21 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l7V6jKJk009287
	for <git@vger.kernel.org>; Thu, 30 Aug 2007 23:45:20 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:in-reply-to:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=ybHdlrNRCY5sHwR458dEUqauoM6QrhCRpUYnuClTHVOJ/1wQphQOTDKzsoroYAeJe
	OXQ+lzd3AF0xFfWC61+s5F3m4hZLlPlbIbKZYVoe3SqNGSP2yWr/YoPjEKxulxK
Received: from nanako3.mail.bluebottle.com (NK210-201-54-212.cl.static.apol.com.tw [210.201.54.212])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l7V6jDIT020701
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 30 Aug 2007 23:45:18 -0700
In-Reply-To: <316a20a40708301835hc4236d4tdb289b6f705ab86@mail.gmail.com>
X-Trusted-Delivery: <916891d552e20d7c2939b14fad0f3c66>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57122>

Quoting "Stephen Cuppett" <cuppett@gmail.com>:

> I propose we eliminate this symlink.

Maybe it is just me, but you do not sound like you are proposing to do
anything yourself.  You are simply demanding Junio to change the way he
works.  Instead of being able to edit RelNotes at the toplevel, relying
on the symbolic link to let him edit the right file, you are forcing him
to edit the appropriate file in Documentation/ directory.

Shouldn't you have at least said "I request" instead?

I sometimes have a checkout on a filesystem that does not support
symbolic links, but I set core.symlink configuration variable to false
in such a case.  Would it make sense to update "git init" to autodetect
lack of symbolic link support in the filesystem?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Free pop3 email with a spam filter.
http://www.bluebottle.com/tag/5

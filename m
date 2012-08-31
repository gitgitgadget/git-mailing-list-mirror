From: Thomas Ackermann <th.acker66@arcor.de>
Subject: Aw: Re: git blame shows wrong "Not commited yet" entries
Date: Fri, 31 Aug 2012 15:07:42 +0200 (CEST)
Message-ID: <1672779223.499907.1346418462641.JavaMail.ngmail@webmail08.arcor-online.net>
References: <7v7gsgqd4w.fsf@alter.siamese.dyndns.org> <1055159053.19198.1345536909730.JavaMail.ngmail@webmail24.arcor-online.net>
 <303882026.440710.1346315214352.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 31 15:07:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7Qwx-0005Zt-NY
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 15:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197Ab2HaNHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Aug 2012 09:07:44 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:56324 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753002Ab2HaNHo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Aug 2012 09:07:44 -0400
Received: from mail-in-12-z2.arcor-online.net (mail-in-12-z2.arcor-online.net [151.189.8.29])
	by mx.arcor.de (Postfix) with ESMTP id A76275A305;
	Fri, 31 Aug 2012 15:07:42 +0200 (CEST)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-12-z2.arcor-online.net (Postfix) with ESMTP id A67362E6151;
	Fri, 31 Aug 2012 15:07:42 +0200 (CEST)
Received: from webmail08.arcor-online.net (webmail08.arcor-online.net [151.189.8.44])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 9F10E26C9B;
	Fri, 31 Aug 2012 15:07:42 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-12.arcor-online.net 9F10E26C9B
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1346418462; bh=BnbhaKLiXKyB4uY56PlCGaoOqawjX2kIPOYA3OXsBBo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=JJ2L9F34UUO23ZDV32hx4zChJu9iraIc7pta4+1De+8FKSOYPXGO6f8vyYCNlaXf5
	 gUus12blyufbeBJJdZLaxzAATK4RfLTK2jR8rapfymKvLNowkGjx/981GdBg87mIvY
	 uP9rH7XGi66DhivkwuY2UspBuggHOa8+eXlrGWGs=
Received: from [188.98.233.230] by webmail08.arcor-online.net (151.189.8.44) with HTTP (Arcor Webmail); Fri, 31 Aug 2012 15:07:42 +0200 (CEST)
In-Reply-To: <7v7gsgqd4w.fsf@alter.siamese.dyndns.org>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.233.230
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204584>


You are right but as I mentioned in my posting I am using "core.ignorecase=true"
so I expected "file.txt" and "File.txt" to be treated the same.

The man-page for git-config says:
"core.ignorecase
If true, this option enables various workarounds to enable git to work better on filesystems that are not case sensitive, like FAT.
For example, if a directory listing finds "makefile" when git expects "Makefile", git will assume it is really the same file, 
and continue to remember it as "Makefile"."

So "various workarounds" does _not_ mean that _all_ filenames are processed modulo upper/lower case, or?


---
Thomas

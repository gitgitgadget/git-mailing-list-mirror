From: Andreas Krey <a.krey@gmx.de>
Subject: Re: [PATCH 1/3] upload-pack: send the HEAD information
Date: Fri, 6 Sep 2013 21:29:18 +0200
Message-ID: <20130906192918.GJ12966@inner.h.apk.li>
References: <20130906155204.GE12966@inner.h.apk.li> <20130906155608.GF12966@inner.h.apk.li> <xmqqsixhyhan.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 21:29:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI1iq-0003X8-Hd
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 21:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120Ab3IFT3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 15:29:33 -0400
Received: from continuum.iocl.org ([217.140.74.2]:51804 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab3IFT3c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 15:29:32 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r86JTI208847;
	Fri, 6 Sep 2013 21:29:18 +0200
Content-Disposition: inline
In-Reply-To: <xmqqsixhyhan.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234090>

On Fri, 06 Sep 2013 10:46:24 +0000, Junio C Hamano wrote:
> Andreas Krey <a.krey@gmx.de> writes:
> 
...
> reason later, on-the-wire format should be prepared to support such
> later enhancement.  I think sending
> 
> 	symref=HEAD:refs/heads/master

Mirco-bikeshed: Should that possibly be

  symref:HEAD=refs/heads/master

as then 'symref:HEAD' is a regular capability key?

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800

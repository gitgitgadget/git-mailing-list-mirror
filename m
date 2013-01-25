From: John Keeping <john@keeping.me.uk>
Subject: Re: What's cooking in git.git (Jan 2013, #08; Tue, 22)
Date: Fri, 25 Jan 2013 09:09:41 +0000
Message-ID: <20130125090941.GU7498@serenity.lan>
References: <7va9s0n8gv.fsf@alter.siamese.dyndns.org>
 <20130122234554.GI7498@serenity.lan>
 <7vobgglpv4.fsf@alter.siamese.dyndns.org>
 <20130123092858.GJ7498@serenity.lan>
 <7vsj5rhlfs.fsf@alter.siamese.dyndns.org>
 <20130123211237.GR7498@serenity.lan>
 <CAEUsAPagzN9wWAsSpBVOv7+ei3fAix407dB0EAUd7q7k7SugPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Eric S. Raymond" <esr@thyrsus.com>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 10:20:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyfST-0006YE-I3
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 10:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588Ab3AYJUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 04:20:01 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:50935 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536Ab3AYJT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 04:19:59 -0500
X-Greylist: delayed 608 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Jan 2013 04:19:59 EST
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 9A266198002;
	Fri, 25 Jan 2013 09:09:50 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bzH+u0D746gX; Fri, 25 Jan 2013 09:09:50 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 8775B198005;
	Fri, 25 Jan 2013 09:09:44 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAEUsAPagzN9wWAsSpBVOv7+ei3fAix407dB0EAUd7q7k7SugPw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214523>

On Thu, Jan 24, 2013 at 10:55:57PM -0600, Chris Rorvick wrote:
> On Wed, Jan 23, 2013 at 3:12 PM, John Keeping <john@keeping.me.uk> wrote:
> > The existing script (git-cvsimport.perl) won't ever work with cvsps-3
> > since features it relies on have been removed.
> 
> Not reporting the ancestry branch seems to be the big one.  Are there
> others?

For some reason I thought the non-fast-export output mode had already
been removed, but now that I check it looks like it's still there just
with a warning that it may be removed in the future.


John

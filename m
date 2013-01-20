From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 0/3] fixup remaining cvsimport tests
Date: Sun, 20 Jan 2013 19:24:12 +0000
Message-ID: <20130120192412.GA7498@serenity.lan>
References: <1357878439-27500-1-git-send-email-chris@rorvick.com>
 <20130120125838.GK31172@serenity.lan>
 <CAEUsAPZKd+mw2iK7nd6rTtB8N+B99ud19FkuSx0HVitNxrxxZA@mail.gmail.com>
 <20130120152857.GM31172@serenity.lan>
 <7vsj5vlm1d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Rorvick <chris@rorvick.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 20:24:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx0Va-0003X1-QK
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 20:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327Ab3ATTYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 14:24:25 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:48404 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259Ab3ATTYY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 14:24:24 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 48C5519800B;
	Sun, 20 Jan 2013 19:24:24 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gjpQgbyzKPHB; Sun, 20 Jan 2013 19:24:23 +0000 (GMT)
Received: from aardwolf.aluminati.org (aardwolf.aluminati.org [10.0.7.189])
	by coyote.aluminati.org (Postfix) with ESMTP id A0882198001;
	Sun, 20 Jan 2013 19:24:23 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by aardwolf.aluminati.org (Postfix) with ESMTP id 7AE03276DFF;
	Sun, 20 Jan 2013 19:24:23 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from aardwolf.aluminati.org ([127.0.0.1])
	by localhost (aardwolf.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yNCKBN3YNhnN; Sun, 20 Jan 2013 19:24:23 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by aardwolf.aluminati.org (Postfix) with ESMTPSA id 01EA7276DFE;
	Sun, 20 Jan 2013 19:24:18 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vsj5vlm1d.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214038>

On Sun, Jan 20, 2013 at 10:57:50AM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
>> On Sun, Jan 20, 2013 at 09:22:03AM -0600, Chris Rorvick wrote:
>>> On Sun, Jan 20, 2013 at 6:58 AM, John Keeping <john@keeping.me.uk> wrote:
>>>> On Thu, Jan 10, 2013 at 10:27:16PM -0600, Chris Rorvick wrote:
>>>>> These patchs apply on top of of Eric Raymond's cvsimport patch.  7 of 15
>>>>> tests in t9600 fail, one of which is fixed w/ a cvsps patch I've sent
>>>>> to Eric (fixes revision map.)
>>>>
>>>> Did you post the fix for the revision map publicly anywhere?
>>> 
>>> It's in Eric's repo and included in version 3.8:
>>> 
>>> https://gitorious.org/cvsps/cvsps/commit/abe81e1775a8959291f629029513d1b7160bbde6
>>
>> Thanks.  For some reason I thought the fix would be to
>> git-cvsimport-3.py.  Obviously I should have read more carefully.
>>
>> Sorry for the noise.
> 
> This is not a noise, though.
> 
> Chris, how would we want to proceed?  I'd prefer at some point to
> see cvsimport-3 to be in sync when the one patched and tested in
> Eric's repository is proven enough.  Will Eric be the gatekeeper, or
> will you be sending patches this way as well?

In this case the patch was to the C portion of cvsps, not the Python
cvs-import, so not relevant for this particular case.

I currently have a set of patches on top of jc/cvsimport-upgrade, which
is slightly out-of-sync with git-cvsimport.py in Eric's cvsps
repository, because I hadn't realised that the latter existed until
about an hour ago.

I haven't decided yet whether to rebase those onto the git-cvsimport.py
in the cvsps repository or send them here to apply on top of
jc/cvsimport-upgrade.  Given that git-cvsimport is a command which has
been around for a while and (although this is a complete re-write) the
aim of these changes is to keep it working as the upstream project
changes, I have a slight preference for keeping git-cvsimport here and
recommending that the copy in the cvsps repository is removed.


John

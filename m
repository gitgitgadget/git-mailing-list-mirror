From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] blame: allow -L n,m to have an m bigger than the file's 
	line count
Date: Wed, 10 Feb 2010 08:37:36 -0500
Message-ID: <76718491002100537h521fcc26gb267ed7cd2b8db6f@mail.gmail.com>
References: <1265786864-5460-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 14:37:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfClE-0007hC-EF
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 14:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963Ab0BJNhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 08:37:38 -0500
Received: from mail-iw0-f185.google.com ([209.85.223.185]:57476 "EHLO
	mail-iw0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753699Ab0BJNhh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 08:37:37 -0500
Received: by iwn15 with SMTP id 15so6640459iwn.19
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 05:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=d9hv18zBgpNvFhPK/Kb0i02Fd8YtjlxFd2Q31j3oCGU=;
        b=Inu/4iszkBudu58GozsGl6M01/M5WNlWdcH9FoKrKRtEikmv5nl0S/yCmpdAh2Ii8Z
         kqR8wF9SC1G4aB6jqpUjxql4o1wjtDUh1OmfRucattxQHEufixCR3A3CcxCrKcufM0Kt
         0GqPOLGcbw1wO5L2EzNiqLYc5tJpohk0NshJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=bLvwKFXI2O8Z/hABhJL3pRF0H5P7NikdtoNG19EVYjsrBqbBhZgTKoCbxKYI6BrCFu
         vNHPnZvSqu7LuQsch3JaiEbeHcAaCzqts0yQ7nC+RTnjphtmfqCM4urBD1Y11XmACha5
         cWcRy/2s1DrNFut3aaw+twXAOjo2td48KKIsk=
Received: by 10.231.161.138 with SMTP id r10mr472182ibx.34.1265809056582; Wed, 
	10 Feb 2010 05:37:36 -0800 (PST)
In-Reply-To: <1265786864-5460-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139511>

On Wed, Feb 10, 2010 at 2:27 AM, Stephen Boyd <bebarino@gmail.com> wrote:
> and get what I want but that isn't very discoverable. If the range is
> greater than the number of lines just truncate the range to go up to
> the end of the file.

I agree this is the right thing to do. I'm working on a patch to
support matching multiple times when given a regex range and made just
that change as well. :-)

j.

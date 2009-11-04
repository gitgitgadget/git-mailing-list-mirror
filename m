From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Allow curl helper to work without a local repository
Date: Wed, 4 Nov 2009 06:32:41 +0100
Message-ID: <fabb9a1e0911032132v5e76e4b6n559169ad43d9f7c0@mail.gmail.com>
References: <alpine.LNX.2.00.0911032149390.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Nov 04 06:33:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5YUd-0006nt-Dm
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 06:33:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbZKDFc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 00:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbZKDFc7
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 00:32:59 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:34244 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbZKDFc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 00:32:59 -0500
Received: by ewy3 with SMTP id 3so2762105ewy.37
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 21:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=wsdoKpoyFRV/oVYUqtt/mIMXBUWirMr1SSAZ+Qrh82M=;
        b=JmtuRNbndbaPLCEjfiHuPnwqIAvoBz3yfTwDt93RsiMOQTPJi8OVx9oKK52O2/izEi
         eG2OCMwRNKr6QR2F1CrSutsdQRU4mTmn2hht/Ud9FV3wFut8Bm4er8fgM9Q8KmVuy3eY
         BaqW6llOYl2t0NLKk9+SDhHIMDQ4CEpdmnamw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=vlYjpHD6RyZtU6miX0RORmlhvwfoN2KXnBYR1A0W8ySyCEAPBWQd3kQMXWI/+pf+T+
         qBJYn/aLY0T3ElllPvtNoYTGuvP0xQzPGhftlKAoLp9savA8Rzm3P9LdnEkkheWWva2t
         CmxuAkyuHnmMwWpP1xc9MWw6xJ2Z93TsZSL8c=
Received: by 10.216.88.65 with SMTP id z43mr429982wee.5.1257312781641; Tue, 03 
	Nov 2009 21:33:01 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.0911032149390.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132036>

Heya,

On Wed, Nov 4, 2009 at 03:52, Daniel Barkalow <barkalow@iabervon.org> wrote:
> This is the simple change to let remote-curl work without a local
> repository for git ls-remote; it leave the transport-helper code assuming
> that all helpers can list without a local repo, which happens to be true
> of this helper, the only one in current git.

Add a capability for it? :P

-- 
Cheers,

Sverre Rabbelier

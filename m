From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] fast-import.c: Silence build warning
Date: Mon, 31 Aug 2009 23:27:05 +0200
Message-ID: <81b0412b0908311427t5b4a24ffg1d7d272669476117@mail.gmail.com>
References: <d2e97e800908310421u7de8ae58o361bd64a026384bf@mail.gmail.com>
	 <fabb9a1e0908310529q4c601a73t671cc2813dfdb1a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Wookey <michaelwookey@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 23:27:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiEPI-0003eJ-3U
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 23:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbZHaV1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 17:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbZHaV1F
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 17:27:05 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:60892 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbZHaV1E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 17:27:04 -0400
Received: by fxm17 with SMTP id 17so3072074fxm.37
        for <git@vger.kernel.org>; Mon, 31 Aug 2009 14:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=n0OAsRMecEyDdb3t+NZ6YoCQio8kxK6acmTwWHneia0=;
        b=WoeHoFC+pUKWBnKBNTAhzVo5hgyG9BE5N44sG/nSynkL4WNzkvVv6/Z4Bcce9uEUGH
         bXQ1MACV/sp80fxIx/jqIZnyAVuRMKUEH/Ha5SDocyMD3zGrVsDI871Twf3+HKFR102p
         /sE3erjAHHRWOGetRA0TyBDsxWD7G8O00THz8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=iec5RDv89wv70ToC34NakRD5/TYy9GjxGhn+/PKNbu2gGemk65J4FpMNGo51uZP9vg
         wSSdyZNKsCkEjTJjWuOt9Hl6xlmW21YibjHcMx3HvjIDKJEjpK+iEe1nMtb7d0ohT7fx
         xzFyPtZGqRI7n2h8xBAOjniYSWr5VenF9y13U=
Received: by 10.204.29.24 with SMTP id o24mr4758129bkc.85.1251754025427; Mon, 
	31 Aug 2009 14:27:05 -0700 (PDT)
In-Reply-To: <fabb9a1e0908310529q4c601a73t671cc2813dfdb1a3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127501>

On Mon, Aug 31, 2009 at 14:29, Sverre Rabbelier<srabbelier@gmail.com> wrote:
> On Mon, Aug 31, 2009 at 04:21, Michael Wookey<michaelwookey@gmail.com> wrote:
>> Provide a dummy variable to keep the compiler happy.
>
> Should we not instead check the value?

Why? It is endp (end of the parsed number) we're interested in.

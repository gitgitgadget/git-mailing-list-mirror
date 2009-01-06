From: "Jike Song" <albcamus@gmail.com>
Subject: Re: How make "git checkout <commit> <file>" *not* alter index?
Date: Tue, 6 Jan 2009 14:17:16 +0800
Message-ID: <df9815e70901052217m3bdb29e4y8f28a1300169c1ea@mail.gmail.com>
References: <20090106051852.GA3278@seberino.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: chris@seberino.org
X-From: git-owner@vger.kernel.org Tue Jan 06 07:18:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK5H1-0001LW-46
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 07:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbZAFGRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 01:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbZAFGRU
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 01:17:20 -0500
Received: from ti-out-0910.google.com ([209.85.142.189]:17566 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbZAFGRT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 01:17:19 -0500
Received: by ti-out-0910.google.com with SMTP id b6so9706219tic.23
        for <git@vger.kernel.org>; Mon, 05 Jan 2009 22:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=6aGgms/MsIZUx96L2ac4ChEq0WPdoarHxUQOgCA5HWc=;
        b=tTFeU2rECVAe1FxPLxn9AKHtLQGj6VT/PCpJaE4D0wuy9bcFs5Odr4fembRs+YRezD
         ICjwU1FllPfPFqgAJLm5L6V76VEhgQ83YyodWKcNlNIPHZ3y3Vau0UP3Uj/dxZ8e+7N2
         6kZ603JUPuUjd7DDv6hn1GsrVR7nFVDSP29Og=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=aqUGrICkts7KNoBAj8ufCzZiIBP0bn+54q/DeXRTXExxIynsocp78uSm1k3kSxQd3J
         w9UUbIhUugosOBWXvWrm3nZgJsqSeGC18Ifj1WYZN7fp2ALns7O3etwSreBBUZD9HUrG
         YPnCsgysNLfWkzoiwzysbfjs98vLYtrMsxD5M=
Received: by 10.110.53.19 with SMTP id b19mr16720765tia.53.1231222637034;
        Mon, 05 Jan 2009 22:17:17 -0800 (PST)
Received: by 10.110.10.20 with HTTP; Mon, 5 Jan 2009 22:17:16 -0800 (PST)
In-Reply-To: <20090106051852.GA3278@seberino.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104637>

On Tue, Jan 6, 2009 at 1:18 PM,  <chris@seberino.org> wrote:
> I want to pull an old version of a file into my local directory and make it
> appear like work I haven't added to index yet...
>
>
> So how modify
>
>
> git checkout <commit> <file>
>
> to do this?

I have a stupid way to do this:

 $ git show v2.6.12:Makefile > Makefile
 $ git diff --cached  /* no outputs */

Ugly but seems work.

-- 
Thanks,
Jike

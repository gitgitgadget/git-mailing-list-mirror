From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 07 May 2010 18:09:08 -0400
Message-ID: <4BE48F84.3050200@gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> 	<cover.1273183206.git.eyvind.bernhardsen@gmail.com> <7v4oijhdsi.fsf@alter.siamese.dyndns.org> 	<alpine.LFD.2.00.1005071007320.901@i5.linux-foundation.org> 	<alpine.LFD.2.00.1005071147460.901@i5.linux-foundation.org> 	<alpine.LFD.2.00.1005071529050.14468@xanadu.home> <m2g32541b131005071236u962d2c73n85d25093d1e048bb@mail.gmail.com> 	<alpine.LFD.2.00.1005071626040.14468@xanadu.home> <n2l32541b131005071400uf90ab0e8se882fce6b3abf522@mail.gmail.com> 	<alpine.LFD.2.00.1005071708090.14468@xanadu.home> <x2j32541b131005071426tb875cc1dtcc26e86d868d2e8b@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	hasan.aljudy@gmail.com, kusmabite@googlemail.com, prohaska@zib.de
To: Avery Pennarun <apenwarr@gmail.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 08 00:09:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAVjV-0003Pi-F0
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 00:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812Ab0EGWJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 18:09:16 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37651 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701Ab0EGWJP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 18:09:15 -0400
Received: by gyg13 with SMTP id 13so930034gyg.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 15:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=qJJ4xrTXdoVe58iIOrDMsuLlW90DxhrFgbdYoc7FqSs=;
        b=F2cFecXRQWyLNiQTQ7PlwTN/ShmnahT9QsZ1ADajXJtdEJZK9vG2P+4/QhJPAtc97P
         NJcin5+ItTxVyYrtSgYd5ACrMUaWxs8tmYn9YTP0Sg3vL9VRL6J0jqOxOFNodhoyGxhd
         a25NxWna3C2YvMqIyO3v5LqWNuQue0sG+ofqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=DG+RKG21cGkf2QOJJaIbZLUIJhyn+NVxNek8JNm4CCEMAId63CeP4iLaiXfpo+pQds
         kle96q9BRcBahIWOveoWqxJYWZjwTASbUlC7L9bMvCKl7zSPt1YqL/vVBwFsa5nPF2Ik
         DigjomyMIvgz4TgEhHrMonTyBAJy3DDqsFKno=
Received: by 10.101.27.8 with SMTP id e8mr1083048anj.186.1273270154961;
        Fri, 07 May 2010 15:09:14 -0700 (PDT)
Received: from [10.0.0.6] (c-24-129-111-166.hsd1.fl.comcast.net [24.129.111.166])
        by mx.google.com with ESMTPS id d39sm24436531anp.0.2010.05.07.15.09.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 May 2010 15:09:14 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <x2j32541b131005071426tb875cc1dtcc26e86d868d2e8b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146608>

Avery Pennarun wrote:
[...]
>     cp .gitconfig .git/config
> 
> Perfectly valid.  Copying the other way might (or might not) result in
> invalid options in .gitconfig, which probably ought to be warned
> about.  But the syntax is obviously identical.
[...]

Which one takes precedence? I *MUST* be able to override a distributed 
.gitconfig/.gitparams/.gitparameters file.

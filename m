From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: using .gitmodule as default (was: git submodule init and redundant data in .gitmodules/.git/config)
Date: Fri, 17 Aug 2007 09:14:45 +0200
Message-ID: <8c5c35580708170014i5af2da62w1dbcbad71430e26@mail.gmail.com>
References: <20070815162005.GA18463@piper.oerlikon.madduck.net>
	 <20070815163822.GC1070MdfPADPa@greensroom.kotnet.org>
	 <20070815222907.GA7395@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "martin f krafft" <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Fri Aug 17 09:15:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILw32-00007m-OD
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 09:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756027AbXHQHOs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 03:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755697AbXHQHOs
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 03:14:48 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:26381 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756553AbXHQHOq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 03:14:46 -0400
Received: by wa-out-1112.google.com with SMTP id j4so147434wah
        for <git@vger.kernel.org>; Fri, 17 Aug 2007 00:14:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NkruuPPoSSJELSgbKqOSOGkUb9VECCrm2Jmwb58saYcjJa1x0RgiyQtxAXxqozCO+cd7DANIVXQkC/YQfENtbq00ohuXzpcnCvepKX4P1m26NZ95iVC3Ej/0UyWNoKw1m+/tQWWXrqNXDIw4cFY/y3+nP8ImmEPFKhW/hj79Jew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xu2GsT4IWMFYdm62l/HdMEwF0mN+xQMtDZYwlGQFVnYrwxM6AccahE3T039mNYTo2hRYEcuA2nkI4KGG8a5rhO9enaoZ/jY+Ut21wXycAj1qKzT03o9VAkfnhvP5J43il/XU5OXqJA/ehLuvsVtztIlwjaebQfrN2zWspOQw2zI=
Received: by 10.114.204.7 with SMTP id b7mr818833wag.1187334885919;
        Fri, 17 Aug 2007 00:14:45 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Fri, 17 Aug 2007 00:14:45 -0700 (PDT)
In-Reply-To: <20070815222907.GA7395@piper.oerlikon.madduck.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56047>

On 8/16/07, martin f krafft <madduck@madduck.net> wrote:
> I have one open question though: why require init?

The purpose of 'init' is to inform git-submodule about which
submodules you want to checkout. E.g. for a project with submodules in
directories 'a', 'b' and 'c', you could do

$ git submodule init b c
$ git submodule update

This would only fetch/checkout the submodules in direcotories 'b' and
'c', while 'git submodule status' would still inform you that there is
actually three submodules available.

Note: If you wanted to initialize all three submodules at once, you
could simply do

$ git submodule init

--
larsh

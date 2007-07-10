From: "Henning Rogge" <hrogge@googlemail.com>
Subject: Re: [WIP] Get rid of msys in favor of busybox port for windows
Date: Tue, 10 Jul 2007 17:56:32 +0200
Message-ID: <87eacd830707100856l3132bee2k45b8d59ac1875d89@mail.gmail.com>
References: <fcaeb9bf0707100832j3c2ff076gab5c9bd4f9d3f4a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 17:56:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8I4q-0001UO-HP
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 17:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705AbXGJP4e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 11:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753093AbXGJP4e
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 11:56:34 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:19666 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110AbXGJP4d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 11:56:33 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1259072wxd
        for <git@vger.kernel.org>; Tue, 10 Jul 2007 08:56:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kSFiV5K9qnhrYl6X2nrCM64612514NB70M0ct3zkJkP1iQ4XU6NtSKvK3+uO1tTIyN8KZMl2siiOL7JZG9HUqNgZOskiYCasDFZQVvUIbuj7yz1F9tkI9va2yXJQJHNH2Wki9sb2DUzYiM1CixJpTF9veqkR81GhGZCbunQjwgU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U5bggHc9Surhj+Wl6nOSiSwHmFBXI1/7x7tiWzRCe3UVlpTpeDAckoRu8wbyi8e8aDgFie1idq882Ks+5pTbwvU9ahtV/rezLdmfJ2WTQH9ucOOy8tSMggwnQpYwjRpSvlANo55b8GulXUtTknH9z4b/ZoyJqjHW/pOSSoQ18Cs=
Received: by 10.90.83.14 with SMTP id g14mr3084936agb.1184082992830;
        Tue, 10 Jul 2007 08:56:32 -0700 (PDT)
Received: by 10.90.28.16 with HTTP; Tue, 10 Jul 2007 08:56:32 -0700 (PDT)
In-Reply-To: <fcaeb9bf0707100832j3c2ff076gab5c9bd4f9d3f4a0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52087>

On 7/10/07, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> I'm integrating some code from busybox to mingw tree so that mingw
> port can work without msys. Posix utilities such as sed, awk, head,
> tail... seem to work well. The main obstacle is ash, which is no where
> near usable state (fork issues as always). Busybox ash is about 13000
> lines of code, not too big.
>
> Anyone interested in?
If I can use it without needing a "vi/vim" implementation I'm interested !

Henning

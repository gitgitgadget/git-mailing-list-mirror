From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git ls-files -o under .git/ prints all repository files
Date: Fri, 19 Jan 2007 08:57:58 +0100
Message-ID: <81b0412b0701182357l3a6d44fel58da50c7895fb6b4@mail.gmail.com>
References: <87r6trsu7n.wl@mail2.atmark-techno.com>
	 <7vwt3jjywc.fsf@assigned-by-dhcp.cox.net>
	 <45B07875.9030506@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Yasushi SHOJI" <yashi@atmark-techno.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 08:58:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7odR-0003er-Kt
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 08:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbXASH6C (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 02:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbXASH6C
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 02:58:02 -0500
Received: from hu-out-0506.google.com ([72.14.214.232]:50548 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964924AbXASH6A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 02:58:00 -0500
Received: by hu-out-0506.google.com with SMTP id 36so385044hui
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 23:57:58 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SYjiGcsSRPvutaligOaDblqqlJ/TDMBVcWsiPy1NxM947XMXqjVAU+VgRDQ+LHZO0dd8ASg5FLpLp+a/RgcleHe1iIBZdlrrKt7kv+BfRryy4Q849Dyq6scZwlGlRDBZw0uuX4SVnNcWvcgeWxot+OrZ1wvzVHxSj1Oca3wRC/E=
Received: by 10.78.172.20 with SMTP id u20mr40066hue.1169193478484;
        Thu, 18 Jan 2007 23:57:58 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Thu, 18 Jan 2007 23:57:58 -0800 (PST)
To: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>
In-Reply-To: <45B07875.9030506@fs.ei.tum.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37158>

On 1/19/07, Simon 'corecode' Schubert <corecode@fs.ei.tum.de> wrote:
> >
> > Amusing problems deserve an equally amusing solution.
>
> I guess you are not serious.  I wonder, why does git-ls-files ever
> list files under .git?  I'd just say:  fail if you want to list $GIT_DIR.

Not list. Clean. What's wrong with listing them?

>  Maybe other tools should do so as well.
>
> % cd .hg && hg status -A .
> abort: path contains illegal component: .hg
>
> I think this is a sensible thing to do.

No, it isn't. It is not unlikely to have repo in repo
(and some people already have them).
Mercurial is wrong here.

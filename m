From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Sat, 24 Apr 2010 17:42:42 -0500
Message-ID: <20100424224242.GA8325@progeny.tock>
References: <alpine.LFD.2.00.1004221445310.7232@xanadu.home>
 <87sk6n4426.fsf@frosties.localdomain>
 <alpine.LFD.2.00.1004221651590.7232@xanadu.home>
 <87vdbitu9v.fsf@frosties.localdomain>
 <25441792-181D-456D-8182-F33B49209EFF@wincent.com>
 <87aastx6sa.fsf@frosties.localdomain>
 <alpine.LFD.2.00.1004231639180.7232@xanadu.home>
 <8739yktuvs.fsf@frosties.localdomain>
 <20100424214024.GA8044@progeny.tock>
 <87tyr0sdv8.fsf@frosties.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Goswin von Brederlow <goswin-v-b@web.de>
X-From: git-owner@vger.kernel.org Sun Apr 25 00:42:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5o3F-0005jh-Uu
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 00:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214Ab0DXWmL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Apr 2010 18:42:11 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50189 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993Ab0DXWmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 18:42:09 -0400
Received: by gwj19 with SMTP id 19so3324653gwj.19
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 15:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=PswCva/FKmrAHxoI9eOmoHsUHvwS+gVGHgLDYT6fCSg=;
        b=yDhnOkxOPPN061TUNlFFv4Z7Womut94mL2Rd3ieA1VCLvQmzSOeDl8LSnhMmE8Nz4Q
         9lncA4zfuT+G2RMcsuWyblG3KmPO3ZEtUsPCUP/bdsOOGG4tcQ223wtWzUsWs/ehCdYU
         esuhwqYk56q5kjAySUVFB3AHCJ/C3CnF2z8Nc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=PaH9RsA6JSJQXOisl9I4FocXWIui44yJkN5EC8NxcY/kiuvqg4drgmyLu0y97N2Y9W
         AdqkBLJHWt2L1T5gz3oTJG4Bx385AJG7w2VCUQo2wPaRhwqJazQGCFEh3kxSeZx1xw8M
         qsurlqFzEA0xiRw5j4OfGgCDd3yXAuuBsGTgo=
Received: by 10.151.59.19 with SMTP id m19mr2209856ybk.56.1272148926363;
        Sat, 24 Apr 2010 15:42:06 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm1831746iwn.9.2010.04.24.15.42.05
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Apr 2010 15:42:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87tyr0sdv8.fsf@frosties.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145708>

Goswin von Brederlow wrote:

> Must have overlooked that mail, sorry.

No problem.  Sorry for my impatience with the long thread.  Out of
this discussion there have already emerged two ideas I like a lot:

 1. a more noticeable safety for =E2=80=98git commit=E2=80=99 with no s=
taged changes
 2. Jakub=E2=80=99s safety for =E2=80=98git commit -a=E2=80=99 with sta=
ged changes

Thanks.

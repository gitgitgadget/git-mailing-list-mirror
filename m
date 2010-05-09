From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control
 end-of-line conversion
Date: Sun, 9 May 2010 11:00:43 +0400
Message-ID: <20100509070043.GB14069@dpotapov.dyndns.org>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com>
 <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com>
 <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org>
 <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com>
 <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 09 09:01:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OB0VZ-00032V-4V
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 09:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463Ab0EIHAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 03:00:49 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53597 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039Ab0EIHAs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 03:00:48 -0400
Received: by fxm10 with SMTP id 10so1606984fxm.19
        for <git@vger.kernel.org>; Sun, 09 May 2010 00:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PaUuM8SDiQ4J3x/naS6+fG+88jYJst6ZG7PoPANMcTg=;
        b=FeMD0MSxAogwWL3UNTTe1IJMgW3iIcJR9g2sf2R0MZCOZ+spoSIlSzWS595gmMOTuK
         BLVw444OAPqN7F7+MD1VEc+D8LgQPhiuCW6R6/rHKsXFX5lrhl7NQIvhPQv1xcpw+lyk
         G8L8pyk+4yV5+Y8rln6ed2zYBVwMdRVdukhvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=t2AULHizINqv6aDiD+CxdFQye2rFe0GT+ZJ1N93nf8Gs2hLCHyKjGWxyLFAMPpHnli
         YNWQoR4mIQ78QtuxY14XeI0uzLif37LinOGpWuD91a59679ryQOwqTNqauM63J6g9l1Y
         4dBAZkjI4RrypuowwsXm+5owFwklLvZoLIWmw=
Received: by 10.102.165.40 with SMTP id n40mr1229840mue.71.1273388446237;
        Sun, 09 May 2010 00:00:46 -0700 (PDT)
Received: from localhost (ppp85-141-234-94.pppoe.mtu-net.ru [85.141.234.94])
        by mx.google.com with ESMTPS id e8sm14873787muf.39.2010.05.09.00.00.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 May 2010 00:00:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146706>

On Sun, May 09, 2010 at 12:53:17AM +0200, Eyvind Bernhardsen wrote:
> On 9. mai 2010, at 00.17, Eyvind Bernhardsen
> <eyvind.bernhardsen@gmail.com> wrote:
> 
> >I'll try to think of a better name.
> 
> Heh. How about "localcrlf={true,false,native}"?

IMHO, the 'local' prefix certainly does not improve anything. Also,
I would rather call default as "default" instead of "native". So,
why not use "core.crlf={true, false, default}"?

Though crlf is not my preferable name, I think consistency is important,
and we should use the same name here as in git attributes.


Dmitry

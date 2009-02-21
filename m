From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: whitespace checking in git-add?
Date: Sat, 21 Feb 2009 20:40:41 +0100
Message-ID: <fabb9a1e0902211140l7f3671bt2d175f36300ded7b@mail.gmail.com>
References: <20090220230454.GA10112@foursquare.net>
	 <alpine.LFD.2.00.0902202109010.5511@xanadu.home>
	 <fabb9a1e0902210321k6bdd8726jea7c930a5a61cce5@mail.gmail.com>
	 <alpine.LFD.2.00.0902211424490.5511@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Chris Frey <cdfrey@foursquare.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Feb 21 20:42:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Laxjs-0001ul-Gt
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 20:42:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbZBUTkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 14:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752793AbZBUTkp
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 14:40:45 -0500
Received: from mu-out-0910.google.com ([209.85.134.191]:35165 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbZBUTkp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 14:40:45 -0500
Received: by mu-out-0910.google.com with SMTP id i10so932921mue.1
        for <git@vger.kernel.org>; Sat, 21 Feb 2009 11:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jhshpcH6uo3pfIlU6i/RHB1tuRU58Ge1gO6ee0vpIMQ=;
        b=wXxoxguT1uPlJmY65/VkcdoD4l0e3EQbdLdQrtuQm9Ecgrwuylx0XAuVseGoQlvnOD
         HsXw60DlkrIwkJs5qSTD/V5sn71xT/UjqmPLX1TmfQX96cPGYRQG7mLZgW1v5GQmxH+J
         Hn9tnd2aQn+7jUzVgo5YJCq7bt/bH96eH3ykk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cNR5I3QjXipTERndedGe53UoLHF3FqeShhm4PJPpddzAFCCSZVt+X5zM0uS08Hi/UF
         GOxmkn06rg+1HAi4L2jw9I3ab6VwjeoWjCzglp7DDNNymYrdsALYY7kIzD9ztF4LKRQW
         g20d3TcLU6SwazOZkoOW1SViTbN4WKDDatgsI=
Received: by 10.103.214.8 with SMTP id r8mr2507732muq.6.1235245241808; Sat, 21 
	Feb 2009 11:40:41 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0902211424490.5511@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110977>

Heya,

On Sat, Feb 21, 2009 at 20:26, Nicolas Pitre <nico@cam.org> wrote:
> On Sat, 21 Feb 2009, Sverre Rabbelier wrote:
>> On Sat, Feb 21, 2009 at 03:14, Nicolas Pitre <nico@cam.org> wrote:
>> >  2) run 'git rebase -f --whitespace=fix HEAD~'
>>
>> Thanks for the plug ;), but you should note that that only works on a
>> very recent git. It's not even in master yet, according to [0] it's
>> been in next for only 7 days.
>
> Oh, OK...  Still better than a non existing feature.

That's true :). Btw, it's also possible to do:
$ git rebase --whitespace=fix HEAD~

The --whitespace=fix will automagically turn on the -f :).

-- 
Cheers,

Sverre Rabbelier

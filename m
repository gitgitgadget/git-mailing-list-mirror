From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: Re: git+http:// proof-of-concept (not using CONNECT)
Date: Thu, 2 Jul 2009 13:52:22 +0400
Message-ID: <85647ef50907020252u41e36187jaacacad3d8a10f75@mail.gmail.com>
References: <20090702085440.GC11119@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jul 02 11:52:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMIxz-0002Pd-Vs
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 11:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693AbZGBJwW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jul 2009 05:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752623AbZGBJwV
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 05:52:21 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:37016 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbZGBJwU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jul 2009 05:52:20 -0400
Received: by ewy6 with SMTP id 6so1934675ewy.37
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 02:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oNHhI2F0eDxQBie5PnHTDb9DEIaOqLbE3RadjErG8XQ=;
        b=ROYVHiLqBk7HEwEeQSm5A0bnqQRaBVHuSfVSYTB5e2MihcOJL6at3xFHsvXSGNriiu
         eA8sOj0kqqhHRtq50CIYxOQ7xWQgzvsTNGg5hUK+WB2HBh3NCC0CLfWRLLRuF/cL3YFW
         NnYEbzDqjKcgCUv24yonXylCex7tlHbWHTSV4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VPPARY+MPJdkp4I+LWu8gudj5RSbGQPiqi40NKjf3y6++tROlb7m7hxkIszWJs16YI
         DISRlgjcdDf6X8k8pSCCPkqIGCGQnR9YxZApSWusaLv2Or2yhhfv0UDQQ4k2DSb5lC8D
         cwJtoZO/KkGQsfun9sK2C4yz0FpCPkq1omdW0=
Received: by 10.216.26.70 with SMTP id b48mr3133411wea.141.1246528342909; Thu, 
	02 Jul 2009 02:52:22 -0700 (PDT)
In-Reply-To: <20090702085440.GC11119@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122632>

On Thu, Jul 2, 2009 at 12:54 PM, Eric Wong<normalperson@yhbt.net> wrote=
:
> This doesn't work in the face of most HTTP-aware proxies[1], so it
> probably doesn't help those who have trouble accessing git:// servers=
 in
> the first place... =A0However, this could potentially be useful in pl=
aces
> where a proxy providing CONNECT is not available.
>
The current lore is that to work with http proxies two separate
streams are needed,
one for input and one for outputs.

This technique is described at
http://xmpp.org/extensions/xep-0124.html#technique
and other places.

Regards,
Constantine

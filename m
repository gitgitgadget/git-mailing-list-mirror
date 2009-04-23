From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Wait for git diff to finish in git difftool
Date: Thu, 23 Apr 2009 09:33:48 +0200
Message-ID: <81b0412b0904230033n35f1117fmea4432a2f2140d25@mail.gmail.com>
References: <81b0412b0904220027t7afd1ed7xc57c479ef8cdb6b9@mail.gmail.com>
	 <20090422082652.GA32698@gmail.com>
	 <81b0412b0904220404o30ce1413kcc4dcea1fa822841@mail.gmail.com>
	 <7vr5zk346d.fsf@gitster.siamese.dyndns.org>
	 <81b0412b0904221340o6b2f1474oed2ad12e4f68cff3@mail.gmail.com>
	 <7v4owgyp8x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	charles@hashpling.org, markus.heidelberg@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 09:35:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwtTP-0000wK-3L
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 09:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253AbZDWHdx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Apr 2009 03:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757329AbZDWHdw
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 03:33:52 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:56507 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757338AbZDWHdu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2009 03:33:50 -0400
Received: by yx-out-2324.google.com with SMTP id 3so258494yxj.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 00:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qPaOkEvm7ZaiwWDjSfH6bN1Zv3sA5eHfWUieRY3X3tc=;
        b=CiKQuNfHtI3LeNmEaaTS/IGJ7suiJ6gcCCzTHoZFwh8wX+2SDCno+hgBdIwZmxYXPe
         l6nXJ7XKhv/xdEy6HAXCzbcC3eNt2mEOiqltztKE5iIHwsYxrMY8IIiRPK49FKtaQgAx
         DAivH7MbtGDVxrR+z93fJeViH1WBv40peoLOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=W7tmpiOwckiHF/06Ax90p++eWmDiWg4ki2SROfApQebXB1CO6yLJ3F8a+6uUfbUNBg
         GVUKfQe+Bmxys3jC7AE63wKxtCM0Orn7wQh3/NU8HYxLQVrNOre3aAIRDhJI/aSKOWb8
         p6u6a5o3/dwUJJ9jYylg8EMNkDtu7lXHmktDk=
Received: by 10.151.139.9 with SMTP id r9mr188771ybn.184.1240472028311; Thu, 
	23 Apr 2009 00:33:48 -0700 (PDT)
In-Reply-To: <7v4owgyp8x.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117305>

2009/4/23 Junio C Hamano <gitster@pobox.com>:
> Alex Riesen <raa.lkml@gmail.com> writes:
>> Frankly, I just always forget about it. The patches to my windows
>> repository are mostly just hacks to either make it pass test suite o=
r
>> workaround another, the platforms specific, stupidity. Not sure anyo=
ne
>> is actually interested in them (because, I repeat, they mostly hurt
>> everyone else, while making the platforms port "a little working").
>
> What do you really mean? =C2=A0These patches add maintenance burden b=
ut its
> benefit nobody would care about, and should not be applied?

Maintenance _and_ run-time. It is your decision, but yes, I kind of hat=
e
the idea of them being applied.

In plain words: please don't apply MY patches with words "Windows"
or "Cygwin" in message body, unless I beg you to (and even then,
consider me heavily drugged).

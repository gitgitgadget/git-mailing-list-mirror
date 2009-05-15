From: John Tapsell <johnflux@gmail.com>
Subject: Re: [PATCH] Showing stash state in bash prompt
Date: Fri, 15 May 2009 09:39:18 +0300
Message-ID: <43d8ce650905142339p266c2f0fye1174036d6251ed0@mail.gmail.com>
References: <20090513094448.GC2106@bug.science-computing.de>
	 <20090513112535.GD2106@bug.science-computing.de>
	 <7v4ovo4xyt.fsf@alter.siamese.dyndns.org>
	 <200905142025.02592.trast@student.ethz.ch>
	 <buo1vqrqj2n.fsf@dhlpc061.dev.necel.com>
	 <20090515021105.GA19241@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Miles Bader <miles@gnu.org>, Thomas Rast <trast@student.ethz.ch>,
	Daniel Trstenjak <Daniel.Trstenjak@science-computing.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	spearce@spearce.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 15 08:40:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4r61-00084S-TY
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 08:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057AbZEOGjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 02:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbZEOGjS
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 02:39:18 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:60502 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbZEOGjS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 02:39:18 -0400
Received: by gxk10 with SMTP id 10so3379562gxk.13
        for <git@vger.kernel.org>; Thu, 14 May 2009 23:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dlP+Z4dry3mA2DasM6pHnStp8vFupwQTpIr7oF9OxBw=;
        b=Y86glT3Ti2BJxxvhNnDd1liH++a0olaUrgZkOFqFDpdxHndUGTNJo2FW0jqDyUmT/+
         /FYYskJYE1pR/zMGuH2PfPf3ytDG9NIF0xXqRYLD3SpDqJp82utH+Tfr1P1exLBfT3Tr
         wPuIslPmAxokgJY0PqdsF+xjbyShm7BgSckuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NonKXl7/Y+TEI9hvALoZHAIlUd5sCDTFHYXIdtsSUb213/E2QDJV8qg5AZBxD2gjBa
         qDTc3ias79dBTOPFlwaMrLmOde0P0oKFXbgSN4fAF/tsRbqGxpJboHOSj/R0660DC+R9
         LAcVGDgECZ8q0Ue7UTE08b1hINskFtBGLmvJs=
Received: by 10.151.73.4 with SMTP id a4mr5357475ybl.108.1242369558582; Thu, 
	14 May 2009 23:39:18 -0700 (PDT)
In-Reply-To: <20090515021105.GA19241@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119248>

>> I'd often end up in a situation where I'd lose track of whether I had
>> done a stash apply or not, and the risk of inadvertently doing a drop

While we're on this - would anyone else like to see a "git unstash" as
an alias to "git stash apply" ?
For me it seems more natural to be able to do :

git stash
something
git unstash

From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: how do I resolve this merge manually + mergetool bug
Date: Tue, 24 Feb 2009 02:19:32 -0500
Message-ID: <81bfc67a0902232319t7525e3b3n74b667257024800b@mail.gmail.com>
References: <81bfc67a0902232204y7a1e9a91x6cbf751319664734@mail.gmail.com>
	 <7vbpssmjm9.fsf@gitster.siamese.dyndns.org>
	 <81bfc67a0902232252h56570308r22872854af8da54a@mail.gmail.com>
	 <7vr61ol2yn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 08:21:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbrbD-00083i-Do
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 08:21:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631AbZBXHTg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 02:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752889AbZBXHTf
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 02:19:35 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:32127 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360AbZBXHTf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 02:19:35 -0500
Received: by qw-out-2122.google.com with SMTP id 5so1675224qwi.37
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 23:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AFkKRTMGIy21kekJg88nk84A83SSJbUOIC2PJ6ODWUI=;
        b=k0ewEEx+nSjLGY1bn+7SDqA4ubHAAdVsDoDfEtHvjfn+BkQ+CAdSmq/bn+7e5Dyfst
         03zPbnAzTIjf5PEm9PULxywrQSuGAp+V+K5jc5SlwLjfWcAqisNPOiGqoJcxZPB9ijWc
         lh06eiyJaa7kEqn587S+r5L5+UDNSKPe2QAG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eIS6lF0peMt/MZ3B/7F+SiZQ/qsTTGKDuO3KYk3ehXPRGI1XW/UDH2lSOFuD5u78HQ
         LITSM13mceFwjnOfGcjT+qJ1n/DfFzVXBcmph+uCl27yor4OyLTGKa10xoXWF7z0FcQl
         J+ObUrx1ZbhXbYOFatkz7KHjEU1eMuk1Yb+Jg=
Received: by 10.229.85.14 with SMTP id m14mr1755190qcl.64.1235459972527; Mon, 
	23 Feb 2009 23:19:32 -0800 (PST)
In-Reply-To: <7vr61ol2yn.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111232>

On Tue, Feb 24, 2009 at 2:16 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> "git update-index --force-remove profiles/package.mask" should work
> better. =C2=A0I tend to trust plumbing a lot more than Porcelain for =
these
> corner cases.

works. awesome! thanks for the help, I've been banging my head against
how to do this (without pain++ ) for a couple of days.
--=20
Caleb Cushing

http://xenoterracide.blogspot.com

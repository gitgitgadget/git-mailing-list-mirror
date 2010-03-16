From: Miles Bader <miles@gnu.org>
Subject: Re: FEATURE REQUEST: Comment assignment on branches
Date: Tue, 16 Mar 2010 15:20:54 +0900
Message-ID: <fc339e4a1003152320i12a7d4b2p711f6b5d0eda9bcd@mail.gmail.com>
References: <be8f531d1003150133n3ea64109u7d573dbd533ffa48@mail.gmail.com> 
	<20100315213221.GA12941@vidovic> <7vhbohi80n.fsf@alter.siamese.dyndns.org> 
	<buovdcw6fjj.fsf@dhlpc061.dev.necel.com> <7vljdsu7kc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Maxim Treskin <zerthurd@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 07:21:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrQ9Z-0002CF-JO
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 07:21:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965994Ab0CPGVQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Mar 2010 02:21:16 -0400
Received: from mail-iw0-f176.google.com ([209.85.223.176]:41908 "EHLO
	mail-iw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965551Ab0CPGVO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Mar 2010 02:21:14 -0400
Received: by iwn6 with SMTP id 6so676774iwn.4
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 23:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=wZZdw8fEeNjuwkF5yRQIAR6h5S824x7ct92n/UR9tXw=;
        b=yCTmbFHXLtnbR7MwV5FN3UB9wDOxb41e3aVtXtfaGAXlc/ouByk1okjuZ0x5v44wcV
         LKYzxWIzly7X/PY+Mmizm5YrFLZVgjFSID27Wt25TrkEMivEDBuqJGPPzVIdRR0M4kMJ
         nPVkQUNZ5NJUFnTFEjI4SmVlwXylgKI0pnszE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=XaZOhVpZqEG/ZL7yTnYuIhSuFhk0AH1jHOQYHh01EH3ZluxqNzuZ9fec+YhB0RbZxW
         qmN1hdtd6LPbneJUhVXzrIMGxhouR87sqSz4OeO6Oo8B+L5dyTVjoK0Bl3iEPWrK14HA
         Q2eMUx9Icbmvd4LEqYFxh8DtBO8zlXjOn/RbU=
Received: by 10.231.167.135 with SMTP id q7mr289259iby.84.1268720474184; Mon, 
	15 Mar 2010 23:21:14 -0700 (PDT)
In-Reply-To: <7vljdsu7kc.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: ad1554a9208fbc40
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142321>

On Tue, Mar 16, 2010 at 3:03 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> This would seem especially useful for publicly visible branches...
>
> If you mean by "publicly visible" branches in public repositories, I
> suspect not. =A0At places like repo.or.cz, github, or installations m=
anaged
> by gitosis, you typically do not have direct access to $GIT_DIR/confi=
g
> files (they belong to site administrators) in your repositories, and =
that
> is not likely to change for security reasons.

Hm, ok you're right... which is a shame... :(

'cause a "pushable branch description" would be ace!

[I take it git has no "limited remote metadata change" function...?]

-Miles

--=20
Do not taunt Happy Fun Ball.

From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 4/7] t/t5503-tagfollow: change from skip_all=* to prereq 
	skip
Date: Wed, 11 Aug 2010 18:47:07 +0000
Message-ID: <AANLkTimcft23Tbe9=iFPvNyf6Goyk6jBQ1XCzsQJeNtv@mail.gmail.com>
References: <1281469968-25670-1-git-send-email-avarab@gmail.com>
	<1281469968-25670-5-git-send-email-avarab@gmail.com>
	<7vtyn1xaom.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 20:47:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjGKZ-0001R0-S4
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 20:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755530Ab0HKSrK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 14:47:10 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55771 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754982Ab0HKSrJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 14:47:09 -0400
Received: by fxm13 with SMTP id 13so346249fxm.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 11:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5T7AenGnuZNmHFpKxmhlw+CzDrx3CKgX74Txh0cQ7Uc=;
        b=nh2jshk+eahCuvRreUXd4LgVUN45KogQ9oy/y7UYevqXbk1q5dszrWhnQA/XIlQDEw
         H5g+D6BZYElQxqwU26ugZGTj/rp++KidBeQefEzJKxLnbChICudlJoWeg6NdFErZjEFn
         DWm7ls1VdPRUn+mgqRoe/7pXEC98ArKF/EzfI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JPH5E7Jmv5PLlhgrZXVRPSEOkuX8zrmoWLhVr/TxCFckYsrJHVVc7d50CXx46LaiZN
         foWNuSk6FKo8P3KVg3Ql8Q5WI3M5lCVxWMma2c7NThgDLi61obe3D1kCLaSnJeIkmbne
         ISSWCpC0LT83NRFMENp9xIVO/9aqyO+tsmhE8=
Received: by 10.223.119.198 with SMTP id a6mr20602314far.66.1281552428056; 
	Wed, 11 Aug 2010 11:47:08 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Wed, 11 Aug 2010 11:47:07 -0700 (PDT)
In-Reply-To: <7vtyn1xaom.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153280>

On Wed, Aug 11, 2010 at 18:32, Junio C Hamano <gitster@pobox.com> wrote=
:
> To =C3=86var; isn't the prerequisite for these tests "does our git su=
pport send
> pack debugging?" not "are we not running on mingw?" =C2=A0Let's call =
it
> DEBUG_SEND_PACK or something.

I have no idea, sorry. I was just changing the way we do skips. I
don't have access to a Windows system, and I don't know if this skip
should be uname -s based.

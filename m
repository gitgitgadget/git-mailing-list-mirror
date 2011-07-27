From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 18/18] revert: Introduce --continue to continue the operation
Date: Wed, 27 Jul 2011 15:06:14 +0530
Message-ID: <CALkWK0nX5GsfGi9ifxkfvoZWxVzFKBs8X60Svda0rQWKzz0aww@mail.gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-19-git-send-email-artagnon@gmail.com> <20110727052211.GM18470@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 11:36:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm0Xn-0001NO-Ql
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 11:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754059Ab1G0Jgh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jul 2011 05:36:37 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44035 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754454Ab1G0Jgf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2011 05:36:35 -0400
Received: by wwe5 with SMTP id 5so1217013wwe.1
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 02:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=UxJBDIXPLOjKSokT6JoMPUIsgdNtDVQWx/coGp0yF90=;
        b=hF/SD5tJyH3FB5TXIS9Yp06myLoEeInHARWErJffAVkTg6v0g9HXvHF6SbPL6u73JP
         CsN5ruqc05SN4rCFkNkv/apPH09PsIMHcuGt0xYLn9RBftqjYUGB/FK5cA15WazUFgXM
         mOtJKZt3yWSKdE82JP2A0VqiQ4GN9w00uYgxc=
Received: by 10.216.70.14 with SMTP id o14mr6358398wed.111.1311759394068; Wed,
 27 Jul 2011 02:36:34 -0700 (PDT)
Received: by 10.216.70.16 with HTTP; Wed, 27 Jul 2011 02:36:14 -0700 (PDT)
In-Reply-To: <20110727052211.GM18470@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177952>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> during commit time. =C2=A0One glitch to note is that the "--signoff"=
 option
>> specified at cherry-pick invocation time is not reflected in the
>> commit message provided by CHERRY_PICK_HEAD; the user must take care
>> to add "--signoff" during the "git commit" invocation.
>
> Does this reflect the previous discussion of whether this is a glitch
> or an intentional behavior?

The previous discussion thread for your reference [1] -- I thought we
agreed that it was a glitch.  Neither of us can find any traces of it
being intentional, and the commit that introduced this option doesn't
say this: v1.5.6-rc0~83^2 (Allow cherry-pick (and revert) to add
signoff line, 2008-04-26).

[1]: http://thread.gmane.org/gmane.comp.version-control.git/176855/

-- Ram

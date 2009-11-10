From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH 6/8] builtin-fetch: add --prune option
Date: Tue, 10 Nov 2009 10:43:15 +0100
Message-ID: <6672d0160911100143r3967d080t1a31906a99440d8d@mail.gmail.com>
References: <4AF92133.6070005@gmail.com>
	 <7vfx8mg3mw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 10:43:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7nFz-0008Py-F9
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 10:43:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755723AbZKJJnM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Nov 2009 04:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755613AbZKJJnM
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 04:43:12 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:45142 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755594AbZKJJnL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Nov 2009 04:43:11 -0500
Received: by bwz27 with SMTP id 27so4334466bwz.21
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 01:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=v6gLradlitoBBVAbaGaw+/SKWFPAWw3r4N7LzNjzj+U=;
        b=kLlu9a2YmeGUT9v2AVD+s9BJcC8Ms4S9/j5L7C6Cqzwhj0hvTBIaUtaSBfD1CCe6t6
         zhvZvtx/eZqp8I7d42zz5b/Mhz7FxKUlosRnTjqKwvbEYod4lHE1385QZM/IX8AwTWIr
         EPtf3S6YF04/qy4z3oH4hKFzk7gqf7utdDO3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BD3kdPCyuxVbzv7x2tHfaujRSZbpwTO5vqicX5sjml6ZiLS7Z/F220EofPlKmJID2d
         LYuLMxcoy/8zgw/vdszHSOBb56cRBgCbsTjrwcrxmBIYl4wBBp9KFzG0j3r/22tbQUdT
         1bQn8Uux14n0foEjocJ4WvjscVoF4AoeY8vhs=
Received: by 10.204.148.85 with SMTP id o21mr2346891bkv.134.1257846196012; 
	Tue, 10 Nov 2009 01:43:16 -0800 (PST)
In-Reply-To: <7vfx8mg3mw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132556>

2009/11/10 Junio C Hamano <gitster@pobox.com>:
> Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com> writes:
>
>> From: Jay Soffian <jaysoffian@gmail.com>
>
> Thanks for being careful; it would be even better if you preserve the
> author date by copying Date: from the original.

Thanks for the tip! Will do that next time.

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB

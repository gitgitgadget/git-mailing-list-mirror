From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/7] sequencer: handle single-commit pick as special case
Date: Tue, 15 Nov 2011 14:17:08 +0530
Message-ID: <CALkWK0krTY+szqPrE9wxwfK76VBbFXh_Xaz8EyWZayLa_SFQTw@mail.gmail.com>
References: <1321181181-23923-1-git-send-email-artagnon@gmail.com>
 <1321181181-23923-4-git-send-email-artagnon@gmail.com> <7vpqgvmwtl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 09:47:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQEgA-0005vj-KK
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 09:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181Ab1KOIrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 03:47:33 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57931 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754267Ab1KOIrb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 03:47:31 -0500
Received: by wyh15 with SMTP id 15so6770265wyh.19
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 00:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eCH51zv9180hOk5xweCJ/3i9MOdQL9bTjI838gVrBe0=;
        b=O3gxqqsXSz7sW7zoA9cj0sPy9bwdUFtdr2gNi7GaZiRYy6QVtACm+wk3QIsPGgy3rt
         QMPbg4fH4EptDlvRM86iRpxI/wfLMC+hd45oTU/gA1Ouo9JcBzlScObnTxVsIpm7DTsK
         K3y0jc3GZmhJ6ZyGmXt84w2rvc82bHucO+XsU=
Received: by 10.216.186.196 with SMTP id w46mr150737wem.24.1321346850105; Tue,
 15 Nov 2011 00:47:30 -0800 (PST)
Received: by 10.216.19.209 with HTTP; Tue, 15 Nov 2011 00:47:08 -0800 (PST)
In-Reply-To: <7vpqgvmwtl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185444>

Hi Junio,

Junio C Hamano writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>> [...]
> [...]
> I do not see an inconsistency here, let alone any "glaring" one.

Yeah, my commit message is totally misleading and unclear.  Yes, all
the operations make sense to you and me; for a new user who doesn't
understand how Git works, it's completely inconsistent at a very
superficial level, no?  The sequence of operations he has to execute
depends on:
1. If he literally specified a single commit or a commit range on the
command-line.
2. In the case of multi-commit picking, there's an additional layer of
decision making: did the conflict occur in the last commit in the
range?

Anyway, I'll rewrite this commit message in the next iteration.

Thanks.

-- Ram

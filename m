From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Weird behavior of shell variables in git aliases
Date: Tue, 22 Mar 2011 11:52:00 +0100
Message-ID: <AANLkTi=h4Upus2x4MTXXEX=PSrp-4xhEpzifsGXKycf5@mail.gmail.com>
References: <d9c38309-c433-476c-bba3-f2c5b7e94a89@k15g2000prk.googlegroups.com>
	<20110321215310.GA2122@sigill.intra.peff.net>
	<7v8vw8nmh2.fsf@alter.siamese.dyndns.org>
	<7v4o6wnlxm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Erik Faye-Lund <kusmabite@gmail.com>,
	Dun Peal <dunpealer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 11:52:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1zC8-00069z-4w
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 11:52:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409Ab1CVKwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 06:52:05 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59470 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab1CVKwD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 06:52:03 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so6290977fxm.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 03:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=HLx4xqyYCUIOLdiNAJJ+4zFow5Rj5mGvMsiwfoZSW4w=;
        b=J00uRAxZCmjlGrm6tvbturQD5qQHow7PTTR0km7funLLji/8+7ZeH9PoCWGrMDl5th
         GaRlP1k8bDdpP1Q6F/wdHUU1k3aKbFl4eWSUTFsoUHtrreT2QOloKUipMfpjPJcF3SsD
         Z0xQ4ZBu4DjROVGzDs83v8Jo8o7Sk9r/QGT3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=MwX9C+OYgbJPB8m0TP0Ntd3cI999BiyyxmCOoR9rvn0XoBIccwkmWEgrHYHX/zgH3z
         p7/97idMHS64+prz5QxyLJdHrvJvHCIe4dGse5PZWOxzsnHDtZaZLcMWnusA9XJdIbLT
         xizkW0YA+lmkwH2qUMuIGCwNMshI0xgpgKTyo=
Received: by 10.223.77.71 with SMTP id f7mr6246722fak.141.1300791120909; Tue,
 22 Mar 2011 03:52:00 -0700 (PDT)
Received: by 10.223.123.198 with HTTP; Tue, 22 Mar 2011 03:52:00 -0700 (PDT)
In-Reply-To: <7v4o6wnlxm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169720>

On Mon, Mar 21, 2011 at 23:33, Junio C Hamano <gitster@pobox.com> wrote:

> but it would penalize a properly written alias that uses "sh -c <it> -"
> trick itself by double forking, which is not very nice and I am unhappy
> about.

It would also be bizarre on Solaris where /bin/sh isn't a POSIX shell.

But we can substitute the relevant user-supplied shell during the build process.

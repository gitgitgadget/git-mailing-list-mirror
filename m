From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: bzr to git syncing
Date: Fri, 28 Aug 2009 09:19:29 -0700
Message-ID: <fabb9a1e0908280919o412baeb1ka69968a93297ca59@mail.gmail.com>
References: <F84D4C0F-1CEF-4853-84DB-B7927CBE62B3@gmail.com> 
	<b2cdc9f30908280902m22d594bam3c70259d4c296e52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, David Reitter <david.reitter@gmail.com>
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 18:19:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh4BB-0001bo-5H
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 18:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbZH1QTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 12:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbZH1QTs
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 12:19:48 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:49673 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbZH1QTr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 12:19:47 -0400
Received: by ewy2 with SMTP id 2so2272452ewy.17
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 09:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=w2VEeeDptBS0HKg/qu/0kfUpIG+xwFmuLkvMGkzprkA=;
        b=DVWC+vxJ+J/0LY8jImgfsAU3wzpDw1XPsqd6m/0sAqijO/WbJ18vZFQDKQCm6YY+fU
         3xlqHozp32cMa5TPGDVqNvnpuctcud5J/p1TxOZ1/mMJ9VLEbpM+TrUbp2L4DouDYAgh
         lE/CIotRF8dgXPG51hidyAoc/S2UCp/1ziqec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=cLpyPshZ6OgiQPpEJN44hXNF2vT/6PkDYmpp42QaqBrm+hEHU+qHFtWXBzaTxEar5b
         gIXjEwsdcmFD1HT501nFLIC1xAoD7vLjHC7If22G/acFwZRaDFTCYW8qU0aku4+TmPpr
         Bgm1K7e/vo8KazGV3SszQCrynI2yLeiWmGrTs=
Received: by 10.216.1.205 with SMTP id 55mr255846wed.191.1251476389088; Fri, 
	28 Aug 2009 09:19:49 -0700 (PDT)
In-Reply-To: <b2cdc9f30908280902m22d594bam3c70259d4c296e52@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127310>

Heya,

On Fri, Aug 28, 2009 at 09:02, Alex Bennee<kernel-hacker@bennee.com> wrote:
> I've attached the fast-import crash I'm seeing. Are you seeing the
> same sort of failure?

The program you used to generate the stream (I assume git-bzr?) is
generating an invalid mode, git understands '100644', '100755',
'120000', and '160000'; the mode in the stream, '040000', is not
something we understand.

-- 
Cheers,

Sverre Rabbelier

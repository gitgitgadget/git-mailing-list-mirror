From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Git, Mac OS X and German special characters
Date: Sat, 1 Oct 2011 22:02:40 +0000
Message-ID: <CAMOZ1BuXiQkZG_7mvay-ybm7Q7niwXVhbmbCmkfy=wD1AKsasQ@mail.gmail.com>
References: <CAO1Q+jf=RO=sE90-mQdi+=fUWH1RLM+JTubSgSVGC5uDyhU+2A@mail.gmail.com>
 <4E87182C.8050201@op5.se> <CAO1Q+jeLEp2ReNc9eOFoJxdGq6oRE3b+O=JvMNU0Kqx_eAX=7w@mail.gmail.com>
 <4E872288.10503@op5.se> <20111001194746.GA16826@inner.h.iocl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>, Albert Zeyer <albzey@googlemail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 02 00:03:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RA7eO-0004en-GQ
	for gcvg-git-2@lo.gmane.org; Sun, 02 Oct 2011 00:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514Ab1JAWDM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Oct 2011 18:03:12 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52088 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab1JAWDK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Oct 2011 18:03:10 -0400
Received: by iaqq3 with SMTP id q3so3263929iaq.19
        for <git@vger.kernel.org>; Sat, 01 Oct 2011 15:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=EimIIOueLVbzSbtlHResAMXmt9DT03swi9cn8OpFcYI=;
        b=fR2ZFL22gi14L207FwrkCbvuvVcpaMqcb2wGEU8C3dv0NOEBBGM8kDX8sBMifDdOpj
         0tNeiwDLME2ojUjW2yW6UQARpdZdcek8vNUFzclN6CtHZ7iX2jjopbVED9Maz0RmV3KF
         2nk6EGzbs8XWIpwmeXmD7+ly1fIz1KRulgg4I=
Received: by 10.42.134.4 with SMTP id j4mr5031629ict.135.1317506590106; Sat,
 01 Oct 2011 15:03:10 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Sat, 1 Oct 2011 15:02:40 -0700 (PDT)
In-Reply-To: <20111001194746.GA16826@inner.h.iocl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182579>

On Sat, Oct 1, 2011 at 19:47, Andreas Krey <a.krey@gmx.de> wrote:

> The question is, should git forbid two filenames that consist
> of the *same* characters, only differently uni-encoded? I don't
> think anyone would make two files named 'B=C3=BCro', with different
> unicode encodings. But as far as I know that is a shady area.

So, let's leave git's current behavior as the default and provide
a config variable that when set, tells git to handle file names
in terms of characters rather than bytes.

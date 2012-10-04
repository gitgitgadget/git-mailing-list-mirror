From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: [PATCH 0/4] optimizing upload-pack ref peeling
Date: Thu, 4 Oct 2012 20:14:52 +0800
Message-ID: <CAEY4ZpMiQn61ZD8-Gbcr8zKW=LRQZKwFb7kwVeAJ3tPrvkRbWQ@mail.gmail.com>
References: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com>
	<20121003180324.GB27446@sigill.intra.peff.net>
	<CACBZZX4Grya=FbL9XEh_EK6KVsFZYWCuHveV2QevcBwr+iYTMQ@mail.gmail.com>
	<20121003212007.GC4484@sigill.intra.peff.net>
	<CACBZZX6yMfeOx6x4iy8beq5niy9HvPq0c8ND5jZkoiJWAgVjfw@mail.gmail.com>
	<20121003231529.GA11618@sigill.intra.peff.net>
	<CACBZZX5Sm++Wjyoue-qk7TjwxUM3QihXfWGtEHhOq=VtkgvNbQ@mail.gmail.com>
	<20121004075609.GA1355@sigill.intra.peff.net>
	<20121004080438.GA31305@sigill.intra.peff.net>
	<CACBZZX6hoXdP5fV8NSmkEOvm1eayyCH+vSJYSpd=ZL0XjC68HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:26:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtXF-0001w8-5U
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756008Ab2JDMOy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2012 08:14:54 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:48245 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983Ab2JDMOx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Oct 2012 08:14:53 -0400
Received: by mail-vc0-f174.google.com with SMTP id fo13so425263vcb.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 05:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=/dmCAO+pHTZEvBD7eHj8P+dgZFGeMOu5hKbIzkkusd8=;
        b=gsyeEoVLaNqpmSe3mSW2byW/RTwmLM8tUIlXrbg9lIRa9xaMemSkDwBA1Pt2PakkiP
         dQqA0m/BUll789BQFBlwEWT721phPnFW5Wfx1dH69kIfSC2dVju9OiD14Ad/EmMAV4Mw
         EiKz74haUWJeo5mW2Db9htOtiRMSaz/RNZcm6ZHRLIkXcDeIzgmtXrQhnUskgUONx8xa
         B2XdPS5TgUIZbNoDf9lmkl3FgKA9uFLl+jdHYusDbJf0zQNOsiG3aSz0Q71bH9U+AveI
         qI3MAEXVYrS2gHb2vLMmWmUqNFrWYSb9qX1p3p+OPdj1/LWKy9ifWi16iUGmcd9xKpih
         qmdA==
Received: by 10.220.38.196 with SMTP id c4mr3013642vce.41.1349352892853; Thu,
 04 Oct 2012 05:14:52 -0700 (PDT)
Received: by 10.59.5.232 with HTTP; Thu, 4 Oct 2012 05:14:52 -0700 (PDT)
In-Reply-To: <CACBZZX6hoXdP5fV8NSmkEOvm1eayyCH+vSJYSpd=ZL0XjC68HQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207001>

On Thu, Oct 4, 2012 at 5:01 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
>     $ time (echo 0000 | ~/g/git/git-upload-pack . | pv >/dev/null)

Totally off-topic, but ...

Thanks for making me look up what pv is. I remember checking it out
quiet sometime
ago and have forgotten about it altogether.

Now I can replace my poorly written, half-assed attempt at a shell scri=
pt to do
something similar to what pv is already capable of!

Nazri.

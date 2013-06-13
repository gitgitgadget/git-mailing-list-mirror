From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/3] Move copy_note_for_rewrite + friends from
 builtin/notes.c to notes-utils.c
Date: Thu, 13 Jun 2013 08:13:03 -0500
Message-ID: <CAMP44s0Ng=d_h2dewZzSDk3LcXHNmz_8mGRXL43LE=iWOigN_w@mail.gmail.com>
References: <7vehc8a05n.fsf@alter.siamese.dyndns.org>
	<1370995981-1553-1-git-send-email-johan@herland.net>
	<1370995981-1553-3-git-send-email-johan@herland.net>
	<CAMP44s2pUW_+w6B_R-A=vxOg1Ay6iLmc4MQsA_sfDF+GP-XsWw@mail.gmail.com>
	<CALKQrgfxrKz5bB=AAmL1ZtBFRK2Bx6TrRd1AsMEVv8bTAH0KCg@mail.gmail.com>
	<CAMP44s3KAeDPo1Cw8eFsU=A6H7oUGmf+eLAMvGV+R2_hPXHLbw@mail.gmail.com>
	<20130613064521.GA21707@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johan Herland <johan@herland.net>, gitster@pobox.com,
	git@vger.kernel.org, jrnieder@gmail.com, pclouds@gmail.com,
	artagnon@gmail.com, john@keeping.me.uk, vfr@lyx.org, peff@peff.net,
	torvalds@linux-foundation.org, Thomas Rast <trast@inf.ethz.ch>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 13 15:13:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un7Kx-0005lF-Q0
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 15:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755567Ab3FMNNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 09:13:07 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:53793 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529Ab3FMNNF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 09:13:05 -0400
Received: by mail-lb0-f169.google.com with SMTP id d10so9721671lbj.0
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 06:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zFa6rQmBK+GEyn/amgYyg+rB7GxIE9sfC7y9AwMb86k=;
        b=sjMYXNrTycSESLJkBKzKzw6JezGNTP5WmbTz1RZUSkoEqDonbw8MHMjdBQIFFTPWKl
         C8fDIZpidCH9JwJdsnSyZr9JRaTczuPtD+dNvOSuc0dP/ovWaaLpezEM2zcbrp9LsGvi
         uojqnAM78Ml/NCjhQl3g4GqKm3+zs0MuE6LJ2kJPPxNajKTQY+qoerp6tf1uIrmjgdlV
         XDr4OUnymCfCDQvMSpTxxD2C1nbyeThOVgEeoCPHrRJjt5Qawe8CGzFSRojzlEPqlfqf
         FbHqKHYJguM8buviEXxW6H5OydBb2P56GJ7RtErbMbsUaESptD/P2WySBSy+rTU1YG/D
         yDag==
X-Received: by 10.112.157.226 with SMTP id wp2mr1274905lbb.65.1371129183347;
 Thu, 13 Jun 2013 06:13:03 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Thu, 13 Jun 2013 06:13:03 -0700 (PDT)
In-Reply-To: <20130613064521.GA21707@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227726>

On Thu, Jun 13, 2013 at 1:45 AM, Andreas Krey <a.krey@gmx.de> wrote:
> On Wed, 12 Jun 2013 13:28:05 +0000, Felipe Contreras wrote:
> ...
>> And you are
>> doing that with the express purpose of annoying.
>
> Where did 'assume good faith' go to today?

Did you read the last part?

"This does not mean that one should continue to assume good faith when
there's evidence to the contrary."

That being said, my evidence was not solid, and while there is still
the possibility that he was indeed acting in good faith, I've received
no response from him, and Junio has committed the change without any
mentioning of where the idea come from.

Either way, I bet you my good faith suggestion will *not* end up in
the official guidelines, nor will any suggestion of mine.

-- 
Felipe Contreras

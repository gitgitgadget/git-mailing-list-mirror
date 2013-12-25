From: Roman Kagan <rkagan@mail.ru>
Subject: Re: Fwd: Error with git-svn pushing a rename
Date: Wed, 25 Dec 2013 14:52:24 +0400
Message-ID: <CANiYKX40naaeUxaZEnYBcb7o5h7A9HPq5inuGjXn28R3NtzT1g@mail.gmail.com>
References: <CAM-uYMiLpsQdN41Gs8iJOT-v0qKgod2vEeoC3C+QJ5+wKiVK-Q@mail.gmail.com>
	<1387919476-27921-1-git-send-email-rkagan@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Roman Kagan <rkagan@mail.ru>
To: Benjamin Pabst <benjamin.pabst85@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 25 11:52:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vvm4k-0002wL-Pr
	for gcvg-git-2@plane.gmane.org; Wed, 25 Dec 2013 11:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844Ab3LYKw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Dec 2013 05:52:26 -0500
Received: from mail-qa0-f54.google.com ([209.85.216.54]:47886 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab3LYKwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Dec 2013 05:52:25 -0500
Received: by mail-qa0-f54.google.com with SMTP id f11so6859909qae.6
        for <git@vger.kernel.org>; Wed, 25 Dec 2013 02:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=P1F5Mp7aQaLGOVRLXxnnVGdP6up/VwPwhW8ZdSGh1WY=;
        b=D/0QNpFKrHkQFXnElIQyGP3/1Ex/c7Qzub1wIwaovz48enXryNPDHGpGaZ+BC/8Rnu
         hg6VuoOmcwfBiQ7nyyeaetZChUK4VC0kJ28NkZ1Gv6oe2n3csSDc9kUE/nixGxO28st7
         jPfFtKW3piZ4QQKVPRyy9fQoNUGdAqiHKdvxxFgELZezGeNMchEzBkEyvW0GeFgusj4/
         gKQG/ceg6NRg6/BVmc9zPtIHz04GvFHL35DdxfDy3rtDmqBCDHKJn1/TqrAVPTp9E/zJ
         XF/6govv7rPlUAWxQ9/B7CT1r5bWKy0ehy6RQXUI3k7+HTN6iAo/aMK/fcVvf02Tuisu
         Fi/A==
X-Received: by 10.49.13.135 with SMTP id h7mr61832047qec.73.1387968744778;
 Wed, 25 Dec 2013 02:52:24 -0800 (PST)
Received: by 10.224.98.146 with HTTP; Wed, 25 Dec 2013 02:52:24 -0800 (PST)
In-Reply-To: <1387919476-27921-1-git-send-email-rkagan@mail.ru>
X-Google-Sender-Auth: JxyHFEfri239x0QPtCYuKJ86MXY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239672>

2013/12/25 Roman Kagan <rkagan@mail.ru>:
> I've hit this problem too, and tracked it down to what I think is a
> bug in svn.
> [...]
> I'm going to submit a patch adding apr_pstrdup() to subversion folks.

http://thread.gmane.org/gmane.comp.version-control.subversion.devel/145186

Roman.

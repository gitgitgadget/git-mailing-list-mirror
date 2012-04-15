From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 0/5] completion: trivial cleanups and fixes
Date: Sun, 15 Apr 2012 08:20:02 -0500
Message-ID: <20120415132002.GB2544@burratino>
References: <1334439784-6460-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 15:20:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJPNF-0006Pg-JE
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 15:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336Ab2DONUH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Apr 2012 09:20:07 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44232 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845Ab2DONUG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Apr 2012 09:20:06 -0400
Received: by iagz16 with SMTP id z16so6235132iag.19
        for <git@vger.kernel.org>; Sun, 15 Apr 2012 06:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Z31GAm96av7xkAWtR6OiIqCOYzoLQtY7/2KdQrov3dU=;
        b=IXUlDMSsVZVr8QUno4nvDJeLmZIb3BRTyTQC+h9MZFEm0ZcPTo+mTNQNVOnaX4lm1P
         Dutf7yv+3QKXqe0O+89+crvb+HIxYNatPNmfS6Gfno0diSHOHKgo1tO0gl0U8QF6uMS+
         d3TDbGXHh6JYXfmPbJgTBdj8/tCLeB5SafJ9vkhO6k60EvY/e1Cr9tSZ1XS/BHB0zPMt
         8wm5dj9FmrLs1oie007P19HoooZNGCdzPzRLghqGdhCTnAJl3n6xq/LxdLGaj2fCdmtS
         dXzuZXBfbqOCd1djtqRnjp9+OOByJYYilGZ/U4tyUpAsWH7RR5mKYNgI5uVDIWueLdzE
         2nxg==
Received: by 10.50.40.166 with SMTP id y6mr3023602igk.69.1334496005828;
        Sun, 15 Apr 2012 06:20:05 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id en3sm15612921igc.2.2012.04.15.06.20.04
        (version=SSLv3 cipher=OTHER);
        Sun, 15 Apr 2012 06:20:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1334439784-6460-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195568>

=46elipe Contreras wrote:

> Just a few simpliciations, improvements, and add some missing options=
=2E

I generally like this.  Quick comments:

> Felipe Contreras (3):
>   completion: simplify __gitcomp_1

Thomas and G=C3=A1bor seem to have this one covered, with some improvem=
ents
to it under discussion.

>   completion: trivial simplification

Improves consistency.  The changelog line isn't precise enough to
remind me which change is being mentioned when reading it in the
shortlog, so I guess I'd prefer something like

	completion: simplify by using $prev variable

>   completion: add missing general options

Likewise, a subject line like the following would work better for
me.

	completion: --info-path and --no-replace-objects options for git

Hope that helps,
Jonathan

From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Standardize python shebangs
Date: Thu, 8 May 2014 14:20:23 +0200
Message-ID: <CALKQrgevDwtjF9Thi9xV6M=Os4mZMwf9JhYecJB4c0-SOJq33A@mail.gmail.com>
References: <1399456987-24156-1-git-send-email-felipe.contreras@gmail.com>
	<vpqy4ydpiog.fsf@anie.imag.fr>
	<536a842838fbb_76ff7a52ec5d@nysa.notmuch>
	<vpqr445nxrw.fsf@anie.imag.fr>
	<536a9a34e8194_76ff7a52ec7f@nysa.notmuch>
	<vpq1tw5nw7q.fsf@anie.imag.fr>
	<d15f06ad-0418-48ed-a9dc-6ca1e955e75c@email.android.com>
	<vpqlhucmqxt.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: James Denholm <nod.helm@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 08 14:20:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiNJT-00079O-1Y
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 14:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208AbaEHMUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 08:20:30 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:56400 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbaEHMUa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 08:20:30 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1WiNJL-0001bz-Re
	for git@vger.kernel.org; Thu, 08 May 2014 14:20:27 +0200
Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1WiNJL-0008kM-C1
	for git@vger.kernel.org; Thu, 08 May 2014 14:20:27 +0200
Received: by mail-ob0-f175.google.com with SMTP id wo20so2885361obc.20
        for <git@vger.kernel.org>; Thu, 08 May 2014 05:20:23 -0700 (PDT)
X-Received: by 10.182.96.99 with SMTP id dr3mr3940950obb.42.1399551623363;
 Thu, 08 May 2014 05:20:23 -0700 (PDT)
Received: by 10.182.245.10 with HTTP; Thu, 8 May 2014 05:20:23 -0700 (PDT)
In-Reply-To: <vpqlhucmqxt.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248419>

On Thu, May 8, 2014 at 1:48 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> It is very important that git-multimail keeps running with Python2
> (ideally, it could be portable Python 2 or 3, but it's not so easy to
> do), but that would be strange to force even non-git-multimail-users to
> use Python2 for that.

FWIW, the rules laid out in PEP394 should be very easy to follow:

 - If your script is Python2-only, use "#!/usr/bin/env python2"
 - If your script is Python3-only, use "#!/usr/bin/env python3"
 - If your script is Python2/3-agnostic, use "#!/usr/bin/env python"

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

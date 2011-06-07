From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/8] git-remote-testgit: exit gracefully after push
Date: Tue, 7 Jun 2011 19:48:17 +0200
Message-ID: <BANLkTi=J5=y8MvRrtQunPPg_8Y8zMqggnw@mail.gmail.com>
References: <20110607171838.GA21685@sigill.intra.peff.net> <20110607171947.GA22111@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:49:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU0Ol-0005Bz-8R
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 19:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755959Ab1FGRs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 13:48:58 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:40842 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753754Ab1FGRs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 13:48:58 -0400
Received: by qyg14 with SMTP id 14so2640599qyg.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 10:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=7CXHMRCsw469ubMXJ0IMvONCTCrs3GZkMXKkjtRBQJE=;
        b=hQA+m/v3qUX/B6pwxPGUbVyr5SuA2DsREMUog3mGtZotsybNbESJd6CQM4kqla8s0+
         uOJMu0zeY8NkT0JmZZNy2+TQg6GZfyXeB4aDo1/C8iVSS56L/JSB15JY4zqCvUAuZ6mf
         1FwTGiXP7bWgEuU4gYxPFyiDnOwTxXUIADtVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=SHrPVdvWiR5xEHixna7KEX7de4orFW56PDjarmV+2LKBVUplxSJKD1I9SJc9zwhk8R
         jKdcqXlmACs1rfHa51SSZTwE7T+lP1R/iXlvQ7fxG90gpqTyHXVq+I6JWqeLg5EXpGI+
         i24cz5157NSLfTxLJbwWvoBYbI5/5h0B7OU6Q=
Received: by 10.229.135.12 with SMTP id l12mr4809410qct.53.1307468937225; Tue,
 07 Jun 2011 10:48:57 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Tue, 7 Jun 2011 10:48:17 -0700 (PDT)
In-Reply-To: <20110607171947.GA22111@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175238>

Heya,

On Tue, Jun 7, 2011 at 19:19, Jeff King <peff@peff.net> wrote:
> This patch lets each command handler tell the main loop
> whether it should expect more commands or not; the handler
> exits gracefully if no more are expected.

I have a (much) better solution to this queued locally: the 'done'
feature to fast-import. I've sent the series out once, but I never
followed up on the comments it received. Patch series forthcoming.

-- 
Cheers,

Sverre Rabbelier

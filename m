From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] Add two grep config options
Date: Mon, 28 Mar 2011 14:13:49 +0200
Message-ID: <AANLkTin_qeFSqyXHddmEpu=5e4yO8cxyOkbhcXUg3efn@mail.gmail.com>
References: <1301088071-918-1-git-send-email-jratt0@gmail.com>
	<7vlj024wal.fsf@alter.siamese.dyndns.org>
	<4D9037AA.9090601@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Joe Ratterman <jratt0@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 28 14:13:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4BKV-0004us-Ta
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 14:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681Ab1C1MNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 08:13:51 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41221 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab1C1MNu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 08:13:50 -0400
Received: by qwk3 with SMTP id 3so1845526qwk.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 05:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=H7YqmCfI5VQTlx1zncD0RkGqezsEfte6fgg+9Wpri1g=;
        b=QqK/+0pqlSHgT9m3RxD95hXzOc2LRCg1EG9c2hTUKPtqG68w+9NJb+EzqfrbR8g9ww
         +oSTkpw5t2g2tDLXg6SNCocm/j4mbb7vimaogkpXvGAymqiGCdaeDMpsn/xmVmWrPEbl
         w9IUfSXS7A/5NRcU25uW3qradq5sEI2DFYBwE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=gOpOz//x7JpI2fcXrr5mEOcwIALXnlG/W88x6J/je/DxCZ7isfvPBMs/OL5GzxCEzp
         CgM5Z/qYUbZD9F13LrzSTYC2nBjM+4LJ0OpZ5i8QeUXI3dtKpa2X/ZliLfou0IwwLb0s
         1y8NBYtOlHEe4oodQ6HjUkJMII79HJLWrEr6s=
Received: by 10.224.180.68 with SMTP id bt4mr3350273qab.110.1301314429710;
 Mon, 28 Mar 2011 05:13:49 -0700 (PDT)
Received: by 10.224.169.197 with HTTP; Mon, 28 Mar 2011 05:13:49 -0700 (PDT)
In-Reply-To: <4D9037AA.9090601@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170119>

On Mon, Mar 28, 2011 at 09:24, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> We could safeguard scripts from this by
>
> - checking istty and

That should consider running under the pager too.

I had proposed this scheme last year to TopGit as a way to
differentiate between ui and plumbing. But as Jeff pointed out, this
is probably not enough.

Bert

> - checking env for GIT_PLUMBING
>

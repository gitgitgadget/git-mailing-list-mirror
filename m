From: Tor Arntsen <tor@spacetec.no>
Subject: Re: Stashing individual files
Date: Wed, 4 Jan 2012 11:12:27 +0100
Message-ID: <CABNEGjzRZu_hpN+Do4=4abBKp0o3uKfrd-_A2y53a7V4mteNnw@mail.gmail.com>
References: <CAJ6vYjduoBNrRcvcvQbX_yY-3-Qm5ZbXOM0WQpWRwC1H1OCqaA@mail.gmail.com>
	<20120103190612.GC20926@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Leong <walkraft@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 04 11:12:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiNpi-0006Vl-MC
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 11:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232Ab2ADKMa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jan 2012 05:12:30 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:45217 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab2ADKM3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jan 2012 05:12:29 -0500
Received: by werm1 with SMTP id m1so8416051wer.19
        for <git@vger.kernel.org>; Wed, 04 Jan 2012 02:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9VMzU/rL6YmWYEeq7n1Y/llfbkHp5tZDYwvKb0InAVg=;
        b=WOA+jam5TwjP2l1ntO8xYQob4uHvmDXeD0DezXnJnOUPMvKHV6wnY0/2aVnLUdBcqB
         LXwTAY63QpqF89A3g9PNDQkCeg7Mn5KvMfJGZuKLGKK4m7pTmpJPdt1hEYxFMTp2VrZ1
         fXIHP28Mv7M541lUlUAV4X+DBypcr29MJpuoQ=
Received: by 10.216.139.156 with SMTP id c28mr36364725wej.34.1325671948039;
 Wed, 04 Jan 2012 02:12:28 -0800 (PST)
Received: by 10.223.103.135 with HTTP; Wed, 4 Jan 2012 02:12:27 -0800 (PST)
In-Reply-To: <20120103190612.GC20926@sigill.intra.peff.net>
X-Google-Sender-Auth: xle-1WxrDpRv5PxLJYhzVCbxXB4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187918>

On Tue, Jan 3, 2012 at 20:06, Jeff King <peff@peff.net> wrote:

> IOW, make the "--" a requirement for specifying filenames. The only
> regression is that "--" as a single argument can no longer be used in
> stash messages. So this works now:
>
> =A0git stash save working on foo -- needs bar
>
> but would be interpreted under my proposal as stashing "needs" and "b=
ar"
> with the message "working on foo". You would instead have to spell it=
:
>
> =A0git stash save "working on foo -- needs bar"

=46or what it's worth, that's how I always add messages to stash.. with
quotes. It had never occured to me to use the form
git stash save working on foo -- needs bar
(no quotes), it's so ingrained that a multi-word message should be
quoted that I would never have thought of even trying without the
quotes! :-)

-Tor

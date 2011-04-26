From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Tue, 26 Apr 2011 21:18:58 +0300
Message-ID: <BANLkTinKDHM-RU2wqZECFcjQEoRWADnTGQ@mail.gmail.com>
References: <ih1449$ul6$1@dough.gmane.org>
	<7v62tjs66r.fsf@alter.siamese.dyndns.org>
	<20110120203840.GA11468@sigill.intra.peff.net>
	<7vbp3bqmiy.fsf@alter.siamese.dyndns.org>
	<20110120215456.GB11468@sigill.intra.peff.net>
	<AANLkTikBbSt5_WdbuE8a96w1pWBCYLNjMCUCBThjdLdG@mail.gmail.com>
	<7vk4hyp38i.fsf@alter.siamese.dyndns.org>
	<AANLkTikmbWkpjioARZrmySpLM8t7kqCX0v1+NKibk_ar@mail.gmail.com>
	<AANLkTinRcmevXz3zV0wtxd7+Q3F4zcH2AZOQk1XVxYXa@mail.gmail.com>
	<BANLkTim1gW_L-9DKo9p_VFQFUBUGWAPxoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 20:19:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEmqt-0005I7-6d
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 20:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757936Ab1DZSTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 14:19:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55600 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757864Ab1DZSTA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 14:19:00 -0400
Received: by fxm17 with SMTP id 17so628735fxm.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 11:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Qz41Mo+uR39rehfoHu8DPvdk7IXonFuuKIP3QEap5kw=;
        b=fQe4R/pVygQx4F2p33+MznfEsfk1izaCi9SY3Td6ZCJguNtwTN0nk1LWZOBc+5abcj
         eCl/YVaghLx1QSsrRT0A4Glpm4Fm2HTDKg9Q0pmAPLtSwWz2kdxxTW5u2r7qHR+/xWEx
         AlI0albPlikJaRoUBm/IDd4KVHxPFvEmKDwXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=hlJV8IoYH/DNrTEgfrlOQaXCSmaosfZgEhMmKh6pSzsk8yzDriCqaioBAQ6VL393yY
         9WYTp93IAGFBQdDIp6MHJPaZgqZO2S8O0x9DbZ+TIc0oand1KSSSAvMzSda7vKtv8PsH
         85HvU0/GkDKxUJqvMgbvzJjvI9Wl+2LyT4r54=
Received: by 10.223.77.4 with SMTP id e4mr1212253fak.51.1303841938795; Tue, 26
 Apr 2011 11:18:58 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Tue, 26 Apr 2011 11:18:58 -0700 (PDT)
In-Reply-To: <BANLkTim1gW_L-9DKo9p_VFQFUBUGWAPxoA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172121>

On Tue, Apr 26, 2011 at 3:09 PM, Stephen Kelly <steveire@gmail.com> wrote:
> Can git have a bug tracker please?

So that you would feel comfortable that there would be a bug report
gathering dust? Or that it's closed as invalid for lack of
information?

> This is another reminder to fix this bug which is otherwise untrackable.

Let's imagine you are posting this to bugzilla: first question?
How do you reproduce this?

But I already asked you this[1], and you didn't reply. What should one
assume but that you don't care enough to help get this fixed.

[1] http://article.gmane.org/gmane.comp.version-control.git/165320

-- 
Felipe Contreras

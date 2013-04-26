From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Fri, 26 Apr 2013 19:34:00 +0700
Message-ID: <CACsJy8B1yfqVmaBZ0A=Yfxx+As_+JzBzWr4LqrEwhr5qGZ7+Aw@mail.gmail.com>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
 <7va9ong9oa.fsf@alter.siamese.dyndns.org> <CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
 <7v38ufer2x.fsf@alter.siamese.dyndns.org> <CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
 <CALkWK0=5tE0pXj-XTe4g9LdCO78yrPNwyom5fupF1WTToY2TZw@mail.gmail.com>
 <877gjrpsk4.fsf@hexa.v.cablecom.net> <CALkWK0kn7mEosWSdWs1Jjx-L32wmL51W=X7ny9BYQMttG1LPvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 14:34:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVhrI-0005YV-6m
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 14:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756291Ab3DZMec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 08:34:32 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:55357 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755459Ab3DZMeb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 08:34:31 -0400
Received: by mail-oa0-f45.google.com with SMTP id o17so3851451oag.4
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 05:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=0WonxP2X3crwyPyq3OT+nM2fs1CrfZkiZ7J0DQUI990=;
        b=tH/yeHUIbLCiRtRJESO5XBZNIU4gQYihBk0Hn0bdKKZ0JX2kLKZPfT74yzUKrvbTyA
         j7CY2lKSSGQzzFBVpQI2+tINSy9tmAhbdLys5VskDzfHPmDcItKUyHQ+J6BA2OAahmhy
         972RC559Y1bd+ZlWSncgu/c5KKGdmTGyZANq/UHKOrypxdo1FuThcWgTxcfiCjxXU2AT
         ebT7psz6/45kxiNNP0MTbO7wgmsnOy1YIjUMi8tloIcg7Fhn61xSZaksnx61SjU33bFH
         xFh7iHbSeFMXzD4dkkG1RNK0U77N0RjaO6YKMWhYaDrZAE3wIPCP7QPcxJPS3LXycznN
         SDfw==
X-Received: by 10.182.156.20 with SMTP id wa20mr17719135obb.59.1366979670937;
 Fri, 26 Apr 2013 05:34:30 -0700 (PDT)
Received: by 10.76.142.74 with HTTP; Fri, 26 Apr 2013 05:34:00 -0700 (PDT)
In-Reply-To: <CALkWK0kn7mEosWSdWs1Jjx-L32wmL51W=X7ny9BYQMttG1LPvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222531>

On Thu, Apr 25, 2013 at 3:54 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> On a related note- In my opinion, :/ is broken, because it blocks
> composition completely.  I would've really liked {:/quuxery}~3.

For composition, you should be able to combine a ref set with @{}
syntax, so you can choose to apply @{} on refs/heads/*, or all refs. I
guess it's not worth the trouble because, except the case of :/ that
searches and returns 1 sha-1, other @{} may return multiple sha-1s on
a ref set.
--
Duy

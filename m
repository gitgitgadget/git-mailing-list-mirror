From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 03/40] whitespace: remediate t1006-cat-file.sh
Date: Sun, 7 Aug 2011 08:56:54 +1000
Message-ID: <CAH3Anroof2p+hAkTizL4WrXv+DwTXOzM5Bi6EA8Zc2_Mvf8n8w@mail.gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
	<1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
	<1312620294-18616-3-git-send-email-jon.seymour@gmail.com>
	<20110806092856.GB7645@sigill.intra.peff.net>
	<7vmxfm1l1r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 07 00:59:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QppqK-0000Tf-Je
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 00:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279Ab1HFW44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 18:56:56 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36148 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612Ab1HFW4z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 18:56:55 -0400
Received: by vws1 with SMTP id 1so2663787vws.19
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 15:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=x4+OYvu9iXAOcNLBE6moF5tQbx9ll/D2TbTYnlOMecY=;
        b=KuuKHsn8VrlsuCYSupnZBXd9xH2kILKtLyCh1QoyGxFoQRymSdL0YwofDPZrPOIvYd
         wqg+vdtyg7D1JDJsOADsKKDF0F3m7QQxISvekAF+sOIPTvNlzOLbpLGzCOOPcpzrvjC4
         5GS65n8Be00p69QwRlbixXqXx8LJVTmvvLH8c=
Received: by 10.52.69.147 with SMTP id e19mr4087368vdu.399.1312671414989; Sat,
 06 Aug 2011 15:56:54 -0700 (PDT)
Received: by 10.52.183.134 with HTTP; Sat, 6 Aug 2011 15:56:54 -0700 (PDT)
In-Reply-To: <7vmxfm1l1r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178892>

On Sun, Aug 7, 2011 at 3:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
> I actually am slightly against it. One-time whole-tree clean-up can never
> happen without downside as _some_ parts of the tree always have patches to
> conflict with it in flight. One-time decision to clearly spell out the
> rules and cleaning the tree over time, fixing parts that are not actively
> touched one at a time, is probably feasible, though.
>

I certainly agree that whole tree cleanup is disruptive when there is
a lot of other stuff going on since it causes lots of merge conflicts.
In my day job, I sometimes have to defer otherwise sensible
refactorings because of the carnage they would cause for the daily
integration.

That's what I think is nice about having an easy way to automate the
cleanup+test, especially if it can be applied to arbitrary
refactorings. Having earlier invested the effort in creating some
refactoring heuristic, you can later easily apply the heuristic
completely and consistently to a file as part of some other
maintenance activity.

jon.

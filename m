From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v3] Teach merge the '[-e|--edit]' option
Date: Mon, 10 Oct 2011 17:09:53 -0700
Message-ID: <CAG+J_Dz4x7CmHKXx-9p-ZxmiuFyE2v3TFwkXfYgyc-p37ONinQ@mail.gmail.com>
References: <1318099192-60860-1-git-send-email-jaysoffian@gmail.com>
	<7vd3e4k162.fsf@alter.siamese.dyndns.org>
	<CAG+J_Dz37etot0nNkq+1gTUy8R0vVJpsRQuvwrTSczXRWy7mkA@mail.gmail.com>
	<7v1uukieh2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	"Todd A. Jacobs" <nospam+listmail@codegnome.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 11 02:09:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDPuw-0007Ul-AG
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 02:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684Ab1JKAJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 20:09:54 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61078 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581Ab1JKAJx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 20:09:53 -0400
Received: by ggnv2 with SMTP id v2so5071403ggn.19
        for <git@vger.kernel.org>; Mon, 10 Oct 2011 17:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zEaabAJLUOJJKOWr4XW9FIms6taFlPAA29AiodvAO7s=;
        b=PCgQ0e+iRInHWSqZr9Gl+HUmNXpkfbtNH+p5OV7+OaAi3bye7f0q2IgDVvvtn0+m3A
         IvfeVNVoBKEBynvosaokH374lwbiSv4MRa9iBhS0RoNx3KgqV95hlhsOFzZkMvYzslT8
         d1BNroTTnuO6R5YyjdDH2raF031x/JOl1SKwo=
Received: by 10.236.155.1 with SMTP id i1mr27793705yhk.8.1318291793093; Mon,
 10 Oct 2011 17:09:53 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Mon, 10 Oct 2011 17:09:53 -0700 (PDT)
In-Reply-To: <7v1uukieh2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183277>

On Mon, Oct 10, 2011 at 5:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> So if we drop the "conditionally add '\n'" part in builtin/merge.c from my
> "how about this on top" patch and we should be ready to go, right?

Yes. I can send a followup patch adding an additional test case next
week (for the case where the editor zeros out the message).

Thanks Junio!

j.

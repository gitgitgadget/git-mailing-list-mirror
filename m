From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH 12/12] Add git-check-ignore sub-command
Date: Tue, 16 Oct 2012 07:09:51 -0700
Message-ID: <CAOkDyE_HCxNYpWVc0WCwhcAivEm+RLiFj-TwSsEbi+U5mZ3cww@mail.gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
	<1350282486-4646-1-git-send-email-pclouds@gmail.com>
	<1350282486-4646-12-git-send-email-pclouds@gmail.com>
	<7vlif7v03r.fsf@alter.siamese.dyndns.org>
	<CACsJy8Du1G-=pBbHW841V-61L9_HGmNkOE7EB2W2f1RJe9WuXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 16:10:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO7qO-0000SV-7S
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 16:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754086Ab2JPOJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 10:09:53 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62034 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754035Ab2JPOJw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 10:09:52 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so3027895bkc.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 07:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=1ysuiLJaQwdYeJRANLUNYwu6uOKbBHdHxblEysAmgzs=;
        b=t7To3S59dNnifc3YlDuC1EvnYhwQKBgDLLY+USu9OMNLNJPUAx/4/cKpiLU3C0kG5/
         /+61HCJp6/XinVqpWBSwEWgAllr7RQaZAOzcYA+K0jDilqqt+GoulMxWpt9j+Np2uo1t
         q/aqP/34uSRPytgDHIOuPWGLPtVn9Vpmol9UQWUkaNlcq+DSL6SIsPCfytF/Z1ytwjhx
         0fwSyrEB9LBvck9nPQVkflwyI54mwLjjd79YaMgrrNFiOiLZSNDXC/Z2u8mnEjTeYMBl
         JGmHLXqRQA/tj+2YKsNRT5tQePCfZOOSG80hMZGV38p3S11KsVqG8fE/4uC4v6d4Kx7K
         IVnA==
Received: by 10.204.4.129 with SMTP id 1mr4271286bkr.58.1350396591109; Tue, 16
 Oct 2012 07:09:51 -0700 (PDT)
Received: by 10.204.15.133 with HTTP; Tue, 16 Oct 2012 07:09:51 -0700 (PDT)
In-Reply-To: <CACsJy8Du1G-=pBbHW841V-61L9_HGmNkOE7EB2W2f1RJe9WuXg@mail.gmail.com>
X-Google-Sender-Auth: EJqkKaWcll5GE3wMvNkZkRJ672w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207830>

Hi again,

Firstly thanks very much for your recent work on this series!

On Tue, Oct 16, 2012 at 4:08 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Adam, do you have time to continue this series? I can help polish it
> for inclusion, but I don't want to step in your way if you are quietly
> updating it.

I was *intending* to finish it off soon, but I have been really busy
with work and other commitments recently, which has prevented this.  I
don't currently have any unpublished changes which would conflict with
your recent work, and I'm at a conference this week, so feel free to
carry on polishing if you want.  However I will probably have some
responses on the discussion about current issues, so it would be good
if I was given a chance to catch up on this discussion before the
series makes its way to master.

Thanks again!

Adam

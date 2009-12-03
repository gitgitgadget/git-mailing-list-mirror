From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] reset: add --quiet option
Date: Thu, 3 Dec 2009 11:33:47 +0200
Message-ID: <94a0d4530912030133n7e2fbf2asfea6e3896980dc7c@mail.gmail.com>
References: <1259492290-21771-1-git-send-email-felipe.contreras@gmail.com>
	 <1259543939.5679.5.camel@swboyd-laptop>
	 <94a0d4530911300219j51e21e2cwae17d4248400a345@mail.gmail.com>
	 <780e0a6b0911301345v42c2b22bs34092fb69b21a2a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 10:33:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NG84Q-0005Ov-6L
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 10:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729AbZLCJdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 04:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753725AbZLCJdm
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 04:33:42 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:58133 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbZLCJdl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 04:33:41 -0500
Received: by iwn1 with SMTP id 1so773617iwn.33
        for <git@vger.kernel.org>; Thu, 03 Dec 2009 01:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=bUSaOPJg/yn1GqINn2dHtRN0StUPbEDymo4NEAjnZNU=;
        b=vPnKWXI7seApv0aLEzlTjAfo0SbtHNdr3uV8w0cXxSnSl/6PNrhdg0khwFPkrrrPMN
         LkNLFhfpqPneimiet0hcnP/w5b4m0WV9XsaamgcdqzJOpkvlzEdqc1NSfSmSlW0a7fjL
         xqc8NNuHTqWTH1kwUS+a609k/boyahBPB1Oi8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=bMzaTUHnuBK6FGk+rHzi/7X/pQHRLikq/WGL6BFO7dXfMtclM2BNSdt71pbCTTJUuY
         WGKapAsuypSikIagO1rC8ITYGTyFpa2E5WM1JerOS3sTinH5Nss/4W4XvBa4tJ14V4K7
         5bsic9BnML58p48LZZAI0iObFK/FRPLwevmqw=
Received: by 10.231.161.138 with SMTP id r10mr2704101ibx.34.1259832827953; 
	Thu, 03 Dec 2009 01:33:47 -0800 (PST)
In-Reply-To: <780e0a6b0911301345v42c2b22bs34092fb69b21a2a0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134445>

On Mon, Nov 30, 2009 at 11:45 PM, Stephen Boyd <bebarino@gmail.com> wrote:
> If you're already touching the line why not just do it once? I agree a
> follow-up patch to cover the other commands would be good.

Because the less trivial the patches, the less luck I have of getting
them applied :)

Anyway, I sent a patch to use OPT__QUIET directly in two places.

-- 
Felipe Contreras

From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] Teach merge the '[-e|--edit]' option
Date: Fri, 7 Oct 2011 15:22:22 -0400
Message-ID: <CAG+J_Dzr188_sLCv+3BXP5M9d2by1VNiOGMcpewi4S4GMnOy2Q@mail.gmail.com>
References: <1318001347-11347-1-git-send-email-jaysoffian@gmail.com>
	<7vk48gwvyd.fsf@alter.siamese.dyndns.org>
	<CAG+J_Dz7-tTdgT=cqoKhK+fAhmESLnp93yHyxOF_NOY5Wx01+w@mail.gmail.com>
	<7vobxsvd69.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 21:22:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCG04-0004an-Ln
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 21:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126Ab1JGTWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 15:22:24 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55929 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017Ab1JGTWX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 15:22:23 -0400
Received: by ggnv2 with SMTP id v2so3061142ggn.19
        for <git@vger.kernel.org>; Fri, 07 Oct 2011 12:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0MNXow9wP6MbIQVdtyKjXIuIQPINCPOVCB8iREBL+DQ=;
        b=CRi0YLbQowMpLxWdoh42xTPKhrbr+87yiEyFmBO3DnduvPenHzdHzJ+wged8H5GgCG
         IoFqNXs9KaEGYqBbn0edTFDmqAU6ug/3bTDFv78WHveJJjxmZ2X+eM9/5qYCH4V+mW1b
         XxjWkvrRC+SbiIbdJjZlKoXwksqTdXAsLPFw0=
Received: by 10.147.154.12 with SMTP id g12mr1837748yao.36.1318015342787; Fri,
 07 Oct 2011 12:22:22 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Fri, 7 Oct 2011 12:22:22 -0700 (PDT)
In-Reply-To: <7vobxsvd69.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183099>

On Fri, Oct 7, 2011 at 3:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Think about it. What I suggested does no way make the situation
> worse. Your patch _does_ make it worse by changing the hook behaviour
> between "merge -m 'foo'" vs "merge -m 'foo' -e"

I think it's arguable how -e should behave. With -e opening my editor,
now I really feel like I'm making a commit and would be surprised by
not having the various commit hooks run.

j.

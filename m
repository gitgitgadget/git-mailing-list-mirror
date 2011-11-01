From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: t5800-*.sh: Intermittent test failures
Date: Tue, 1 Nov 2011 22:57:21 +0100
Message-ID: <CALxABCbnZp-y0Fqzoa=Ab92P+hsT7hs3nXZsnA=ph3yGfkXhdA@mail.gmail.com>
References: <4E417CB4.50007@ramsay1.demon.co.uk> <CAGdFq_jv_T-x7VGqm_j-fDfeW6TsBG95=1TWn91Yk9B3TGZdsQ@mail.gmail.com>
 <7vpqjgyvn1.fsf@alter.siamese.dyndns.org> <4E68FE73.4000005@ramsay1.demon.co.uk>
 <20110908182055.GA16500@sigill.intra.peff.net> <4E6D089C.4090006@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Nov 01 22:57:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLML5-0002Os-Cv
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 22:57:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159Ab1KAV5o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Nov 2011 17:57:44 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34792 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756059Ab1KAV5m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2011 17:57:42 -0400
Received: by mail-vw0-f46.google.com with SMTP id 1so438413vws.19
        for <git@vger.kernel.org>; Tue, 01 Nov 2011 14:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=t6/9Ce1673JojMKTnQY7qsekCM+FL9Y+aI6AfXlmEZE=;
        b=Ck3FcVbxh4L0CEcTAVHB9/NNOZ/xcV/obkuNf3SBuui9BDvaMZcUc1ALC/ERw0xlFg
         Yj8dbVHLT5/YsS5fsLj+prFZzU3x72Gvu7y43InUS4m45gie/FJ3U/dpIUmAB+lPz17V
         mPJAGzDxBdlCc3I1YzMwl/zlljj+iZp5mjYGQ=
Received: by 10.182.152.37 with SMTP id uv5mr299984obb.53.1320184662136; Tue,
 01 Nov 2011 14:57:42 -0700 (PDT)
Received: by 10.182.193.100 with HTTP; Tue, 1 Nov 2011 14:57:21 -0700 (PDT)
In-Reply-To: <4E6D089C.4090006@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184597>

On Sun, Sep 11, 2011 at 21:14, Ramsay Jones <ramsay@ramsay1.demon.co.uk=
> wrote:
> ... these hangs *are* the failures of which I speak! =C2=A0Yes, the s=
cript
> doesn't get to declare a failure, but AFAIAC a hanging test (and it
> isn't the same test # each time) is a failing test. :-D

Was there any outcome of this discussion? I'm asking because I
can reproduce this very reliably on a little server here.

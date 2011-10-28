From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] blame.c: Properly initialize strbuf after calling, textconv_object()
Date: Fri, 28 Oct 2011 18:32:15 +0200
Message-ID: <CAHGBnuPUGfOe1D_OZ0ga4s8EiS_=GZeBG7WLmyOHt7vNg+w3Fw@mail.gmail.com>
References: <4EAACA1C.6020302@gmail.com>
	<7vlis5t8bf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 18:32:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJpLx-0002eL-NH
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 18:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756053Ab1J1QcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 12:32:16 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:41242 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836Ab1J1QcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 12:32:16 -0400
Received: by vcge1 with SMTP id e1so3533078vcg.19
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 09:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3rI9XjMXshPNXsF8cASYT5f+6daRPdrNpB/H9ahxRaw=;
        b=vNQUcHBBhruqj/L5jLhJ1xRoGKg+3PqZ23EizEjYTuS7O8veViyw2DsleWXaj1VosW
         osh25E4RHlmfArmyu5GH+PCLoc0VWUseyXmmFypDpvrbKmWQQqJEWlbO3ZlaAxSXEV4M
         Fs+AqmSJ0FR1MhA/WN7Mc2PE/GR+PzoWCj2lE=
Received: by 10.220.117.130 with SMTP id r2mr524300vcq.85.1319819535147; Fri,
 28 Oct 2011 09:32:15 -0700 (PDT)
Received: by 10.220.175.202 with HTTP; Fri, 28 Oct 2011 09:32:15 -0700 (PDT)
In-Reply-To: <7vlis5t8bf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184416>

On Fri, Oct 28, 2011 at 18:00, Junio C Hamano <gitster@pobox.com> wrote:

> Thanks; do you have no addition to the test suite to demonstrate the
> breakage?

Not yet. I'll try to come up with something.

-- 
Sebastian Schuberth

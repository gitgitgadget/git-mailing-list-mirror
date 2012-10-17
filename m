From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Add new git-remote-hd helper
Date: Wed, 17 Oct 2012 11:18:05 -0700
Message-ID: <CAGdFq_i4c=ei4ni5bv9nNEbCfNG4sbRkqyip2voW17GhkRAKPQ@mail.gmail.com>
References: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com>
 <alpine.DEB.1.00.1210171759230.3049@bonsai2> <CAMP44s1WY+Q7jyy4PQvwff7JSxHsnkhrPWozOLnNuNOrn7FGBA@mail.gmail.com>
 <alpine.DEB.1.00.1210171936170.3049@bonsai2> <CAMP44s2=hhMz35SpYXMBLcQPfVaPxY4pBWZDF7zbqVwz=tbedA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 20:19:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOYCn-0001N7-KE
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 20:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756541Ab2JQSSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 14:18:46 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:59523 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846Ab2JQSSq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 14:18:46 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so723907qad.19
        for <git@vger.kernel.org>; Wed, 17 Oct 2012 11:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eFbEkagdlbWQZ8hytQBenp1Odv4HmAP69L2EH2SDj9A=;
        b=HObfTftrTGVOzhIsheKY8kcqptnQLkH+lhzz7ucmVgNRJZIAZ4QedrqPZN6BZdutAL
         8bKSfOKnlG1nZsgJdW1RCaGgDXli+gJ0vVGj0Lvt4kfXOlzJ6VnUYuTiSThbWhA+MRkh
         zG8B55PWOSiqEgvLXHovVIVpQFNjuZ7qoFfi5VbsqSnOg2aZLAq1XpRd6X0ncByrWsf3
         oHpSFBN1UDbpXVXiUeXS9lNHL4DVs8eWRqnpgTsK5dmvAaH8OWmXj16D2mlycqmeriZs
         4KurV/EfkbtIfY6h3b8jF5lza66B9YDlgf3Tz8VIxVzq29mqTZThiNYsCLad5h7w2wd7
         2KBA==
Received: by 10.224.196.132 with SMTP id eg4mr33215653qab.93.1350497925441;
 Wed, 17 Oct 2012 11:18:45 -0700 (PDT)
Received: by 10.49.36.195 with HTTP; Wed, 17 Oct 2012 11:18:05 -0700 (PDT)
In-Reply-To: <CAMP44s2=hhMz35SpYXMBLcQPfVaPxY4pBWZDF7zbqVwz=tbedA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207929>

On Wed, Oct 17, 2012 at 11:12 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> But fine, lets remove the tests out of the equation (150 lines), the
> number of lines of code still exceeds 3000.

I don't think it's fair to just look at LOC, git-remote-hg when it was
just parsing was fairly simple. Most of the current code is our copy
of the python fast-import library which is only used to support
pushing to mercurial.

-- 
Cheers,

Sverre Rabbelier

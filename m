From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] transport-helper: call git fast-import properly
Date: Wed, 17 Oct 2012 22:13:16 -0700
Message-ID: <CAGdFq_jNs_CNN8PGbbgvJbmNTSSN9TaEDxCSyDEpScZL4zyiwg@mail.gmail.com>
References: <1350462440-427-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 07:14:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOiQr-0000Te-Ix
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 07:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753977Ab2JRFN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 01:13:58 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:56532 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871Ab2JRFN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 01:13:57 -0400
Received: by mail-qc0-f174.google.com with SMTP id o22so2620374qcr.19
        for <git@vger.kernel.org>; Wed, 17 Oct 2012 22:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ROjLm+UkzezPuO7XgGomz2/M1rm89IkdhP3XEEWFMuE=;
        b=Ko9gHCblDhxgSdCGpdQgtEfCNFTDMKQoG7SgpGYam35lwAFOBG7V+pfsY4vAAb8Jdx
         t78cfZoUz0DvsAzy9etEAsiKWCDfR462bj66Vgw/kBC2uGdOjOumk1nziOLwOAxnNrT/
         I2lxOQvbmVTCV6eKSNWGIs/072Fg3llIKm5qRr1AE/sbMnl7dBslgPyiM7b+XNu6SviF
         DgjiQET71H2ZeWuuZJLZK8v3kQ9hpvsJiRipq1nqFmxixL9ESRQe0PIa/8TZm5cA+yN5
         tqnRFCUZqNca1tw1OIagIZkf4GjByS+Huvj4pN7a+4jFAR2vrkCsGE6+L/KM+3hcXP1Q
         PsVQ==
Received: by 10.49.1.43 with SMTP id 11mr46200292qej.41.1350537236410; Wed, 17
 Oct 2012 22:13:56 -0700 (PDT)
Received: by 10.49.36.195 with HTTP; Wed, 17 Oct 2012 22:13:16 -0700 (PDT)
In-Reply-To: <1350462440-427-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207957>

On Wed, Oct 17, 2012 at 1:27 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> The marks options are being ignored right now.

It seems unlikely to me that this never worked, surely no reviewer
would accept a patch that doesn't actually implement the feature?
What's the history here?

-- 
Cheers,

Sverre Rabbelier

From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] For Real - Fixed pluralization in diff reports
Date: Mon, 1 Aug 2011 20:32:51 +0200
Message-ID: <CAGdFq_j0Hr4LMaFC3irS8rhv2N0ePz_t8xpNTDCA-arC-E2UDA@mail.gmail.com>
References: <4E362F8E.1050105@gmail.com> <CAGdFq_iwEvD_-hD63KeF45WuRhWrK6JuWWqzDpjHcZ+0gHDaqg@mail.gmail.com>
 <4E36B8E4.5080900@gmail.com> <20110801180603.GB10636@sigill.intra.peff.net> <4E36F025.9040100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
To: Jon Forrest <nobozo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 20:33:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnxJ2-0004CE-Mi
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 20:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673Ab1HASdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 14:33:33 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:55464 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab1HASdb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 14:33:31 -0400
Received: by pzk37 with SMTP id 37so11945698pzk.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 11:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jw9RpPcAsLKkybfr8b1eR1xnPG19IGE2lWt8wLKHqw0=;
        b=jBalIsiarOMGnUatI5TGD6JxrRRhP4flp7zqC7AMYaVtYrYvLFe4scBygfeIm9zl8w
         /B8rd5NqNPG8DrFg6DdyFUcxicAQnfAbfH0LGi/OkkL8k7hoz7pICRXjy223GSG+YrTU
         J4P3pC3Aod1P644SqaYNjWlZ1Cn9aMv25O7wc=
Received: by 10.68.50.67 with SMTP id a3mr8815359pbo.377.1312223611066; Mon,
 01 Aug 2011 11:33:31 -0700 (PDT)
Received: by 10.68.71.162 with HTTP; Mon, 1 Aug 2011 11:32:51 -0700 (PDT)
In-Reply-To: <4E36F025.9040100@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178399>

Heya,

On Mon, Aug 1, 2011 at 20:27, Jon Forrest <nobozo@gmail.com> wrote:
> I entirely agree. My point is only that the various tests
> that expect the current behavior will have to be changed
> whether the implementation of correct plurals uses my
> inferior method or the way more correct i18n method.

Wouldn't it be a nice hack if we just solved problem through i18n
then? Have all the plumbing see the current wording, but through i18n
change it to something grammatically correct for the porcelain.
Probably not possible, but a nice daydream :).

-- 
Cheers,

Sverre Rabbelier

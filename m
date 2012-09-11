From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: How to update a cloned git repository
Date: Tue, 11 Sep 2012 19:39:21 +0530
Message-ID: <CAMK1S_jXA0WfC-de=mD7-+2oJiep_A2rKSZdSsqn7CcNJPsq5A@mail.gmail.com>
References: <k2n4v2$88t$1@ger.gmane.org>
	<vpq7gs0es4f.fsf@bauges.imag.fr>
	<006f01cd900e$fce59a60$f6b0cf20$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Tue Sep 11 16:09:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBR9f-0007x5-K1
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 16:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755584Ab2IKOJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 10:09:23 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:47721 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753790Ab2IKOJX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Sep 2012 10:09:23 -0400
Received: by lagy9 with SMTP id y9so341464lag.19
        for <git@vger.kernel.org>; Tue, 11 Sep 2012 07:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=srmadO1BWsC0ilTvF7otLdKo00kyWurxBAufrqxNVBc=;
        b=lb3mhuAtTKcqYjutQE1WExULnLi+prfKQYRI2RPpt5oHAOt5z9l1MP1HvnxchWVo1I
         xEZ8ohzLPwgZkPMoSXz333inEG/TX3NS8PwQrSezGd1AGRSdj9TwZAD58ilShuNPJAIS
         P4fT2/sUdusEs5Gt2uGFtqDd9lgt41oPM8hGG4GuRCEHOVATg+s4SaO2Hj5A6bWUV/tP
         Gg2TUEmwWvh5X2LIEg36N/RASBXu+7lTeKOmgR8PLVP4YTqrr7o+0GHePqQcsZlSrMAk
         +MH9LLh5AylWLwbTDyJQ21RCHq24V0V/azeOS1+HiX88iDkTpGFScNR0S/Qe+/HSt9WP
         StzQ==
Received: by 10.152.162.10 with SMTP id xw10mr15787176lab.12.1347372561649;
 Tue, 11 Sep 2012 07:09:21 -0700 (PDT)
Received: by 10.112.129.227 with HTTP; Tue, 11 Sep 2012 07:09:21 -0700 (PDT)
In-Reply-To: <006f01cd900e$fce59a60$f6b0cf20$@schmitz-digital.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205231>

On Tue, Sep 11, 2012 at 4:47 PM, Joachim Schmitz
<jojo@schmitz-digital.de> wrote:

> Like this?
> git pull --rebase HEAD~42
>
> So far I create patches, wiped out the entire repository, cloned, forked and applied the changes, pretty painful.

I think a 'git pull --rebase' should usually work even for 'pu'.

But sometimes pu may have changes that take away the basis for your
patch (i.e, not just a restructure) then you'd get conflicts.

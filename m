From: Jonathan Nieder <jrnieder@gmail.com>
Subject: When is a patch ready for inclusion? (Re: [PATCH]
 Documentation/git-pull: clarify configuration)
Date: Wed, 10 Nov 2010 11:25:43 -0600
Message-ID: <20101110172543.GC11513@burratino>
References: <1289336209-28222-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <20101110034846.GB2401@burratino>
 <AANLkTik5MMKWune_i6omu=vXmuVEJqff6Bm0=yNcS9+z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 18:26:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGER4-0007dd-F8
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 18:26:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086Ab0KJR0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 12:26:05 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61415 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074Ab0KJR0E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 12:26:04 -0500
Received: by vws13 with SMTP id 13so62321vws.19
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 09:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Gs1bY78GKtBFrXZant5EJC93NeG585WX4EqyagfHqUk=;
        b=Z3b9JUO6mSq2kNoOWCM5welB/paw0Sy+k/QsAxs5mx66rYYeEW21ZwuIrvf9GUiLAj
         2YUIKuZ7IoFODVddfsJnmNDOMHwLWaZUQozj3D5OmHOnjAW9UKqDPOQFzd/2610Sza9q
         HmdA2CFNZueewilLUN3kNwzRdFHtla9aMSCmA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ux+XnIANuWlj/FbTuv2GWP6E9Pqd18rVeGEovOqdKQojWi23nVhen4AZPbZVvopA7+
         yZypyGaEEQS1YzwaKx1aY3q8MLKsZELZz1Ml3onoug8p6yL2HqQ1yi7wDCNAT5VmKRHQ
         7PmpQ9keWF3Oor7qN4+Mfx1mxZdpZ1umXtpxw=
Received: by 10.220.85.19 with SMTP id m19mr1683694vcl.77.1289409962731;
        Wed, 10 Nov 2010 09:26:02 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id v20sm282439vbw.19.2010.11.10.09.26.01
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 10 Nov 2010 09:26:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTik5MMKWune_i6omu=vXmuVEJqff6Bm0=yNcS9+z@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161162>

(cc-ing the list because it seems likely the wording could be improved)

Hi Martin,

Martin von Zweigbergk wrote:

> I don't want to spam Junio, so I'm asking you instead. I sent my first
> version of the patch to Junio as well. In SubmittingPatches, it says
> "[...] the maintainer (gitster@pobox.com) if (and only if) the patch
> is ready for inclusion". How do I know if it's ready for inclusion?

I think that bit is not too important.  The idea (and it isn't spelled
out) is that you should Cc Junio if:

 - you need Junio's advice because it is his area of expertise, or
 - Junio has already been discussing the patch with you, or
 - it is urgent that the patch be applied

and you probably should not Cc Junio if:

 - the patch is unpolished and covers a subject that is not his
   interest (e.g., something in contrib/)

>                                                               Or is the
> "ready for inclusion" just about my perception of my patches?

Yes.  Hopefully this would make it easier to spot which patches are
ready for his attention and which need more discussion first.  See [1]
and [2].

Hope that helps,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/72432/focus=72442
[2] http://thread.gmane.org/gmane.comp.version-control.git/144199/focus=144506

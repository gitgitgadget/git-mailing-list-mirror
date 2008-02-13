From: "Elijah Newren" <newren@gmail.com>
Subject: Re: [PATCH] upload-pack: Initialize the exec-path.
Date: Wed, 13 Feb 2008 06:00:33 -0700
Message-ID: <51419b2c0802130500v9753ebeg934e2d02c9e363f7@mail.gmail.com>
References: <51419b2c0802111822k4600e06bp4167a09b30bf947a@mail.gmail.com>
	 <m31w7iegk6.fsf@localhost.localdomain>
	 <47B15ADC.8080309@viscovery.net>
	 <alpine.LSU.1.00.0802121028290.3870@racer.site>
	 <47B182C1.60006@viscovery.net>
	 <alpine.LSU.1.00.0802121149220.3870@racer.site>
	 <alpine.LSU.1.00.0802121245140.3870@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 13 14:01:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPHEc-0005Xv-9G
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 14:01:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757008AbYBMNAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 08:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757029AbYBMNAg
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 08:00:36 -0500
Received: from wr-out-0506.google.com ([64.233.184.226]:17058 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755667AbYBMNAf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 08:00:35 -0500
Received: by wr-out-0506.google.com with SMTP id c48so5692wra.23
        for <git@vger.kernel.org>; Wed, 13 Feb 2008 05:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=H+7xltsypEbz7wkRhhmEVgvDrjPewDKlb2FJ4uoyWqw=;
        b=dRDARPV8ebC9PkBov6gzQ7ndoK2icmO3x63CPeZ8+J13TPm9X1xboVpvGN08QAnPDYzfSG6dGktAc8PlNdqPdwBaYNMtgUj19bzw5G09hRoXzsk2kVOADoz/7CZaRhTbELvk+LNxSLc4gwDRPYicGe0r4UkJN12/mM1ewAAK7so=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=wB8GdyGnbugG26MdDo2kq72S2cvNDBPm0N9b7HHriRf8N1UsC45IwiRsDRL4UB5zD32xQqaD9SQn9QLpwjK5vwDigr9xTeGAtUu3AHYV/VsK2WsRr3ndZgxC+FviAjxFAXltQiymCqB3QwQQZ0roLWOITIHhtiQSmfY0Z56ck6Q=
Received: by 10.114.181.1 with SMTP id d1mr2912543waf.10.1202907633600;
        Wed, 13 Feb 2008 05:00:33 -0800 (PST)
Received: by 10.114.205.19 with HTTP; Wed, 13 Feb 2008 05:00:33 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802121245140.3870@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73784>

On Feb 12, 2008 5:45 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Tue, 12 Feb 2008, Johannes Schindelin wrote:
> > On Tue, 12 Feb 2008, Johannes Sixt wrote:
> > > Johannes Schindelin schrieb:
> > > > So, let's make git-upload-pack a builtin, no?
> > >
> > > How about this (almost) one-liner instead?
> >
> > I'm fine with it.
>
> But I also made this:
>
> -- snipsnap --
> [PATCH] Make upload-pack a builtin
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
<snip>

I tried this patch yesterday, but it seems to suffer from the same
problem?  I had to manually apply the patch from Johannes Sixt on top
of this ("manually" since there was a trivial conflict) in order for
it to solve the problem.

Anyway, it works for me now.  Thanks for the quick fixes!

Elijah

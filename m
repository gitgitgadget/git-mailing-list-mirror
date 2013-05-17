From: Eugene Sajine <euguess@gmail.com>
Subject: Fwd: Fwd: git cvsimport implications
Date: Fri, 17 May 2013 12:10:03 -0400
Message-ID: <CAPZPVFbkcmBH7OPeP83gPnSGodoi_9diAUk-5dtR43dCDRfkwQ@mail.gmail.com>
References: <CAPZPVFYFL6OS2HWbF0BKNKtNsZ6CfpWmKCypGxeTs7W8-76q8Q@mail.gmail.com>
	<CAPZPVFZLDwLNazvBh5n=Jg_=CZUNz3yTme4JW2NutPgjPzwtLg@mail.gmail.com>
	<7vfvxpfbli.fsf@alter.siamese.dyndns.org>
	<51932A1A.4050606@alum.mit.edu>
	<CAPZPVFZTZFQrCF3gcwcff5LFm9MHhZm-DauLvfzCYrMTw4nQfA@mail.gmail.com>
	<5195F3EB.8000308@alum.mit.edu>
	<CAPZPVFZ6HjFYaPOqcrwhCCdGhYUaVEjyDeaL8dcsqy1ghcfWpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 17 18:10:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdNEQ-00086m-RH
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 18:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756063Ab3EQQKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 12:10:04 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:55492 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366Ab3EQQKD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 12:10:03 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so9709864ief.12
        for <git@vger.kernel.org>; Fri, 17 May 2013 09:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=5/MLXDltgiZazrieL5+TQge0ZqKt7VcK2O5A2jrbQRc=;
        b=q3kVrXtNB9fvgWZZhh3Qh4314MpcydsHk46G61EDLTOU6GWNZTSY+paIYnvyRfAlmz
         KGHyFEtORX+Uti1fbGA6FWqmt39pItvg7vcYbeORYsggCYWDm3Wf2e6974z/tptYdHln
         Vwa9VsIj0qHXL8WGJ8K2aEN7JNO3NZ3xHt2tdiQDgwGxSZ2KDUOcWTIeWFX+Ilqpj+0q
         do44Fyfys5G9ZNGToQRbt+l6dOv/4aFJV4l3XtEhh+64NhnhI+NHdn8VSaWKuYeZVOTD
         Q9bFKyKToW/vi77gJHAKfTRl34Z5WgJxgPCl0m3pckWdOwMwFl0/MpdGDlKbLUjJ2WSV
         8Pdg==
X-Received: by 10.50.73.65 with SMTP id j1mr13565494igv.49.1368807003416; Fri,
 17 May 2013 09:10:03 -0700 (PDT)
Received: by 10.42.150.130 with HTTP; Fri, 17 May 2013 09:10:03 -0700 (PDT)
In-Reply-To: <CAPZPVFZ6HjFYaPOqcrwhCCdGhYUaVEjyDeaL8dcsqy1ghcfWpg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224697>

MIchael, sorry for dup - didn't press reply all for the first one.

>
> So what are you going to do, use cvsimport whenever you cannot *prove*
> that it is wrong?  You sure have low standards for your software.

1. You are making assumptions and conclusions that have no grounds.
I asked for help understanding what are the problems of cvsimport.
Never i said i'm not willing use cvs2git. Never i said I'm happy to have
problems in my git repos. So, this "low standard" punch was... not necessary.

2. I started to use cvsimport because it was the tool *provided with
git* about three years ago.
By that time i didn't find any better and simpler tool to use and
those implications were uknown for me,
they were brought up to my attention just recently.
CVS is not good for branches, so most of our projects didn't have any
cvs branches.
So for majority of those it seems that the cvsimport did it's job just fine.
Now we are going to try to migrate some projects that are using CVS
branches heavily.
That concerns me, so i'm looking for better tool.

3. Is there a way to have the whole plumbing with the
blobfiles and dumpfiles and consequent git fast-import wrapped into
nice command like:

git cvsimport -C path/to/my/new/shiny/gitrepo

Or are there any particular reasons why end user must deal with blob
and dump files and do fast-import afterwards?

Thanks,
Eugene

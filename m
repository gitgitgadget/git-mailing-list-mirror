X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Diffs from CVS keyword expansion
Date: Fri, 1 Dec 2006 10:33:03 -0500
Message-ID: <9e4733910612010733x4dea2451r6fc64d2e867735a@mail.gmail.com>
References: <9e4733910611301956l6f64b01ftee46971a18e3467b@mail.gmail.com>
	 <17775.54363.376000.140259@lapjr.intranet.kiel.bmiag.de>
	 <Pine.LNX.4.64.0611302340030.3695@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 15:35:30 +0000 (UTC)
Cc: "Juergen Ruehle" <j.ruehle@bmiag.de>,
	"Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NBzGeuc3fAvN7f2Mzq7alc6Ai+BQ5jrKJJgzTj5CzKLjJxEi9DGugRYGNhuI6PrPk3GDPW4eceI4pe+Y/7twBMSgIUIDEvfD/lu1QYxS2bqxEpzrcFAVKsAkRUWNBIVF+Jbrex6r08QQbBhsPZLIUI290IGr39COxVthwYvbURo=
In-Reply-To: <Pine.LNX.4.64.0611302340030.3695@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32937>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqAO7-0004Db-I4 for gcvg-git@gmane.org; Fri, 01 Dec
 2006 16:33:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936039AbWLAPdH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 10:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967548AbWLAPdH
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 10:33:07 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:21799 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S967383AbWLAPdE
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 10:33:04 -0500
Received: by py-out-1112.google.com with SMTP id a29so1831845pyi for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 07:33:03 -0800 (PST)
Received: by 10.35.54.1 with SMTP id g1mr8879189pyk.1164987183789; Fri, 01
 Dec 2006 07:33:03 -0800 (PST)
Received: by 10.35.72.13 with HTTP; Fri, 1 Dec 2006 07:33:03 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 12/1/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Fri, 1 Dec 2006, Juergen Ruehle wrote:
>
> > Jon Smirl writes:
> >  > Anyone have a nice script for suppressing diffs caused by CVS keyword
> >  > expansion when someone checked the kernel sources into CVS?
> >
> > I usually just say (with GNU diff)
> >
> >   diff -I $$ ...
> >
> > which is crude, but should be enough to get rid of the hunks listed by
> > you.
> >
> > You might also want -x CVS if you have the metadata files.

I don't have the original CVS, just a tarball snapshot with the
keywords expanded.

I'm working with the Freescale iMX21 and the Linux port for it has
never be added to the mainline kernel. I am extracting bits and pieces
of it from various vendor tarballs.


>
> Also, if you are actually _using_ CVS to check it out, use
>
>         cvs co -ko
>
> I think, to not check out with keyword expansion at all.
>
> (Also usable with "cvs diff -ko", I think)
>
>                 Linus
>
> PS. Clueless user alert: I have happily not used CVS in years and years,
> and I might remember that all wrong.
>


-- 
Jon Smirl

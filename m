X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] Add branch.*.localmerge and documentation update
Date: Fri, 8 Dec 2006 23:15:28 +0100
Message-ID: <8aa486160612081415h30a35c09lc273fd34f1dbceed@mail.gmail.com>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com>
	 <200612082012.19167.Josef.Weidendorfer@gmx.de>
	 <8aa486160612081252t1e245104x58c8a6654d887af5@mail.gmail.com>
	 <200612082239.38423.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 8 Dec 2006 22:15:43 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Aneesh Kumar K.V" <aneesh.kumar@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jhK+NiiH0ajKLDtiMLHY3GrZYRvXNoaoQqH8y6fvqOOVvnYkBKZP9gUjSe7PSeuH3fT1pNDDObzG07agR5btgbP40mFwOEjdqtWQSkUIRIdOBZNwRqxZ+5NCdfAO09jk1iNPStHMgsSiRpDoRaOAYzAAdimYu0lKyT232JVeUZ0=
In-Reply-To: <200612082239.38423.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33758>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gso0H-0005We-31 for gcvg-git@gmane.org; Fri, 08 Dec
 2006 23:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947441AbWLHWPb convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006 17:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947437AbWLHWPb
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 17:15:31 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:22561 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1947441AbWLHWPa convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 17:15:30 -0500
Received: by wx-out-0506.google.com with SMTP id h27so930349wxd for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 14:15:29 -0800 (PST)
Received: by 10.70.66.18 with SMTP id o18mr6800839wxa.1165616128770; Fri, 08
 Dec 2006 14:15:28 -0800 (PST)
Received: by 10.70.45.1 with HTTP; Fri, 8 Dec 2006 14:15:28 -0800 (PST)
To: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

On 12/8/06, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> On Friday 08 December 2006 21:52, Santi B=E9jar wrote:
> > On 12/8/06, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> > > Clarify the meaning of branch.*.merge option and add a similar
> > > branch.*.localmerge option, which can be used to specify a local
> > > tracking branch to be merged by default.
> > >
> > > Previously, if branch.*.merge was specified but did not match any
> > > ref, the message "No changes." was not really helpful regarding
> > > the misconfiguration. This now gives a warning.
> > >
> > > The value of branch.*.merge can be a list to get an octopus
> > > merge. I chose the same way for branch.*.localmerge, and if
> > > you specify both options, the octopus merge will have even
> > > more parents ;-)
> > >
> > > Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
> >
> > Ack for the documentation part. But the localmerge part is almost
> > equivalent to my patch to allow the branch.<name>.remote equal to "=
=2E".
>
> Interesting. I did not have a look at your patch.
> The support for the "branch.*.localmerge" option is one step to be
> able to support a remote ".". So of course, it probably is similar.
> I even would say that "." as remote now actually makes sense as
> logical extension.
>
> However, what would you change in the implementation part of my patch=
?

I would only take the documentation part (without the localmerge part)
and the test for the warning.


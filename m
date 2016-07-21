Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDAF4203C2
	for <e@80x24.org>; Thu, 21 Jul 2016 14:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbcGUO3g (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 10:29:36 -0400
Received: from mout.gmx.net ([212.227.15.19]:53971 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751553AbcGUO3e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 10:29:34 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lz3nU-1bCqwS01C4-014AVR; Thu, 21 Jul 2016 16:29:12
 +0200
Date:	Thu, 21 Jul 2016 16:28:26 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff Hostetler <git@jeffhostetler.com>
cc:	Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
	peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH v1 1/6] Allow --porcelain[=<n>] in status and commit
 commands
In-Reply-To: <578F9AE8.4000407@jeffhostetler.com>
Message-ID: <alpine.DEB.2.20.1607211624190.14111@virtualbox>
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com> <1468966258-11191-2-git-send-email-jeffhost@microsoft.com> <alpine.DEB.2.20.1607201600050.14111@virtualbox> <578F9AE8.4000407@jeffhostetler.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:2jqa1stHHYYTbSPSumceZ6HDEwuSxXCDmmkGZscoOk4gYkcFfiF
 LyNiq1fbs0rSVoNgHjdvJvcscg83PtfMRQP/0FKzHu0dNSRd1hppbeDNcAXroHalUHoVvPF
 +iik0OkaeBmU/D4nD5vVuAnNnYMSSCfeCWYlVJjnRpPstAmlQe7eoXpLgtZKDzkjVMdvLIw
 WnMhhScFCRPKTzonyWbXg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:9eZMeZV3+C8=:AQLFBACj8tK9/39GoKGWTY
 cFyY6fCqZhi+T7A6oNm8Ehzez2MWL8ZYJe0ifyQXsH0ZdIxycb7K1b8iQoNEAqxZcHDZRg2ZB
 2jhFHw/Jm6zJjsd7mtjlgTY/Vq+CSVRhPORQxu1AmjxQEV+AkoU1vDhdPp02QNUvOQWpXFgTb
 e4t3Bo4PzO/hBx/Xd24i52hNWO5I1Rt0fA8rkI+SWn8erGvxRae1CiY+g6ATeiRXlL1q7+L6E
 i2VB1zqvcI9CEZIMGjvH5wLCCflR0SCBGkhCjHTW+46+BLjxVJbM8hzte8v42ETzi7+RcnHI1
 Rg+QMKA5EVvdzHh4tFLKeKJ8j693b2LMiInjoOj5VCgd4niFu2MsW7OWMCVfVYxJ9IJH0NYFq
 DoXyqoJTiju0M+K0Y7eg2pZllERzyF2zXZ3ZUEtva0nRFpPeWl6ZfZjPvifrFQx4i32TSpZq4
 aT1q5ia9zKg+HT3gi6mSoijlgsf4l/QnjHrSyXlNDPVaQbVL65QdolCrF3KTNJmjeDnBEfwdI
 gKWn07F8GeeFnJyT0rYPgRlkwgn6HI6mFVZ4uyyHFbtD8ABP/qy7FFY4DV3Mtcrj9k5E6hdEh
 GZFOE1cdryEl7pHmsIseNdlw45R9s7j911TDefUYOdYBWLS1VbJ+0L3+NJJdepBH9pybPii/9
 gDU8WpBTAKFyDUq7YZIWkK9zpn3OCX0RcVP6spHcKMynBj6L98+Bd+9GY3UrO58cvTlPsrMLT
 S3YiPHqsgdpb0icsy+KWPt1FleZVYzeuGTjLO8tPHJm/TqglfYBBWksztuyUQcPFzeyOuGR1i
 Fq2X3Mn
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Jeff,

On Wed, 20 Jul 2016, Jeff Hostetler wrote:

> On 07/20/2016 11:08 AM, Johannes Schindelin wrote:
> > On Tue, 19 Jul 2016, Jeff Hostetler wrote:
> > > @@ -1336,9 +1347,9 @@ int cmd_status(int argc, const char **argv, const
> > > char *prefix)
> > >     	    N_("show status concisely"), STATUS_FORMAT_SHORT),
> > >     OPT_BOOL('b', "branch", &s.show_branch,
> > >   			 N_("show branch information")),
> > > -		OPT_SET_INT(0, "porcelain", &status_format,
> > > -			    N_("machine-readable output"),
> > > -			    STATUS_FORMAT_PORCELAIN),
> > > +		{ OPTION_CALLBACK, 0, "porcelain", &status_format,
> > > +		  N_("version"), N_("machine-readable output"),
> > > +		  PARSE_OPT_OPTARG, opt_parse_porcelain },
> >
> > How about using a COUNTUP here instead? We could then set the status
> > format afterwards, like this:
> >
> >  if (porcelain == 0)
> >  	status_format = STATUS_FORMAT_UNSPECIFIED;
> >  else {
> >   status_format = STATUS_FORMAT_PORCELAIN;
> >   if (porcelain > 1)
> >    warning("No porcelain v%d; falling back to v1",
> >  			porcelain);
> >  }
> >
> 
> Maybe I misread the COUNTUP docs, but it looked like it would
> allow "--porcelain --porcelain", but not "--porcelain=2".

Whoops, you're right. It is *I* who misread the code (I did not bother
looking for the docs ;-))

Still, I would prefer to avoid that callback. IOW something like

	{ OPTION_INTEGER, 0, "porcelain", &status_format,
	  N_("version"), N_("machine-readable output"),
	  PARSE_OPT_OPTARG, NULL, 1 },

followed by the if () outlined above.

Ciao,
Johannes

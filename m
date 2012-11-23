From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: [PATCH 0/8] fix git-config with duplicate variable entries
Date: Fri, 23 Nov 2012 11:37:51 +0100
Message-ID: <k8njm8$b1l$1@ger.gmane.org>
References: <CACBZZX4cu9XuS5AtduWrNeXNUeZ4rqDUzRdmyz2b3cXtmo1nqQ@mail.gmail.com> <20121022211505.GA3301@sigill.intra.peff.net> <CACBZZX5mOb7_i9r8AqNK5V3r-gVnzN+rkeY9xrhecGv1rS-anA@mail.gmail.com> <20121023223502.GA23194@sigill.intra.peff.net> <7vsj84rt1g.fsf@alter.siamese.dyndns.org> <20121121192738.GA16280@sigill.intra.peff.net> <7vehjm20yu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 11:38:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbqee-0003V3-HD
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 11:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489Ab2KWKi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 05:38:26 -0500
Received: from plane.gmane.org ([80.91.229.3]:47476 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640Ab2KWKiY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 05:38:24 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TbqeT-0003KU-M1
	for git@vger.kernel.org; Fri, 23 Nov 2012 11:38:29 +0100
Received: from dsdf-4db513fd.pool.mediaways.net ([77.181.19.253])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 11:38:29 +0100
Received: from jojo by dsdf-4db513fd.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 11:38:29 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db513fd.pool.mediaways.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210249>

Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:

...

> Not exactly.  There are three classes of people:
>
> - wrote scripts using --get; found out that --get barfs if you feed
>   two or more of the same, and have long learned to accept it as a
>   limitation and adjusted their configuration files to avoid it.
>   They have been doing just fine and wouldn't benefit from this
>   series at all.
>
> - wrote scripts using --get, relying on it barfing if fed zero
>   (i.e. missing) or two or more (i.e. ambiguous), perhaps a way to
>   keep their configuration files (arguably unnecessarily) clean.
>   They are directly harmed by this series.
>
> - wrote scripts using --get-all and did the last-one-wins
>   themselves.  They wouldn't benefit directly from this series,
>   unless they are willing to spend a bit of time to remove their
>   own last-one-wins logic and replace --get-all with --get (but the
>   same effort is needed to migrate to --get-one).
>
> - wanted to write scripts using --get, but after finding out that
>   it barfs if you feed two, gave up emulating the internal, without
>   realizing that they could do so with --get-all.  They can now
>   write their scripts without using --get-all.

There are three classes ofpeople: those that can count and those that can't

Sorry could not resist ;-) 

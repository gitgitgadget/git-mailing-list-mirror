From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Wed, 07 Nov 2007 13:46:10 -0600
Message-ID: <1194464770.14978.11.camel@ld0161-tx32>
References: <11944127311587-git-send-email-shawn.bohrer@gmail.com>
	 <Pine.LNX.4.64.0711071110040.4362@racer.site>
	 <18225.48553.44088.269677@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, gitster@pobox.com,
	Git List <git@vger.kernel.org>
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 20:47:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipqrf-0001BN-6B
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 20:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842AbXKGTqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 14:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754026AbXKGTqj
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 14:46:39 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:38048 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473AbXKGTqi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 14:46:38 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id lA7JkBeE012002;
	Wed, 7 Nov 2007 12:46:11 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lA7JkANG027335;
	Wed, 7 Nov 2007 13:46:10 -0600 (CST)
In-Reply-To: <18225.48553.44088.269677@lisa.zopyra.com>
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-17) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63847>

On Wed, 2007-11-07 at 07:29, Bill Lear wrote:
> On Wednesday, November 7, 2007 at 11:10:45 (+0000) Johannes Schindelin writes:
> >Hi,
> >
> >you still have quite a number of instances where you wrap just one line 
> >into curly brackets:
> >
> >	if (bla) {
> >		[just one line]
> >	}
> 
> I've always found this a thoughtful practice.  It helps ensure nobody writes:
> 
>        if (bla)
>            just_one_line();
>            /* perhaps a comment, other stuff ... */
>            just_another_line();
> 
> which I've seen happen countless times.  It also is nice for others who
> come along and extend the branch from just one line to multiple ones,
> as the brackets are already in place.
> 
> Why do you find it objectionable?

I _totally_ agree with Bill.

jdl

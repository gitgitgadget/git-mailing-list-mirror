From: Bill Lear <rael@zopyra.com>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Wed, 7 Nov 2007 07:29:13 -0600
Message-ID: <18225.48553.44088.269677@lisa.zopyra.com>
References: <11944127311587-git-send-email-shawn.bohrer@gmail.com>
	<Pine.LNX.4.64.0711071110040.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Shawn Bohrer <shawn.bohrer@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 07 14:30:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpkyP-0002LG-ML
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 14:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755421AbXKGN3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 08:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754959AbXKGN3W
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 08:29:22 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60824 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754767AbXKGN3V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 08:29:21 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id lA7DTF928943;
	Wed, 7 Nov 2007 07:29:15 -0600
In-Reply-To: <Pine.LNX.4.64.0711071110040.4362@racer.site>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63806>

On Wednesday, November 7, 2007 at 11:10:45 (+0000) Johannes Schindelin writes:
>Hi,
>
>you still have quite a number of instances where you wrap just one line 
>into curly brackets:
>
>	if (bla) {
>		[just one line]
>	}

I've always found this a thoughtful practice.  It helps ensure nobody writes:

       if (bla)
           just_one_line();
           /* perhaps a comment, other stuff ... */
           just_another_line();

which I've seen happen countless times.  It also is nice for others who
come along and extend the branch from just one line to multiple ones,
as the brackets are already in place.

Why do you find it objectionable?


Bill

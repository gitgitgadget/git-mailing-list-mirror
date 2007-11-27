From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [WIP PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Tue, 27 Nov 2007 15:51:03 +0100
Message-ID: <20071127145103.GA30020@diana.vm.bytemark.co.uk>
References: <Pine.LNX.4.64.0711210336210.27959@racer.site> <fi5743$32p$1@ger.gmane.org> <Pine.LNX.4.64.0711230050270.27959@racer.site> <f329bf540711221723g2754ce03r4da6d429c45668c@mail.gmail.com> <Pine.LNX.4.64.0711230149430.27959@racer.site> <20071123205958.GC14735@spearce.org> <20071125170019.GB25800@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0711261647400.27959@racer.site> <20071127101614.GB26072@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0711271123360.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, hanwen@xs4all.nl,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 27 15:51:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix1mm-0003Pr-5G
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 15:51:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757941AbXK0OvT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2007 09:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757926AbXK0OvT
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 09:51:19 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1970 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757888AbXK0OvR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 09:51:17 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Ix1mB-0007qQ-00; Tue, 27 Nov 2007 14:51:03 +0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711271123360.27959@racer.site>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66221>

On 2007-11-27 11:25:47 +0000, Johannes Schindelin wrote:

> Ah, so you would like something like "git --interactive"? This is
> indeed a completely different scope than the fast-export thingie,

Yes. Or rather, I _think_ that's what I want. The only numbers I have
is that StGit makes a number of trivial git calls that right now take
on the order of 10 ms apiece, so the first step in this direction
would be to build a simple prototype just to see what kind of speed-up
one could expect (both in the git calls, and in StGit overall).

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

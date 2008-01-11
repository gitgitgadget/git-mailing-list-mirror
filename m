From: Miles Bader <miles.bader@necel.com>
Subject: Re: CRLF problems with Git on Win32
Date: Fri, 11 Jan 2008 12:03:41 +0900
Message-ID: <buo1w8pm5bm.fsf__23043.1283395321$1200465417$gmane$org@dhapc248.dev.necel.com>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se>
	<200801071947.28586.robin.rosenberg.lists@dewire.com>
	<alpine.LSU.1.00.0801071915470.10101@racer.site>
	<200801072203.23938.robin.rosenberg.lists@dewire.com>
	<alpine.LSU.1.00.0801072115120.10101@racer.site>
	<3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de>
	<20080108172957.GG22155@fieldses.org>
	<CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de>
	<7vmyrgry20.fsf@gitster.siamese.dyndns.org>
	<02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de>
	<20080108190952.GK22155@fieldses.org>
	<7vir24rtfp.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801081232120.3148@woody.linux-foundation.org>
	<7vd4sbmnmz.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801091041570.31053@racer.site>
	<Pine.LNX.4.64.0801101023380.11922@ds9.cixit.se>
	<alpine.LSU.1.00.0801101155140.31053@racer.site>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Karlsson 
	<public-peter-wzhfs8O2nkI+/KzbbBz5qQ@hugh.gmane.org>,
	Junio C Hamano 
	<public-gitster-e+AXbWqSrlAAvxtiuMwx3w@hugh.gmane.org>,
	Linus Torvalds 
	<public-torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@hugh.gmane.org>,
	"J. Bruce Fields" 
	<public-bfields-uC3wQj2KruNg9hUCZPvPmw@hugh.gmane.org>,
	Steffen Prohaska <public-prohaska-wjoc1KHpMeg@hugh.gmane.org>,
	Robin Rosenberg 
	<public-robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@hugh.gmane.org>,
	Jeff King <public-peff-AdEPDUrAXsQ@hugh.gmane.org>,
	Git Mailing List 
	<public-git-u79uwXL29TY76Z2rM5mHXA@hugh.gmane.org>,
	msysGit <public-msysgit-/JYPxA39Uh5TLH3MbocFFw@hugh.gmane.org>
To: public-Johannes.Schindelin-Mmb7MZpHnFY@hugh.gmane.org
X-From: git-owner@vger.kernel.org Wed Jan 16 07:36:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF1tN-0001hO-Dk
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 07:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbYAPGgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 01:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752076AbYAPGgP
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 01:36:15 -0500
Received: from blaine.gmane.org ([80.91.229.8]:48715 "EHLO hugh.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545AbYAPGgO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 01:36:14 -0500
Received: from public by hugh.gmane.org with local (Exim 4.63)
	(envelope-from <public@hugh.gmane.org>)
	id 1JF1se-00030m-Jf
	for git@vger.kernel.org; Wed, 16 Jan 2008 07:36:08 +0100
Received: from public by hugh.gmane.org with local (Exim 4.63)
	(envelope-from <miles.bader@necel.com>)
	id 1JF1sa-0002yS-97
	for public-git-u79uwXL29TY76Z2rM5mHXA@hugh.gmane.org; Wed, 16 Jan 2008 07:36:04 +0100
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by hugh.gmane.org with esmtp (Exim 4.63)
	(envelope-from <miles.bader@necel.com>)
	id 1JDABX-0007gN-4C; Fri, 11 Jan 2008 04:03:57 +0100
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id m0B33eMv015636;
	Fri, 11 Jan 2008 12:03:43 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay11.aps.necel.com with ESMTP; Fri, 11 Jan 2008 12:03:43 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay11.aps.necel.com with ESMTP; Fri, 11 Jan 2008 12:03:43 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id AF905401; Fri, 11 Jan 2008 12:03:42 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <alpine.LSU.1.00.0801101155140.31053@racer.site> (Johannes
	Schindelin's message of "Thu, 10 Jan 2008 11:57:32 +0000 (GMT)")
X-TMDA-Confirmed: Wed, 16 Jan 2008 07:36:04 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70639>




Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
writes:
>> Windows has CRLF line endings. Just deal with it.
>
> No, I will not just deal with it.

Didn't Apple change their line-ending convention, moving to LF EOL with OSX?

-Miles

-- 
"I distrust a research person who is always obviously busy on a task."
   --Robert Frosch, VP, GM Research

X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: filesystem encodings and gitweb tests, was Re: Moving a directory
 into another fails
Date: Tue, 5 Dec 2006 15:40:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612051539030.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910607260800v618edf0em7b0f5c3332bf8fc5@mail.gmail.com>
 <200612051036.13645.jnareb@gmail.com> <Pine.LNX.4.63.0612051507170.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <200612051529.57174.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 5 Dec 2006 14:40:15 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200612051529.57174.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33345>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrbSu-0008BD-Vy for gcvg-git@gmane.org; Tue, 05 Dec
 2006 15:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967508AbWLEOkI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 09:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967583AbWLEOkI
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 09:40:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:40941 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S967508AbWLEOkH
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 09:40:07 -0500
Received: (qmail invoked by alias); 05 Dec 2006 14:40:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp043) with SMTP; 05 Dec 2006 15:40:05 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 5 Dec 2006, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> > On Tue, 5 Dec 2006, Jakub Narebski wrote:
> > 
> >> No, the problem showed with stupid HFS+ which uses different encoding
> >> for creating file, and different for readdir.
> > 
> > This is just one of the problems. I described another problem in this 
> > thread, namely a repo on a usb stick being accessed from different hosts.
> 
> That is not much a problem. Yes, the filenames on different hosts would
> _look_ different, but shouldn't be detected as new file.

Sorry, I should have been clearer. I meant a repo _and_ a working 
directory going along with it, on a USB stick. They do look different on 
different hosts, and git-status looks different as a consequence ;-)

Ciao,
Dscho

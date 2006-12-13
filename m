X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Can git be tweaked to work cross-platform, on FAT32?
Date: Wed, 13 Dec 2006 17:39:42 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612131707100.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <0MKwpI-1GuWVF2znk-0006fC@mrelayeu.kundenserver.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 13 Dec 2006 16:40:14 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <0MKwpI-1GuWVF2znk-0006fC@mrelayeu.kundenserver.de>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34226>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuX9M-0002ob-SE for gcvg-git@gmane.org; Wed, 13 Dec
 2006 17:40:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964966AbWLMQjr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 11:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbWLMQjq
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 11:39:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:54685 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S964966AbWLMQjp
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 11:39:45 -0500
Received: (qmail invoked by alias); 13 Dec 2006 16:39:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp038) with SMTP; 13 Dec 2006 17:39:43 +0100
To: "Florian v. Savigny" <lorian@fsavigny.de>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 13 Dec 2006, Florian v. Savigny wrote:

> I would like to use git to develop a somewhat larger Perl project
> which I would need to test and develop under both Linux and Windows,
> i.e. I would need a repository on a FAT32 partition (to my knowledge,
> still the only filesystem that can be fully accessed from both OSes -
> correct me if I'm wrong) which could be accessed by two compatible git
> executables, such that I could switch back and forth.

I would not use the _same_ repository from both Windows and Linux, but 
rather fetch/push from/to the Windows partition.

I am using Cygwin to compile git, and I have a USB Stick with FAT32 on 
which I push regularly. Important: since Linux is more intelligent about 
permissions, I had to initialize the repos with Windows.

To get started compiling, you might want to use the autoconf script.

Ciao,
Dscho

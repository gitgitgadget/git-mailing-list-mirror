X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: bug: git-sh-setup should not be in $PATH
Date: Wed, 6 Dec 2006 13:23:43 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612061322140.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <el6c6o$oa7$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 6 Dec 2006 12:23:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <el6c6o$oa7$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33439>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrvoS-0000oD-Iy for gcvg-git@gmane.org; Wed, 06 Dec
 2006 13:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760548AbWLFMXq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 07:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760549AbWLFMXp
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 07:23:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:52665 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1760548AbWLFMXp
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 07:23:45 -0500
Received: (qmail invoked by alias); 06 Dec 2006 12:23:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp045) with SMTP; 06 Dec 2006 13:23:43 +0100
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 6 Dec 2006, Han-Wen Nienhuys wrote:

> I often install tools locally so I can run SVN/CVS/etc versions 
> in my own account. To do this, I install into
> 
>   $HOME/usr/pkg/PACKAGE

Why not just set

$ export GIT_EXEC_PATH=$HOME/usr/pkg/git
$ export PATH=$PATH:$GIT_EXEC_PATH

?

Ciao,

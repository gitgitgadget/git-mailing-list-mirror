Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=2.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INVALID_MSGID,MSGID_NOFQDN1,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: (qmail 14998 invoked by uid 107); 23 Apr 2010 12:47:00 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Fri, 23 Apr 2010 08:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757340Ab0DWMqr (ORCPT <rfc822;peff@peff.net>);
	Fri, 23 Apr 2010 08:46:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:48695 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757200Ab0DWMqp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 08:46:45 -0400
Received: (qmail invoked by alias); 23 Apr 2010 12:46:43 -0000
Received: from dinoc9.indmath.uni-linz.ac.at (EHLO localhost) [140.78.117.79]
  by mail.gmx.net (mp047) with SMTP; 23 Apr 2010 14:46:43 +0200
X-Authenticated: #25381063
X-Provags-ID: V01U2FsdGVkX19GApNZbihGQilRXTra4pb/oflm79wAnjVdWPnMRZ
	77qRVgbqyfAvNJ
Date:	Fri, 23 Apr 2010 14:46:40 +0200
From:	Konrad Karl <kk_konrad@gmx.at>
To:	git@vger.kernel.org
Subject: multiple .gitignore and friends  in same workdir possible?
Message-ID: <20100423124640.GA3657localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71999999999999997
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

while trying to move our Windows people from VSS to git i am
facing the following problem:

I want to have two (or three) git repos wich all share the
same working directory (this is manageable by environment variables),
one for the real source files and the other for 3'rd party binaries 
(*.dll, *.lib + perhaps include files for those)
and perhaps a third one for debugging symbol files (*.pdb and such)

In order to have .gitignore (and .gitattributes) files versioned
and also distributed on git clone they need to be inside the
work dir. Unfortunately the sources and binaries are co-located
inside the work dir subfolders - for historic reasons.

So i would like to have a mechanism to be able to specify different
filenames for .gitignore and .gitattributes  without having to
recompile git, perhaps by an environment variable.
(e.g by a suffix like .gitignore.src .gitignore.bin etc)

Is this currently possible or am I missing something? It would ease
my task a lot. 

Greetings,
Konrad

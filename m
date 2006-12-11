X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Using GIT to store /etc (Or: How to make GIT store all file permission
 bits)
Date: Mon, 11 Dec 2006 05:55:08 -0500
Message-ID: <457D390C.6020605@garzik.org>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com> <elh91b$v6r$1@sea.gmane.org> <A52817B6-0265-4164-8E5D-334AF92DC267@mac.com> <200612101926.33307.jnareb@gmail.com> <19476830-E30A-42B7-AD9B-4C417D830C8E@mac.com> <457D3573.2010001@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 10:55:30 +0000 (UTC)
Cc: Andreas Ericsson <ae@op5.se>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <457D3573.2010001@op5.se>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33992>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gtioa-0000cE-SP for gcvg-git@gmane.org; Mon, 11 Dec
 2006 11:55:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762667AbWLKKzR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 05:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762669AbWLKKzR
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 05:55:17 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:44991 "EHLO mail.dvmed.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1762667AbWLKKzP
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 05:55:15 -0500
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75]
 helo=[10.10.10.10]) by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat
 Linux)) id 1GtioP-000583-C9; Mon, 11 Dec 2006 10:55:09 +0000
To: Kyle Moffett <mrmacman_g4@mac.com>
Sender: git-owner@vger.kernel.org

Another option is to have a process that stores your configs in git, and 
script an export from git to rpm|deb.  Packaging systems make it even 
easier to go between config versions.

	Jeff



X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH 2/3] git-svn: documentation updates
Date: Tue, 28 Nov 2006 23:29:18 -0800
Message-ID: <456D36CE.1060300@midwinter.com>
References: <1164768702941-git-send-email-normalperson@yhbt.net> <11647687042130-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 29 Nov 2006 07:29:29 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Macintosh/20061025)
In-Reply-To: <11647687042130-git-send-email-normalperson@yhbt.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32620>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpJsa-0007z9-QR for gcvg-git@gmane.org; Wed, 29 Nov
 2006 08:29:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935429AbWK2H3O (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 02:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935443AbWK2H3O
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 02:29:14 -0500
Received: from tater.midwinter.com ([216.32.86.90]:19107 "HELO
 midwinter.com") by vger.kernel.org with SMTP id S935436AbWK2H3M (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 02:29:12 -0500
Received: (qmail 22315 invoked from network); 29 Nov 2006 07:29:12 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.128?)
 (koreth@76.21.17.123) by tater.midwinter.com with SMTP; 29 Nov 2006 07:29:11
 -0000
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

Eric Wong wrote:
> Eliminate 'commit' from some places and plug 'dcommit' more.
> Also update the section --id (GIT_SVN_ID) usage since we
> have multi-init/multi-fetch now.
>   

In the spirit of the "should the -a option be the default in 
git-commit?" discussion... What are the chances that a future version of 
git-svn could change the "dcommit" command to "commit" and the current 
"commit" to something else? I know it's a historical artifact, but given 
that git-svn is (by definition) aimed at Subversion users who are 
probably used to running "svn commit", it seems like making "git-svn 
commit" be the thing you usually want to run would be a good thing. One 
less habit to unlearn.


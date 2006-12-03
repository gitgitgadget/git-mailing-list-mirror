X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: sf <sf-gmane@stephan-feder.de>
Subject: Re: jgit performance update
Date: Sun, 03 Dec 2006 22:55:45 +0100
Message-ID: <457347E1.2020800@stephan-feder.de>
References: <20061203045953.GE26668@spearce.org>
Reply-To: sf-gmane@stephan-feder.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 3 Dec 2006 21:56:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 12
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ip-213157024137.dialin.heagmedianet.de
User-Agent: Thunderbird 1.5.0.4 (X11/20060606)
In-Reply-To: <20061203045953.GE26668@spearce.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33143>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GqzJr-00034w-DX for gcvg-git@gmane.org; Sun, 03 Dec
 2006 22:56:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760127AbWLCV4O (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 16:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760128AbWLCV4O
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 16:56:14 -0500
Received: from main.gmane.org ([80.91.229.2]:36776 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1760127AbWLCV4N (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 16:56:13 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GqzJf-0007GL-1J for git@vger.kernel.org; Sun, 03 Dec 2006 22:56:07 +0100
Received: from ip-213157024137.dialin.heagmedianet.de ([213.157.24.137]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 03 Dec 2006 22:56:07 +0100
Received: from sf-gmane by ip-213157024137.dialin.heagmedianet.de with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 03
 Dec 2006 22:56:07 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:
...
> One of the biggest annoyances has been the fact that although Java
> 1.4 offers a way to mmap a file into the process,

Be careful with mmap:
http://bugs.sun.com/bugdatabase/view_bug.do?bug_id=4724038


Regards

Stephan

X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: How to view an old revision?
Date: Wed, 01 Nov 2006 14:30:58 +0000
Message-ID: <4548AFA2.1040606@shadowen.org>
References: <3bbc18d20611010620m11e40402v44334a8c486a4932@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 1 Nov 2006 14:32:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
In-Reply-To: <3bbc18d20611010620m11e40402v44334a8c486a4932@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30639>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfH80-0000C1-CU for gcvg-git@gmane.org; Wed, 01 Nov
 2006 15:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S2992462AbWKAObg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 09:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992464AbWKAObg
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 09:31:36 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:5127 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S2992462AbWKAObg
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 09:31:36 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1GfH7J-0001aN-Uk; Wed, 01 Nov 2006 14:30:58 +0000
To: Matt McCutchen <hashproduct+git@gmail.com>
Sender: git-owner@vger.kernel.org

Matt McCutchen wrote:
> Dear git people,
> 
> How do I view an old revision of a file without actually checking it
> out?  This would be analogous to "cvs checkout -r <old> -p".  I've
> RTMed and STWed and can't seem to find a way.
> 

Something like the following:

	git cat-file -p <commit-ish>:<file>

For example:
	git cat-file -p tags/v1.4.3:git.c
	git cat-file -p f5f75c652b9c2347522159a87297820103e593e4:git.c


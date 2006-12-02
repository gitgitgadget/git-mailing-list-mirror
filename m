X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sam Vilain <sam@vilain.net>
Subject: Re: On removing files and "git-rm is pointless"
Date: Sun, 03 Dec 2006 10:10:47 +1300
Message-ID: <4571EBD7.2040004@vilain.net>
References: <200612022059.kB2Kx565009646@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 2 Dec 2006 21:11:19 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, Carl Worth <cworth@cworth.org>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
In-Reply-To: <200612022059.kB2Kx565009646@laptop13.inf.utfsm.cl>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33053>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gqc8h-0005fW-BL for gcvg-git@gmane.org; Sat, 02 Dec
 2006 22:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162487AbWLBVK5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 16:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162488AbWLBVK5
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 16:10:57 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:23965 "EHLO
 magnus.utsl.gen.nz") by vger.kernel.org with ESMTP id S1162487AbWLBVK4 (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 16:10:56 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534) id EE442139B0D;
 Sun,  3 Dec 2006 10:10:54 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.magnus.utsl.gen.nz [192.168.253.12])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by magnus.utsl.gen.nz (Postfix) with ESMTP id
 0394F1380C2; Sun,  3 Dec 2006 10:10:50 +1300 (NZDT)
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org

Horst H. von Brand wrote:

>>  - without "-r", don't do the partial matches at the beginning (but still 
>>    do globbing matches, of course, so "git rm dir/*" wouldn't need an 
>>    "-r", but "git rm -r dir/", which does the same thing, _would_ need an 
>>    "-r" to be effective)
> 
> The command should never even see the '*' here. Globbing is handled
> (uniformly) by the shell. Don't loose that.

But;

  git-rm \*>/dev/null; git-add \*

is just so darned handy!


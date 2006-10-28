X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Generating docu in 1.4.3.3.g01929
Date: Fri, 27 Oct 2006 22:45:51 -0700
Message-ID: <7vr6wt9enk.fsf@assigned-by-dhcp.cox.net>
References: <20061027154433.da9b29d7.seanlkml@sympatico.ca>
	<200610272312.k9RNCo2Q002623@laptop13.inf.utfsm.cl>
	<BAYC1-PASMTP04E0376BEE45F9A676DB03AE050@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 28 Oct 2006 05:46:05 +0000 (UTC)
Cc: git@vger.kernel.org, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <BAYC1-PASMTP04E0376BEE45F9A676DB03AE050@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Sat, 28 Oct 2006 00:24:54 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30366>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gdh12-0007rH-9l for gcvg-git@gmane.org; Sat, 28 Oct
 2006 07:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751846AbWJ1Fpx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 01:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbWJ1Fpx
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 01:45:53 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:58767 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S1751846AbWJ1Fpw
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 01:45:52 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061028054551.RRFI6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>; Sat, 28
 Oct 2006 01:45:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id fhlZ1V00Q1kojtg0000000 Sat, 28 Oct 2006
 01:45:34 -0400
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

Sean <seanlkml@sympatico.ca> writes:

>> > Can't reproduce this here on master or on next with:
>> >  asciidoc-7.1.2-0 and xmlto-0.0.18-13.1
>> > Maybe this is an Asciidoc 8 issue, are you using it?
>> 
>> Fedora rawhide i386, with:
>> 
>>   asciidoc-7.0.2-3.fc6
>>   xmlto-0.0.18-13.1
>> 
>> Perhaps too old, not too new...
>
> Can't imagine that it's too old.  You may have to bisect to figure
> out what the culprit is. :o/

Eh, do you mean bisecting asciidoc?  I am not seeing the problem
with these on a freshly installed FC6:

Name   : asciidoc
Arch   : noarch
Version: 7.0.2
Release: 3.fc6

Name   : xmlto
Arch   : i386
Version: 0.0.18
Release: 13.1

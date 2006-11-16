X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: git tag: don't complain of empty messages
Date: Thu, 16 Nov 2006 01:14:56 +0100
Message-ID: <455BAD80.1080108@xs4all.nl>
References: <ejfc1t$6am$1@sea.gmane.org> <7v64dgo9gj.fsf@assigned-by-dhcp.cox.net>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 16 Nov 2006 00:15:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7v64dgo9gj.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by XS4ALL Virus Scanner
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31531>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkUuF-00073I-Iu for gcvg-git@gmane.org; Thu, 16 Nov
 2006 01:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162098AbWKPAPA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 19:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162100AbWKPAPA
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 19:15:00 -0500
Received: from smtp-vbr7.xs4all.nl ([194.109.24.27]:32273 "EHLO
 smtp-vbr7.xs4all.nl") by vger.kernel.org with ESMTP id S1162098AbWKPAO7
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 19:14:59 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
 (authenticated bits=0) by smtp-vbr7.xs4all.nl (8.13.8/8.13.8) with ESMTP id
 kAG0Esh4007842; Thu, 16 Nov 2006 01:14:54 +0100 (CET) (envelope-from
 hanwen@xs4all.nl)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano escreveu:
> I do not have a strong objection against allowing tags without
> messages, but at the same time I do not see a compelling reason
> to allow them either.  Care to explain what workflow is helped
> by an empty tag?

the tagname usually is enough of a description, but I want the tags to 
end up in the object DB, eg.:

   git tag release/2.10.0 HEAD

now I have to use

   git tag -m "this really sucks"  release/2.10.0 HEAD


-- 

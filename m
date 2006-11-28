X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: [PATCH/RFC] "init-db" can really be just "init"
Date: Tue, 28 Nov 2006 11:45:12 +0100
Message-ID: <456C1338.2020303@xs4all.nl>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home> <7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 10:45:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by XS4ALL Virus Scanner
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32506>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp0Sg-0000QH-4s for gcvg-git@gmane.org; Tue, 28 Nov
 2006 11:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935842AbWK1KpK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 05:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935839AbWK1KpK
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 05:45:10 -0500
Received: from smtp-vbr15.xs4all.nl ([194.109.24.35]:27912 "EHLO
 smtp-vbr15.xs4all.nl") by vger.kernel.org with ESMTP id S935842AbWK1KpI
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 05:45:08 -0500
Received: from [192.168.0.101] (82-171-213-190.dsl.ip.tiscali.nl
 [82.171.213.190]) (authenticated bits=0) by smtp-vbr15.xs4all.nl
 (8.13.8/8.13.8) with ESMTP id kASAj3cR006471 (version=TLSv1/SSLv3
 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Tue, 28 Nov 2006 11:45:04
 +0100 (CET) (envelope-from hanwen@xs4all.nl)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano escreveu:
> I was not sure about this for quite some time, thinking that it
> might make sense to default the behaviour of init-db for bare
> repositories and give init as a user-level wrapper to drive
> init-db to add customization suitable for repositories with
> working trees.  List?

wouldn't using --bare be more consistent for bare repos?

>> Maybe that could be a good rule of thumb to have all porcelainish 
>> commands not have any hyphen in their name, like "diff", "commit", 
>> "add", etc. ?
> 
> I was also hoping that would become the case except verify-tag,
> cherry-pick, and format-patch.  

why not shorten them to "pick" and "verify"?

-- 

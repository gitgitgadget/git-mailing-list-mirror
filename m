X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Pazu <pazu@pazu.com.br>
Subject: Re: Ignoring local changes
Date: Thu, 14 Dec 2006 14:55:32 -0200
Message-ID: <9e7ab7380612140855p1f4ee6c1l5ef24c4d1d169da6@mail.gmail.com>
References: <loom.20061214T171948-279@post.gmane.org> <45817F8A.3050701@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 16:55:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=SF1c+peQ6oQH1imgZ2V666n8g9Kjuxph9MKQgqVKOQyb4GV4oRLCYBdOA7K2de4A/3r/kh9NeyLOeG5Bh8BTpt76EXjTl4VI6DX0DT8DD9eV2xwP1PTONVmX1BTaNv8pp3T51xMgyOECTkA10NXVjoukiPL9u+So1ZcyXpGhKVo=
In-Reply-To: <45817F8A.3050701@op5.se>
Content-Disposition: inline
X-Google-Sender-Auth: 55f88748a0ef92b7
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34371>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guts9-0003No-Dv for gcvg-git@gmane.org; Thu, 14 Dec
 2006 17:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932850AbWLNQzf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 11:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932860AbWLNQzf
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 11:55:35 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:41499 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932850AbWLNQze (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 11:55:34 -0500
Received: by nf-out-0910.google.com with SMTP id o25so887371nfa for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 08:55:32 -0800 (PST)
Received: by 10.49.34.11 with SMTP id m11mr1023671nfj.1166115332559; Thu, 14
 Dec 2006 08:55:32 -0800 (PST)
Received: by 10.48.216.13 with HTTP; Thu, 14 Dec 2006 08:55:32 -0800 (PST)
To: "Andreas Ericsson" <ae@op5.se>
Sender: git-owner@vger.kernel.org

2006/12/14, Andreas Ericsson <ae@op5.se>:

> Correction: I just tested this, and while git-add won't touch the file,
> git-update-index will, and git-status still shows it as modified.

Yes, and that's exactly my problems. There are a number of
modified/removed files in my working copy that were previously added
to the repository, and git-status shows them as modified/removed, even
when they're listed in .gitignore or .git/info/exclude

> This feels like a bug to me.

Dunno, sounds like this is by design. I acknowledge that my situation
is unusual, and most often, you'll want to always track a file once
it's been added to the repository.


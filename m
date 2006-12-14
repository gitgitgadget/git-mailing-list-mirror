X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Pazu <pazu@pazu.com.br>
Subject: Re: Ignoring local changes
Date: Thu, 14 Dec 2006 19:36:51 -0200
Message-ID: <9e7ab7380612141336p3b930047l3a4a76947239162f@mail.gmail.com>
References: <loom.20061214T171948-279@post.gmane.org> <45817F8A.3050701@op5.se>
	 <9e7ab7380612140855p1f4ee6c1l5ef24c4d1d169da6@mail.gmail.com>
	 <4581C1D4.7080102@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 21:36:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ThaV6gvv0LVHjIOSujP9s5jCYuupAlK0YC/BTlvhf9IXdYEFAkhAKTOambOBiZewtRMXsnGuC/N5xhsAVdoz//l7BkgNwRw6lX+yUVLlffeLd+M7GossZDeAT0s3YaVhfzY/uL8S5F30rBRqeUvUkp2aUd6llwij7g4WgoSZqdg=
In-Reply-To: <4581C1D4.7080102@dawes.za.net>
Content-Disposition: inline
X-Google-Sender-Auth: af4a7ed2ebe9a094
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34407>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuyG8-0003QF-Vx for gcvg-git@gmane.org; Thu, 14 Dec
 2006 22:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932933AbWLNVgx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 16:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932938AbWLNVgx
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 16:36:53 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:47940 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932933AbWLNVgw (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 16:36:52 -0500
Received: by nf-out-0910.google.com with SMTP id o25so951600nfa for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 13:36:51 -0800 (PST)
Received: by 10.48.230.20 with SMTP id c20mr1382773nfh.1166132211403; Thu, 14
 Dec 2006 13:36:51 -0800 (PST)
Received: by 10.48.216.13 with HTTP; Thu, 14 Dec 2006 13:36:51 -0800 (PST)
To: "Rogan Dawes" <discard@dawes.za.net>
Sender: git-owner@vger.kernel.org

2006/12/14, Rogan Dawes <discard@dawes.za.net>:

> Why not remove it from the repo, then set .gitignore?
>
> If it is generated code, or compiled code, it probably shouldn't be in
> the repo in the first place . . . Simply correct that mistake, and you
> are good to go.

Basically, because I don't want to mess with the upstream. I know, I
can remove them only from my local branch, and never push the commit
that removed the files, and that's what I'll probably do if there's no
other way -- but it would be best if I could just ignore the files. It
doesn't sound unreasonable, does it?


X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: [RFC] requiring Perl SVN libraries for git-svn
Date: Fri, 15 Dec 2006 13:06:57 -0800
Message-ID: <m28xh8amxa.fsf@ziti.local>
References: <20061213202142.GE8179@localdomain>
	<20061215184424.GA1442@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 21:07:25 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=Wovju2R3K4+4Veyu1HPnr2m1HKle/K07GB/7WWjLRDBwum3wX7Lx1qgyhCTdKsBhYoVGX8kG3R1/9WR/YOgaHp7iICvnDpNZOZhXJfkZIFRrw6T5/Ms4m6PUQcUvEhan0pfSeqnI/b5T3D6rda7TjMo6iv0evjcKXJl/jj50frY=
In-Reply-To: <20061215184424.GA1442@localdomain> (Eric Wong's message of "Fri, 15 Dec 2006 10:44:24 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34551>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvKH0-0008P3-3r for gcvg-git@gmane.org; Fri, 15 Dec
 2006 22:07:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964997AbWLOVHG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 16:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbWLOVHG
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 16:07:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:22874 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S964997AbWLOVHE (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec
 2006 16:07:04 -0500
Received: by ug-out-1314.google.com with SMTP id 44so917852uga for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 13:07:02 -0800 (PST)
Received: by 10.66.232.9 with SMTP id e9mr502366ugh.1166216822340; Fri, 15
 Dec 2006 13:07:02 -0800 (PST)
Received: from ziti.local ( [140.107.181.122]) by mx.google.com with ESMTP id
 m1sm4045484ugc.2006.12.15.13.07.01; Fri, 15 Dec 2006 13:07:02 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Eric Wong <normalperson@yhbt.net> writes:

> Eric Wong <normalperson@yhbt.net> wrote:
>> Are there any git-svn users out there who would be seriously hurt if I
>> dropped support for using the svn command-line client in git-svn?
>
> One additional comment is that the dcommit command (much favored over
> 'git svn commit') does not currently work with the command-line
> client.

Which IMO, suggests that you should drop command-line support asap.
Those wanting command-line support are most likely to be beginning
users who almost certainly want to be using dcommit.

(that makes $0.04)


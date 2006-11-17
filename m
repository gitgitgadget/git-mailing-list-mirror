X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [ANNOUNCE] Cogito-0.18.2
Date: Fri, 17 Nov 2006 14:44:47 +1300
Message-ID: <46a038f90611161744q6c535218n5b815ef1fc5228b6@mail.gmail.com>
References: <20061117004930.GC7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 17 Nov 2006 01:46:33 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QHthr4N9ttPWKfNaV8+ATYALmAREBhNRbScKdHKl4YZ3C1b5c5SA/prPTS8qzDDd5nU1bgW8d0f/54ydJ6S0EPMN26Y7wM86ozeR0/rm6Y6oqelk6qhxEdvWJsZ1j1QW1Cazw/Y4nffPIV+VbzRrEOx8ul+BdbEe8l2Cj60Ly+U=
In-Reply-To: <20061117004930.GC7201@pasky.or.cz>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31658>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gksmp-0003b3-AG for gcvg-git@gmane.org; Fri, 17 Nov
 2006 02:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424899AbWKQBoz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 20:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424901AbWKQBoz
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 20:44:55 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:6117 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1424899AbWKQBoy
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 20:44:54 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1180990nfa for
 <git@vger.kernel.org>; Thu, 16 Nov 2006 17:44:53 -0800 (PST)
Received: by 10.49.19.5 with SMTP id w5mr937204nfi.1163727892724; Thu, 16 Nov
 2006 17:44:52 -0800 (PST)
Received: by 10.49.60.1 with HTTP; Thu, 16 Nov 2006 17:44:47 -0800 (PST)
To: "Petr Baudis" <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

On 11/17/06, Petr Baudis <pasky@suse.cz> wrote:

> * cg-log does not follow history across renames anymore; it never really
>   actually worked and was instead causing problems and random error
>   messages. There needs to be git-core support for this funcionality,
>   hacking it with a perl filter is bad design, so I'm not going to fix
>   the filter (but I'd take patches if someone else did ;).

I was looking at the follow renames Perl script last week (hey, I was
bored!) and while I could tell it didn't work, I did get the feeling
that it wasn't an impossible task, at least for the 'explicit paths'
case. For the 'whole tree' and subpath cases it _is_ tricky, and would
be faster to solve within git, but not impossible.

And even then, I am tempted to think that git log could provide some
better hints than it does today when walking the whole tree or
subpaths, so that cg-log or gitk can ask [if relevant] for selective
rename info.

I am curious as to why you see it as bad design...

cheers,



From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] git-commit.txt: Order options alphabetically
Date: Wed, 1 Dec 2010 14:52:51 -0800
Message-ID: <E02740CE-37EE-4701-BB2D-18AD493D1C05@sb.org>
References: <1291215526-11428-1-git-send-email-jari.aalto@cante.net> <20101201165043.GF26120@burratino> <87r5e1v2g8.fsf@picasso.cante.net> <7vzkspuw8g.fsf@alter.siamese.dyndns.org> <295D1E95-1C61-4960-8C9C-BDB0BD4A1A50@sb.org> <87mxopt8my.fsf@picasso.cante.net>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Wed Dec 01 23:53:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNvXs-0001V3-Ub
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 23:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757093Ab0LAWw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 17:52:59 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:51445 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756253Ab0LAWw6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Dec 2010 17:52:58 -0500
Received: by pxi15 with SMTP id 15so1161685pxi.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 14:52:58 -0800 (PST)
Received: by 10.142.162.19 with SMTP id k19mr9614083wfe.313.1291243978483;
        Wed, 01 Dec 2010 14:52:58 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id w42sm583839wfh.3.2010.12.01.14.52.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 14:52:57 -0800 (PST)
In-Reply-To: <87mxopt8my.fsf@picasso.cante.net>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162631>

On Dec 1, 2010, at 2:45 PM, Jari Aalto wrote:

> 2010-12-01 23:58 Kevin Ballard <kevin@sb.org>:
>> On Dec 1, 2010, at 11:30 AM, Junio C Hamano wrote:
>> 
>> Trying to make the manpage look "nice" at the expense of removing
>> functional grouping is misguided.
> 
> Please explain where is the removed functionality in here:
> 
> GIT-COMMIT(1)                      Git Manual                     GIT-COMMIT(1)
> 
> OPTIONS
>       -a, --all
>           Tell the command to automatically stage files that have been
>           modified and deleted, but new files you have not told git about are
>           not affected.
> 
>       -C <commit>, --reuse-message=<commit>
>           Take an existing commit object, and reuse the log message and the
>           authorship information (including the timestamp) when creating the
>           commit.
> 
>       -c <commit>, --reedit-message=<commit>
>           Like -C, but with -c the editor is invoked, so that the user can
>           further edit the commit message.
> 
>       --reset-author
>           When used with -C/-c/--amend options, declare that the authorship of
>           the resulting commit now belongs of the committer. This also renews
>           the author timestamp.
> 
> What is the reason --reset-author is in that position? What
> functionality is serves? There are loads of similar ones. I don't see
> any group. Neither probably Joe Average.

It's entirely possible that this isn't ordered well, but from your quoted text
I would assume --reset-author is there because it's related to the -C and -c
flags (which directly precede it). In fact, if it wasn't for the current ordering,
I never would have even known about that flag.

> To me the git-pages do not look that professional when options are
> whereever. Take 10 manual pages side by side in terminals and the
> options are chaos (try locating some option, say "-v", on every command
> and try to figure if it serves same purpose in every command or not).

You seem overly concerned with the visual aesthetics and not at all with the
actual content.

> When the pages list options in alphabetical order, it doesn't take long
> to compare commands: similarities and differences in options, or missing
> options, or inconsistencies for that matter.

Why would you compare commands like that? There's really no reason at all to
believe that the -c flag for one command is even related to the -c flag for
another command.

-Kevin Ballard
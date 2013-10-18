From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v2 00/14] Officially start moving to the term 'staging
 area'
Date: Sat, 19 Oct 2013 01:28:46 +0200
Message-ID: <5261C42E.4050208@gmail.com>
References: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com> <1381789769-9893-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Miles Bader <miles@gnu.org>
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 19 01:28:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXJTO-0007wo-Me
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 01:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757774Ab3JRX2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 19:28:47 -0400
Received: from mail-ea0-f181.google.com ([209.85.215.181]:50324 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757433Ab3JRX2q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 19:28:46 -0400
Received: by mail-ea0-f181.google.com with SMTP id d10so2406376eaj.12
        for <git@vger.kernel.org>; Fri, 18 Oct 2013 16:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=k45DyIUYDReFYoOPHJrwIRuPcWITmCsXmU6zeIeh0ck=;
        b=T72miKxdEdHUTd/EfRukjVZyEXCNADFyL4c9o0FU82rsm2oODVzEoTupsjxfLvxg3p
         /Y8ppRctA0DU4u0/IY79CGBaEGUoCakEP9C7nAjN3J34pN6JPiYy2sIZk7s/qbj5Qgml
         qv/LQwsAu0WrBTYOXJPRaT9i0WTmHXLqkDHIq746GCwSRdGtV3aHhq6K54dlcCpp6vCy
         jfaKQxmOb9kQ2G1yc2HGxK5y+W+gm04ahfJP6TgjE7pZoJH3S/lvmyUgAnpdSfyG/v1k
         8SDYEwSLrNRFGqNqy4a4w+QHR+JCimqzqXqUsJJfqrHf7XFqPpVjBgzJXOArLbv9UC2/
         flmQ==
X-Received: by 10.14.172.133 with SMTP id t5mr7441150eel.35.1382138925071;
        Fri, 18 Oct 2013 16:28:45 -0700 (PDT)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id i1sm10511240eeg.0.2013.10.18.16.28.43
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 18 Oct 2013 16:28:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <1381789769-9893-4-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236379>

Am 15.10.2013 00:29, schrieb Felipe Contreras:
> tl;dr: everyone except Junio C Hamano and Drew Northup agrees; we should move
> away from the name "the index".
> 
> It has been discussed many times in the past that 'index' is not an
> appropriate description for what the high-level user does with it, and
> it has been agreed that 'staging area' is the best term.
> 

I haven't followed the previous discussion, but if a final conclusion towards 'staging area' has already been reached, it should probably be revised.

> The term 'staging area' is more intuitive for newcomers which are more
> familiar with English than with Git, and it seems to be a
> straightforward mental notion for people with different mother tongues.
> 
> In fact it is so intuitive that it's used already in a lot online
> documentation, and the people that do teach Git professionally use this
> term, because it's easier for many kinds of audiences to grasp.
> 

Such online documentation often portraits the 'staging area' as some supposedly 'unique' git feature, which I find _very_ confusing. In fact, every major SCM has a staging area. E.g. you first need to "svn/hg/bzr/p4 add/remove/rename/move" a file, which is somehow recorded in the working copy. These recorded changes will then be picked up by a subsequent "svn/hg/bzr/p4 commit/submit".

Additionally, all those systems support selectively committing individual files (by specifying the files on the commit command line or selecting them in a GUI).

So git's 'unique staging area' boils down to this:

1.) Recording individual files to commit in advance (instead of specifying them at commit time). Which isn't that hard to grasp.

2.) Recording individual diff hunks or even lines to commit. Which is an advanced feature that requires even more advanced commands to be useful (i.e. stash save --keep-index; make; test; commit; stash pop). It is also entirely irrelevant to binary files (i.e. for non-technical users that use git to track documents and stuff).

> index: an 'index' is a guide of pointers to something else; a book
> index has a list of entries so the reader can locate information
> easily without having to go through the whole book. Git porcelain is
> not using the staging area to find out entries quicker; it's not an
> index.
> 

The 'staging area' is a sorted list of most recently checked out files, and its primary purpose is to quickly detect changes in the working copy (i.e. its an index).

Of the 28 builtin main porcelain commands, 18 read the index (read_index), and 11 of those also check the state of the working copy (ie_match_stat). Incidentally, the latter include _all_ commands that update the so-called 'staging area'.

Subversion until recently kept the checked out files scattered in **/.svn/text-base directories, and many operations were terribly slow due to this. Subversion 1.7 introduced a new working copy format, based on a database in the root .svn directory (i.e. an index), leading to tremendous performance improvements.

The git index is a major feature that facilitates the incredible performance we're so much addicted to...why be shy about it and call it something else?

> stage: a 'stage' is a special area designated for convenience in order
> for some activity to take place; an orator would prepare a stage in
> order for her speak to be successful, otherwise many people might not
> be able to hear, or see her. Git porcelain is using the staging area
> precisely as a special area to be separated from the working directory
> for convenience.
> 

I'm not a native speaker, but in my limited understanding, 'staging' in computer jargon is the process of preparing data for a production system (i.e. until the 'stage' or 'state' of the data is ready for production). It has nothing to do with the 'stage' in a theater. I've never heard the term 'staging' beeing used for source code or software (that would be 'integration'). I've also never heard 'staging' for moving data back from a production system to some work- or development area.

In any sense, 'staging' is a unidirectional process (even in a theater). If I think of the index as a staging area, it covers just a single use case: preparing new commits. With this world view, it is completely counter-intuitive that e.g. changing branches overwrites my staging area.

IMO, it is ok to use 'like a staging area' when we talk about using the index to prepare new commits. However, its not ok to use 'staging area' as a general synonym for the index.

Just my 2 cents
Karsten

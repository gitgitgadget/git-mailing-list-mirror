From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [ANNOUNCE] cgit v0.7
Date: Sat, 3 Nov 2007 19:15:09 +0700
Message-ID: <fcaeb9bf0711030515i24174694w5d4fd9b82ca85868@mail.gmail.com>
References: <8c5c35580711030408n658eb11fk19d554f0fa3b17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 13:15:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoHuT-0005MD-Ni
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 13:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473AbXKCMPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 08:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753420AbXKCMPN
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 08:15:13 -0400
Received: from mu-out-0910.google.com ([209.85.134.190]:28809 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473AbXKCMPL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 08:15:11 -0400
Received: by mu-out-0910.google.com with SMTP id i10so997831mue
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 05:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=UHES6sr6X0BGT6YTpJcayklHGFIDYw3oSOoIaj9oOfY=;
        b=pw7hZ3/K5ESIPZEntrVQeqSn9VgU/2I6ICzGXqD9SsEaPBHP9/noHPqbhxQeLYTh0kfohe32NAgcVPiMpYu1FRaFOiMqpSVQ1WaJOAh9sOZwkTuwzoSb7B00V1nWdqLWAk+xNhnAORJvmhi5PVNTwgW++hJRuyCCqnT6qZpC0eo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rqPgi/RD+VeUIPm69bNiwbxJ0FU8RGipwiFDENMKVb/Cfjo6YH5CmLQNGLBQ+Qz/3Ka69CsiBNQNL/MwunsMA8sA2Gfypf8pEEobBK8QDw+vf9afuh28ogwCPq5pig5EhfHRNlgcsHYbyBkkwkagILDkvBpXyADlAj9Yjak9vdg=
Received: by 10.86.99.9 with SMTP id w9mr1663340fgb.1194092109575;
        Sat, 03 Nov 2007 05:15:09 -0700 (PDT)
Received: by 10.86.66.20 with HTTP; Sat, 3 Nov 2007 05:15:09 -0700 (PDT)
In-Reply-To: <8c5c35580711030408n658eb11fk19d554f0fa3b17@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63249>

I wonder why this is not in git's contrib part. It requires git source
code to build and does not seem to require additional dependencies.
It's smaller than gitweb and does not need perl... MinGW porting guys
may even have a look at it while porting git (and I'm thinking about
porting busybox httpd so that it could run out of the box on Windows
;) ).

Any reasons?

On 11/3/07, Lars Hjemli <hjemli@gmail.com> wrote:
> cgit v0.7 (a fast webinterface for git) is now available at
>
>      git://hjemli.net/pub/git/cgit
>
> This release includes better search capabilities, better diff,
> filtered and sorted branch/tag lists on the summary page, a simple way
> to switch between branches and finally a much needed restructuring of
> the user interface. There is even a brand new logo, and a number of
> bugfixes.
>
> The latest version can be seen in action on http://hjemli.net/git/
> (disclaimer: I'm not a web/user interface designer, and should not be
> held responsible for any eyeball-related damages).
>
> Big thanks to everyone who submitted patches and feedback!
>
> ---
> Sortlog since v0.6
>
>
> Chris Pickel (3):
>       Makefile: add support for DESTDIR
>       Make cgit honor CACHE_ROOT as defined in Makefile
>       Improve the sample cgitrc file
>
> Lars Hjemli (47):
>       Makefile: add missing references to DESTDIR
>       cgit v0.6.1
>       Revert "Makefile: add missing references to DESTDIR"
>       Revert part of "Makefile: add support for DESTDIR"
>       cgit v0.6.2
>       ui-tree: specify parameter position for all htmlf formats
>       ui-tree: show last line of blob
>       Add cgit.conf to .gitignore, remove *~
>       Remove a few compiler warnings
>       Use trim_end() to remove trailing slashes
>       Upgrade to GIT 1.5.3.2
>       cgit v0.6.3
>       Add support for a renamelimit option in cgitrc
>       Add prefix parameter to cgit_diff_tree()
>       Add prefix parameter to cgit_print_diff()
>       ui-commit.c: link to diff instead of tree from diffstat
>       css: remove the annoying tr:hover rule for diffstat
>       gen-version.sh: don't sed the output from git describe
>       ui-diff: add links to pre- and postversion of blobs
>       cgit.css: make diff headers more visible
>       Use git-1.5.3.3
>       Skip unknown header fields when parsing tags and commits
>       Add functions and types for ref lists
>       Use reflist to print branch info
>       Use reflist to print tag info
>       Sort tags by age
>       Add support for config param summary-tags
>       Move logic for age comparision from cmp_tag_age into cmp_age()
>       Add support for config param summary-branches
>       Add descriptions of summary-branches and summary-tags to cgitrc
>       Make cgit_print_branches()/cgit_print_tags() external
>       Add support for refs view
>       Add links to the new refs page from summary page
>       Cleanup code introduced by the filter-refs topic
>       cgit_parse_commit(): Add missing call to xstrdup()
>       Add html_option() function
>       Teach log search about --grep, --author and --committer
>       Make print_branch() handle refs not pointing at commits
>       Teach cgit_object_link() about tag objects
>       Add config param 'index-info'
>       Change the cgit layout
>       Add search parameters to cgit_log_link
>       Fix search form action/hidden fields
>       Don't include current path in menu links
>       Don't include current SHA1 in 'log' menu-item
>       Use GIT-1.5.3.5
>       CGIT 0.7
>
> Michael Krelin (2):
>       fixed typo in cgitrc
>       correct typo in CSS
>
> Shunichi Fuji (1):
>       Fix typo in css
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Duy

From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: A list of things missing or wrong in the documentation
Date: Tue, 6 Dec 2005 23:12:52 +0100
Message-ID: <20051206221252.GA8839@puritan.petwork>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Dec 06 23:13:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ejl3Y-0000Ch-OS
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 23:13:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbVLFWM5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 17:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932643AbVLFWM5
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 17:12:57 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:61100 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S932638AbVLFWM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 17:12:56 -0500
Received: from puritan.petwork ([213.112.43.250] [213.112.43.250])
          by mxfep01.bredband.com with ESMTP
          id <20051206221254.LSJP676.mxfep01.bredband.com@puritan.petwork>
          for <git@vger.kernel.org>; Tue, 6 Dec 2005 23:12:54 +0100
Received: by puritan.petwork (Postfix, from userid 1000)
	id EB58FADFE5; Tue,  6 Dec 2005 23:12:52 +0100 (CET)
To: GIT Mailing List <git@vger.kernel.org>
Mail-Followup-To: GIT Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13297>

Here's a list of things that are missing, wrong, or badly formatted in
the documentation (all checked against the man pages):

git-checkout-index:
        SYNOPSIS:
                --index
                --quiet
                --force
                --all
                --no-create

                (How do we put these in the SYNOPSIS?)
                (My bad, forgot to mention this in an earlier patch.)

git-read-tree:
        --trivial

        SYNOPSIS:
                --reset

git-update-index:
        -h
        --help

        (perhaps redundant)

git-rev-list:
        --dense
        --no-merges

git-merge-base:
        -a, --all

git-verify-pack:
        --

git-http-fetch:
        commit-id and url are missing descriptions

git-update-server-info:
        -f

git-am:
        --utf8 is converted to -u
        --keep is converted to -k

git-bisect:
        Documentation is messed up.  Lines are being joined when they
        shouldn't be (put "+ " at end of line).

git-cherry-pick:
        --no-commit
        --replay

git-clone:
        SYNOPSIS:
                --local
                --shared
                --quiet
                --upload-pack

git-commit:
        --all
        --signoff
        --verify
        --no-verify
        --edit
        -n

git-diff:
        --diff-options should be <common diff options>

        The table isn't rendered properly in the man-page.  I'm guessing
        that this is a problem with my DocBook templates, but I wanted
        to check if anyone else has this issue.

git-format-patch:
        SYNOPSIS:
                provide spacing around options, like other man-pages

        --keep-subject
        --numbered
        --output-directory
        -h --help
        -m
        -d

git-ls-remote:
        -h
        -t
        
git-pull:
        --strategy

git-repack:
        -n
        -l

git-revert:
        --no-commit
        -r --replay

git-show-branch:
        --topo-order

git-cvsimport:
        error in spacing (-P)

git-prune:
        --

git-tag:
        doesn't follow the format of the other manual pages
        missing explicit documentation for many options

General:
        The term "commit-id" isn't listed in the glossary.  Should this
        be changed to "commit" instead?

        Style guides generally suggest putting a comma after "e.g." and
        "i.e.", i.e., "e.g.," and "i.e.,".  It's perhaps a bit anal, but
        what do you think?

        rev is used as a term in some places.  Should perhaps expand it
        to revision?

I should of course provide patches for this, but I'm quite a bit under
the weather at the moment, and as a 1.0.0 release draws near I figured
that it'd be best that people at least know what I know so that they may
do something about it.  (Also, someone with better knowledge of asciidoc
and git itself would probably do a better job than I could.)

        nikolai

-- 
Nikolai Weibull: now available free of charge at http://bitwi.se/!
Born in Chicago, IL USA; currently residing in Gothenburg, Sweden.
main(){printf(&linux["\021%six\012\0"],(linux)["have"]+"fun"-97);}

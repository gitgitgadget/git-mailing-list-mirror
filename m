From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Conforming to pep8
Date: Thu, 8 May 2014 19:09:08 -0700
Message-ID: <20140509020908.GG9218@google.com>
References: <20140509015429.GA550@wst420>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: William Giokas <1007380@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 04:09:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiaFR-0003mU-1U
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 04:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755674AbaEICJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 22:09:13 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:35302 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900AbaEICJM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 22:09:12 -0400
Received: by mail-pd0-f176.google.com with SMTP id y13so3020393pdi.21
        for <git@vger.kernel.org>; Thu, 08 May 2014 19:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/29Oj9BQg10Qhvg+bG7/UEsBHUOL5r3McUqcfCdCxr8=;
        b=uIGZfSiq/+lyErCy9ViNJHBmOmgSTkMWMBLrL2a+1AqqHkB9ZyT83t7G6L9HXz9gyX
         ENOAm0YxtRvBKX8nzapSTzNqzcgL3DCyD1yKh3tt2JsQN+GlkRLxlA+73XXRV+OIQ+D/
         QWb9SIftpZswcrQi8OwS4gq8Bu4rRpT7J0fw2NaxQrh/srfb7RbmKu6Z5BfbwnhkRo78
         5ZClVTSY4sGYsBzuirdeXjJY6NZly/Wj1m48+wp9yIPzMZvHXzT0uCO+RCTIBl5/AhW/
         bWCyYjT16bYEwFjuyxn7lxK324KbVPCCF1mINUJEA5fR7JSwN/icegQqbc7/WUtuZF5d
         Uulg==
X-Received: by 10.66.142.73 with SMTP id ru9mr14384014pab.41.1399601351556;
        Thu, 08 May 2014 19:09:11 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id z3sm867498pas.15.2014.05.08.19.09.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 08 May 2014 19:09:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140509015429.GA550@wst420>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248501>

(cc-ing Pete Wyckoff who maintains git-p4 and Michael Haggerty
who maintains git-multimail)
Hi,

William Giokas wrote:

>      - We follow PEP-8 (http://www.python.org/dev/peps/pep-0008/).
>
> It's even the first thing that you see when you go looking for 'python'
> in the coding style document. I just ran every file in the tree that
> either ended in '.py' or had a python #!, and was greeted with a whole
> bunch of output::
>
>     ./git-p4.py
>     ./contrib/svn-fe/svnrdump_sim.py
>     ./contrib/remote-helpers/git-remote-bzr
>     ./contrib/hooks/multimail/post-receive
>     ./contrib/hooks/multimail/migrate-mailhook-config
>     ./contrib/hooks/multimail/git_multimail.py
>     ./contrib/hooks/multimail/README
>     ./contrib/hg-to-git/hg-to-git.py
>     ./contrib/gitview/gitview
>     ./contrib/fast-import/import-zips.py

Thanks for running this check.  Passing on the result to the
maintainers of some of those scripts in case they have thoughts.

As someone involved in contrib/svn-fe/, I would be happy to take a
patch making svnrdump_sim.py follow PEP-8, if you have time to write
one.

Thanks,
Jonathan

List of warnings kept below for reference.

>     20      E101 indentation contains mixed spaces and tabs
>     90      E111 indentation is not a multiple of four
>     9       E112 expected an indented block
>     47      E113 unexpected indentation
>     1       E121 continuation line under-indented for hanging indent
>     3       E122 continuation line missing indentation or outdented
>     3       E124 closing bracket does not match visual indentation
>     12      E125 continuation line with same indent as next logical line
>     9       E126 continuation line over-indented for hanging indent
>     4       E127 continuation line over-indented for visual indent
>     63      E128 continuation line under-indented for visual indent
>     4       E129 visually indented line with same indent as next logical line
>     3       E131 continuation line unaligned for hanging indent
>     37      E201 whitespace after '['
>     30      E202 whitespace before ']'
>     30      E203 whitespace before ':'
>     37      E211 whitespace before '('
>     10      E221 multiple spaces before operator
>     14      E222 multiple spaces after operator
>     8       E223 tab before operator
>     1       E224 tab after operator
>     35      E225 missing whitespace around operator
>     6       E228 missing whitespace around modulo operator
>     23      E231 missing whitespace after ','
>     10      E251 unexpected spaces around keyword / parameter equals
>     1       E261 at least two spaces before inline comment
>     1       E262 inline comment should start with '# '
>     37      E265 block comment should start with '# '
>     1       E301 expected 1 blank line, found 0
>     117     E302 expected 2 blank lines, found 1
>     19      E303 too many blank lines (2)
>     4       E401 multiple imports on one line
>     220     E501 line too long (83 > 79 characters)
>     5       E502 the backslash is redundant between brackets
>     33      E701 multiple statements on one line (colon)
>     11      E702 multiple statements on one line (semicolon)
>     34      E703 statement ends with a semicolon
>     9       E711 comparison to None should be 'if cond is None:'
>     2       E713 test for membership should be 'not in'
>     1022    W191 indentation contains tabs
>     40      W601 .has_key() is deprecated, use 'in'
>     1       W602 deprecated form of raising exception
>     1       W603 '<>' is deprecated, use '!='
>     1       W604 backticks are deprecated, use 'repr()'

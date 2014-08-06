From: Linus Arver <linusarver@gmail.com>
Subject: Re: [PATCH 7/7] Documentation: git-init: flesh out example
Date: Tue, 5 Aug 2014 22:34:29 -0700
Message-ID: <20140806053428.GD12559@k0>
References: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
 <1407002817-29221-8-git-send-email-linusarver@gmail.com>
 <xmqqegwuoa7b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 07:34:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEtry-0004ud-7z
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 07:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442AbaHFFee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 01:34:34 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:54933 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbaHFFee (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 01:34:34 -0400
Received: by mail-yh0-f51.google.com with SMTP id f73so1368070yha.24
        for <git@vger.kernel.org>; Tue, 05 Aug 2014 22:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=dr0SvbZNSRks6ZokatY8Nu9ij4SXdEHtGVNQX1NaMi8=;
        b=ly0Z+enEwcLzELIYS8snNt7SZ71gt35Nih1lWnCbmi7A3k6FyB1nsIyrn/ejU7xbof
         nnwnHSCQXw4+Rbf1PEpQL9vsxVnzHUomhhjO7KCkO6EfRnAl7l2gJRdG/jXlXK5M417d
         RIm+Bc9E3WgyNwPoaMKVH6snyvOtwlgbdlEX3gl9N/wYnu8k6YmkCj9q42WT85sRxYBq
         hH3t2y13DAhic5P+QvZdVcdWMvxj0Mfa3Mc5nvdCjauDMdST9FIWC5ej/cif5dcFLRV0
         TU8zP7tacPdqgiWyVOQr2GPXUWUIOhKi/1Ntrfthct8LxB0YcZpjGouUIFA5ikplu2GB
         N5dQ==
X-Received: by 10.236.150.199 with SMTP id z47mr648587yhj.199.1407303273362;
        Tue, 05 Aug 2014 22:34:33 -0700 (PDT)
Received: from k0 (107-223-14-32.lightspeed.sntcca.sbcglobal.net. [107.223.14.32])
        by mx.google.com with ESMTPSA id f45sm6893237yha.53.2014.08.05.22.34.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Aug 2014 22:34:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqegwuoa7b.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254848>

On Tue, Aug 05, 2014 at 03:14:48PM -0700, Junio C Hamano wrote:
> Linus Arver <linusarver@gmail.com> writes:
> 
> > Signed-off-by: Linus Arver <linusarver@gmail.com>
> > ---
> >  Documentation/git-init.txt | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
> > index b94d165..16e9f9c 100644
> > --- a/Documentation/git-init.txt
> > +++ b/Documentation/git-init.txt
> > @@ -138,10 +138,12 @@ Start a new Git repository for an existing code base::
> >  $ cd /path/to/my/codebase
> >  $ git init      <1>
> >  $ git add .     <2>
> > +$ git commit    <3>
> 
> I agree it is a good discipline to make the initial "pristine"
> import immediately after "git add ." without doing anything else.
> Perhaps the description below wants to make it more explicit?
> 

I could add a comment like the following:

    For new repositories, creating a commit immediately after "git add
    ." is good practice as it will cleanly separate any preexisting work
    (done under some other VCS, for example) from any new work done with
    git.

Does this make sense? I am not sure how explicit you want it to be, or
whether I captured what you wanted to be explained.

Actually, I would like to know if anything is special about the
"root-commit" (I only know it is written as such, with a hyphen, because
that is what you get from git's output message). I am not sure if this
"root-commit" idea is explained in detail in git's other documentation.
> >  ----------------
> >  +
> > -<1> prepare /path/to/my/codebase/.git directory
> > -<2> add all existing file to the index
> > +<1> Create a /path/to/my/codebase/.git directory.
> > +<2> Add all existing files to the index.
> > +<3> Create the first root-commit.
> >  
> >  GIT
> >  ---

From: Linus Arver <linusarver@gmail.com>
Subject: Re: [PATCH 7/7] Documentation: git-init: flesh out example
Date: Fri, 8 Aug 2014 09:49:42 -0700
Message-ID: <20140808164941.GC791@k0>
References: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
 <1407002817-29221-8-git-send-email-linusarver@gmail.com>
 <xmqqegwuoa7b.fsf@gitster.dls.corp.google.com>
 <20140806053428.GD12559@k0>
 <xmqqoavxms7d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 18:49:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFnMZ-0004Rg-O3
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 18:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757101AbaHHQtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 12:49:49 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:47500 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756784AbaHHQtr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 12:49:47 -0400
Received: by mail-yh0-f45.google.com with SMTP id 29so4311330yhl.32
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 09:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=HR6BmhVfl+It+gfe9P2RMsjHAcsvCDgnA28nyFnkuOk=;
        b=u5IpaIRLGD5wI4BNCVanM6vIp2/sWuEw+5ghui06tuwRw1z3YdNswIgXrAlFS3jKo6
         gtTyIPZOtPKsLK+EkdqTMSqbP3tUPlWiPHuiJSe7OAVsBuFH/UoUJPgk+x3ryJdP3wPq
         /SdWSOUF7yCxwn2pHNd9f0LIZVazduLAuo6HCn8MU9qqENqb5kPU77oFeaZayvnXCADL
         wqRpdDfvUNfDZNIwsrSOU1Kd5g9xSgdI2L0WAJef42yctRy5FOL2nG9dk3hOPtE8+zMg
         3xXJhc1CpnMPVJNFPoCIt4b7A73+hTAb6gql0ccFwRQx5SG20JxIZlh/a/rAXDgDDL+f
         TNHA==
X-Received: by 10.236.76.105 with SMTP id a69mr16128208yhe.8.1407516586741;
        Fri, 08 Aug 2014 09:49:46 -0700 (PDT)
Received: from k0 (107-223-14-32.lightspeed.sntcca.sbcglobal.net. [107.223.14.32])
        by mx.google.com with ESMTPSA id i24sm6611607yha.12.2014.08.08.09.49.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Aug 2014 09:49:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqoavxms7d.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255047>

On Wed, Aug 06, 2014 at 10:41:10AM -0700, Junio C Hamano wrote:
> Linus Arver <linusarver@gmail.com> writes:
> 
> > On Tue, Aug 05, 2014 at 03:14:48PM -0700, Junio C Hamano wrote:
> >> Linus Arver <linusarver@gmail.com> writes:
> >> 
> >> > Signed-off-by: Linus Arver <linusarver@gmail.com>
> >> > ---
> >> >  Documentation/git-init.txt | 6 ++++--
> >> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
> >> > index b94d165..16e9f9c 100644
> >> > --- a/Documentation/git-init.txt
> >> > +++ b/Documentation/git-init.txt
> >> > @@ -138,10 +138,12 @@ Start a new Git repository for an existing code base::
> >> >  $ cd /path/to/my/codebase
> >> >  $ git init      <1>
> >> >  $ git add .     <2>
> >> > +$ git commit    <3>
> >> 
> >> I agree it is a good discipline to make the initial "pristine"
> >> import immediately after "git add ." without doing anything else.
> >> Perhaps the description below wants to make it more explicit?
> >> 
> >
> > I could add a comment like the following:
> >
> >     For new repositories, creating a commit immediately after "git add
> >     ." is good practice as it will cleanly separate any preexisting work
> >     (done under some other VCS, for example) from any new work done with
> >     git.
> >
> > Does this make sense? I am not sure how explicit you want it to be, or
> > whether I captured what you wanted to be explained.
> 
> I was thinking more along the lines of
> 
>     <3> Record the pristine state as the first commit in the history.
> 
> which should suffice without becoming excessively verbose.

Ah yes, I like the brevity.

> > Actually, I would like to know if anything is special about the
> > "root-commit"...
> 
> As far as Git is concerned, they are just ordinary commits without
> any parents.  A commit in Git can have zero or more parents, so from
> that "structural" point of view, they are not that special.
> 
> They are considered special by users because they represent the
> beginning of the project history.

Thank you for the insight. I won't bother adding a blurb about
"root-commit" and what it means because they are not that special, as
you said so yourself.

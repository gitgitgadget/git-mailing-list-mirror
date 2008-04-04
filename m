From: "Pat Maddox" <pergesu@gmail.com>
Subject: Re: Submodules and branches
Date: Fri, 4 Apr 2008 13:07:16 -0700
Message-ID: <810a540e0804041307l665442eapcb5547343358df04@mail.gmail.com>
References: <810a540e0804041240p4efd0973g7f46a2021b352822@mail.gmail.com>
	 <32541b130804041302i1e32e4b3l141e8b08200a2357@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 04 22:08:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhsCg-00032q-Vy
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 22:08:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756713AbYDDUHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 16:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756227AbYDDUHT
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 16:07:19 -0400
Received: from rn-out-0910.google.com ([64.233.170.191]:64834 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444AbYDDUHS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 16:07:18 -0400
Received: by rn-out-0910.google.com with SMTP id e24so363236rng.1
        for <git@vger.kernel.org>; Fri, 04 Apr 2008 13:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4QuhTaN9CEEeYNOdrpdjI4WUkobPKd1vq0mO+XHAf3s=;
        b=nvKqtXRex8VmbJ5Rg3O+SpLZl0EGhW1aZlm2NlbnB4JqoAuG9DtOOhk/A2Bj4CVZucnOzSaxYy92sVlqhbGLU1m059twsdPZlUKHQELsvJH4EqcO7nedaf6iy0YYdVZ/wrxe5R+i1kuM4KAr4rDflSfC1EttvXLLOjcgdA47Hfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MYm0uRpOFgsmeaOirjEq25tmtdwjY97spT+UxjyaaR/+NiZpHkg1jqapsvgHsK99N6XlxaeiE/WrmRbV95ZegyO9ZBsCqtoP1NAP5Knl+mtfri2/g4Cx0wQo2x7Y+rzot6JwrFljhCRNHHLlk81KykNUGA3gJgQwoI0ZvU70iZ0=
Received: by 10.114.149.2 with SMTP id w2mr2776766wad.29.1207339636821;
        Fri, 04 Apr 2008 13:07:16 -0700 (PDT)
Received: by 10.114.146.5 with HTTP; Fri, 4 Apr 2008 13:07:16 -0700 (PDT)
In-Reply-To: <32541b130804041302i1e32e4b3l141e8b08200a2357@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78814>

On Fri, Apr 4, 2008 at 1:02 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
> On 4/4/08, Pat Maddox <pergesu@gmail.com> wrote:
>  > I've got a repository that uses submodules.  If I cd to the repo root
>  >  and create a branch, all the submodules are switched to that branch as
>  >  well.  All good so far.  I go into the submodules and do my work,
>  >  committing as I go along.  Then when I'm all done and want to merge
>  >  the changes into my master branch, I cd back to the repo root and do
>  >  "git merge new_topic"
>  >
>  >  That's where it breaks down.  The commits that I made go into the
>  >  master repo itself, and the submodules don't have them.
>
>  There is something wrong with your story somewhere: submodules in git
>  each have their own, completely independent,
>  branching/merging/pulling/pushing etc.  What makes you think the
>  submodules are branching at the same time as your supermodule?
>
>  Perhaps you have accidentally committed the *files* from your
>  submodule into your supermodule, which means you're not using
>  git-submodule at all.

Hi Avery,

You're right, something was screwed up with the repo.  One of the
paths was added as a submodule, but it also had files committed to it.
 I fixed all of that up and it seems to be fine now.

Pat

From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: RFC: Website redesign
Date: Mon, 14 Apr 2008 15:56:06 +0200
Message-ID: <2c6b72b30804140656g14c24d8cwae016d62fe12f4a7@mail.gmail.com>
References: <3175605f-ff32-4fd6-bed3-7ae596ecbcde@q1g2000prf.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dill <sarpulhu@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 15:57:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlPB2-0002kf-Bq
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 15:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754405AbYDNN4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 09:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753336AbYDNN4J
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 09:56:09 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:8347 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752592AbYDNN4I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 09:56:08 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1105814wxd.4
        for <git@vger.kernel.org>; Mon, 14 Apr 2008 06:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=dgEf1ZzqYwCVe3CxmapuBDPuLip8hqrsjuBg3CDtOEc=;
        b=BPxGmhg2NsoKfMXKMWRM8E+OrWhnV7WnSIOm61xs2TBYXuW/ixpw+/GEGoKfRcuFItUOQlj3z3XgJJ9kE9oYAzFnAp5cXb/yB5BdSQdTfPIWxeRqVoiaxxa42TCRscgbg0oXAOZIQ8PWQKNJIPbta4PnIdhN6zguy0vfXdretMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ed+khp4jxaKx4at6JzZLd2NuscW9vaSRdXhlJAUwh9RFurYITGL/rE6SFuW2zkLEkrSi9iFYLzWtvdCfc5ZwHc7FmszsFJvFEQ32QQ1sg4YGnjTLqyczx4eRaiX/EQYybpzv61Rrt7sWY4Odb3FELT0ygUyYmGJrJQB+AAbGXmE=
Received: by 10.141.175.5 with SMTP id c5mr3340411rvp.281.1208181366743;
        Mon, 14 Apr 2008 06:56:06 -0700 (PDT)
Received: by 10.141.3.15 with HTTP; Mon, 14 Apr 2008 06:56:06 -0700 (PDT)
In-Reply-To: <3175605f-ff32-4fd6-bed3-7ae596ecbcde@q1g2000prf.googlegroups.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79502>

Hello Dill,

On Mon, Apr 14, 2008 at 7:37 AM, Dill <sarpulhu@gmail.com> wrote:
> I was looking at the main git site and thought that maybe it could be
>  done differently. I tried to make it simple and professional looking
>  and have all the same information as the old site. I've spend a good
>  portion of the day hashing it out and wanted to hear what others
>  thought. Worth changing? Like it or not?

Yes, it is definitely worth changing. In all the user surveys to date people
has commented on the design of the git homepage mentioning words like
ugly, not useful, strangely named, etc. After the last survey I registered
git-scm.org to have a more friendly name.

Question is what kind of "official" home page is suitable for git? As it is now,
most projects using git provides documentation for what kind of workflow
they recommend for their specific project, and else the git distribution point
on kernel.org has the latest manpages, tutorials etc. supplemented by the
git wiki.

Your examples capture this very good in the sense that the homepage should
basically be a very simple page that send visitors in the "right" direction for
getting documentation, downloading the latest release, and joining the
community.
I like the restlet.org page with its four basic tasks. As your
examples also suggest
and as a fourth task, it could be nice to also in time fill the void
of having a news
source about git related releases, developer interviews, GSoC info, the Msysgit
Herald, and other interesting stuff happening in the community for people who do
not feel they have the time to read the mailing list. This of course
requires that there
is a small dedicated team for collecting and preparing these updates. I would be
willing to help, but have occasional fall-outs where I do not read the
mailing list.

Regarding the design/style etc, I am credited for the current one that
Petr forked from
the ELinks homepage. It is ugly, and git deserved better! This is just
to say that I probably
shouldn't be part of this work. I find your redesign proposal 1, 3 and
4 a too dark or gray.
Number 2 (git2) with its bluish has some nice ideas. The text might be
too small, at least
from what I am seeing and the list menu has a strange coloring.

If the home page should carry news it needs to have infrastructure so
that we don't need
to bug Petr each time it should be updated. I have commit access to
the git-homepage
repo and maybe Petr could add others as well, but the question is if
we want some web
interface for submitting news. I registered git-scm.org after the last
survey and right now
it is just set up as an alias for git.or.cz. It comes with some PHP
capability which could
serve as a place to develop a redesign, however, I am not hosting it
myself and I don't
know what kind of traffic will be required.

-- 
Jonas Fonseca

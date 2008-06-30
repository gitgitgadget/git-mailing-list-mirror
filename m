From: "Sean Kelley" <sean.v.kelley@gmail.com>
Subject: Re: EasyGit [Was: Re: my git problem]
Date: Mon, 30 Jun 2008 11:23:10 -0500
Message-ID: <89b129c60806300923w232cb3e2s5a46790475f7afec@mail.gmail.com>
References: <51419b2c0805020441l7a52f9d2q6bfc8eb4e18e4e7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Carl Worth" <cworth@cworth.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, git@vger.kernel.org,
	"Havoc Pennington" <hp@pobox.com>
To: "Elijah Newren" <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 18:24:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDMAw-0002xB-1E
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 18:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755153AbYF3QXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 12:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755462AbYF3QXN
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 12:23:13 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:49452 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153AbYF3QXL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 12:23:11 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1079949wri.5
        for <git@vger.kernel.org>; Mon, 30 Jun 2008 09:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=NCIRQBp0Fa9102hE+t7539Ll50tTZQq2VtGyyj5S1sU=;
        b=Mg2MeYiabkSQnqQXNE9fhSI+ZmeAt/yFyTJoiTG+T2MwFrLVlZG4eowlWy2OmVOr7C
         5/Iv+bQo5ghfJVkEskHPtYFdsbgwooJ/VnFbKAfVRdCPeT4IUiRlRcu31UQYDwOIi4/S
         VSNEXjniuqn2kW2VgfQwuXsVKTzRshhkB5Ogw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Ji+VuKA2RvqXYwD92RgsDMlltj6EwhDSVYq+XIGNc16brl0V+RidA4DiANFSS4Bj/B
         eW93N86K1MIKxjpLj+c4DVMlenfBOTLjUf1zmSnUbfmUgTI1nidNno2i/wDBCDdQPAWP
         8tJt85D5lqFhI/QsDlyDq5OKzhKY8oW6oHS9U=
Received: by 10.90.98.13 with SMTP id v13mr5198574agb.86.1214842991021;
        Mon, 30 Jun 2008 09:23:11 -0700 (PDT)
Received: by 10.90.102.16 with HTTP; Mon, 30 Jun 2008 09:23:10 -0700 (PDT)
In-Reply-To: <51419b2c0805020441l7a52f9d2q6bfc8eb4e18e4e7e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86919>

On Fri, May 2, 2008 at 6:41 AM, Elijah Newren <newren@gmail.com> wrote:
> On Thu, May 1, 2008 at 12:01 AM, Carl Worth <cworth@cworth.org> wrote:
>>  Or maybe go Elijah's route and invent a new top-level command name in
>>  which issues like this can get fixed. (I've been lukewarm on the idea
>>  after watching the cogito attempt eventually be abandoned. I'd really
>>  much rather see Elijah's ideas get pushed down into git itself for the
>>  most part. But it's tough when backwards-compatibility prevents fixing
>>  some things that are obviously confusing people.)
>
> Except my route really doesn't fix things like this since I also
> pushed for backwards compatibility.  You'll note that Havoc used
> EasyGit and Git interchangably (both in his description and probably
> on his projects), since all I've really done so far in EasyGit is
> * provide built-in tutorial-oriented documentation
> * check for common user mistakes and warn about them
> * add subcommand options in a way that breaks up the near cylic
> knowledge dependence of git subcommands so that they can be learned in
> a layered/hierarchical fashion
> * add some gratuitous svn-compatibility commands to ease the
> transition for svn users
>
> I agree that it would be nice to get this stuff (other than the last
> point that likely doesn't make sense for git-core) into git
> itself...if the community wants it.

I agree with Carl in that my fear is that this will go the same route
as cogito if it doesn't get into git itself.  We use mercurial rather
extensively at garmin on my teams. There are a number of items I
really miss from git.  For the most part I believe Carl has enumerated
in other threads the sort of items that cause the greatest issues with
usability.

I think you addressed the first steps rather well with eg.

Sean

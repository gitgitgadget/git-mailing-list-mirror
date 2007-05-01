From: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>
Subject: Re: git-svn and local only topic branch
Date: Tue, 1 May 2007 19:30:01 +0200
Message-ID: <8b65902a0705011030l43d693fcoa831f1764cbbfb58@mail.gmail.com>
References: <8b65902a0705010940pb3bfb16u624d470068351624@mail.gmail.com>
	 <0E0C5313-0DCA-4DE5-96C5-9AD74758B68A@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Adam Roben" <aroben@apple.com>
X-From: git-owner@vger.kernel.org Tue May 01 19:30:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiwB0-0000G2-Dt
	for gcvg-git@gmane.org; Tue, 01 May 2007 19:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755027AbXEARaG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 13:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755032AbXEARaG
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 13:30:06 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:55698 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755030AbXEARaD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 13:30:03 -0400
Received: by an-out-0708.google.com with SMTP id b33so1665881ana
        for <git@vger.kernel.org>; Tue, 01 May 2007 10:30:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CmD9CXc4WkQPFhY2DXNxOsPUHylWN/bjmVadbJ6e0yVIAXlrvvhWkQ95MLcJrG19GLvfsXvxaSsoBTZVwurzmCx4WUjjmbgfTLKv+sLjjpTuDHAsxH0QdEiRcZp8qjFm2vy+IY/jUtWc3FB7/zi1C9U8rIRczEZCg9r68TYzeqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bJOi9LDoDDCQ8KTYeYBq4qoG+pkwA+jS7nINsXnDpA33TtkFuavJZvXrqwIH+DTD+CGkzVDVRMdh/gTNkNPjkjIHpvck9j/RPSFLOw63fT4b+umrzqRQb4oRVkl6ZRwsQkf/Gg942vl+Hq+YJkyr6UEGI+Od6siJdUXLhaIS+Mg=
Received: by 10.100.211.11 with SMTP id j11mr5141533ang.1178040601244;
        Tue, 01 May 2007 10:30:01 -0700 (PDT)
Received: by 10.100.46.11 with HTTP; Tue, 1 May 2007 10:30:01 -0700 (PDT)
In-Reply-To: <0E0C5313-0DCA-4DE5-96C5-9AD74758B68A@apple.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45961>

On 5/1/07, Adam Roben <aroben@apple.com> wrote:
> On May 1, 2007, at 9:40 AM, Guilhem Bonnefille wrote:
> > I'm using Git as a SVN frontend (via git-svn). Recently, I made a
> > topic branch, I did some job on it and wish to "upload" my work (on
> > the SVN). But, I do not want "pushing" all commits, I only want to
> > create a single commit on the SVN, while keeping full commits on my
> > Git repo. But I did not find how to do this.
>
>     If you just want to make a commit to Subversion containing all the
> changes on your branch, then you should be able to do this:
>
> git svn commit-diff upstream topic
>
>     That will take the entire diff between upstream and your topic
> branch and make one commit to Subversion containing that diff.

Yes, I want to make a single commit on Subversion containing all the
changes of my topic branch. But I also want to keep track of this
"merge" in my local Git repo. So I want that the new commit on my
upstream branch store an ancestry with both upstream and topic
branches.

I fear that "commit-diff" will only produce a commit on SVN, that will
be stored as a single and normal commit on my (local) upstream branch.

-- 
Guilhem BONNEFILLE
-=- #UIN: 15146515 JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
-=- mailto:guilhem.bonnefille@gmail.com
-=- http://nathguil.free.fr/

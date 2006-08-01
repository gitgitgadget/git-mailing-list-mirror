From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Diff format in packs
Date: Tue, 1 Aug 2006 14:36:38 +1200
Message-ID: <46a038f90607311936w17974396h656ace07e365c69b@mail.gmail.com>
References: <9e4733910607311408i10e17dse776920de7c5076a@mail.gmail.com>
	 <ealruh$sq9$1@sea.gmane.org>
	 <9e4733910607311420n8537b76lbde4d60062195403@mail.gmail.com>
	 <46a038f90607311747j947c786s6af2fe637dbde89d@mail.gmail.com>
	 <9e4733910607311813l78791e40l1234cf0e458db66f@mail.gmail.com>
	 <46a038f90607311916k5d130f70gc0ac26eb8f15fec0@mail.gmail.com>
	 <9e4733910607311929j189eb6b9r6a804cc744290fdc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 04:36:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7k7f-0008Bs-KU
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 04:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030399AbWHACgk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 22:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030398AbWHACgk
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 22:36:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:15398 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030399AbWHACgj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 22:36:39 -0400
Received: by nf-out-0910.google.com with SMTP id o25so109195nfa
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 19:36:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IkZFB6U9FLheyckWspz+0mMO8nFM5WW7yxvRO/dYAv2LRSGsLkQC/uRnbJOOfBsjRC0q7e7ES7lyUqBfM7pjMiO7DNmb2qiJT5ywj+4GFPyKIZEH2qWLfU8J3FPSXm4+CcAZaU5Kxgf7z6s3yO9pNpOO9efIMbzw+CnzOhWGem8=
Received: by 10.78.177.3 with SMTP id z3mr107423hue;
        Mon, 31 Jul 2006 19:36:38 -0700 (PDT)
Received: by 10.78.120.17 with HTTP; Mon, 31 Jul 2006 19:36:38 -0700 (PDT)
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910607311929j189eb6b9r6a804cc744290fdc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24568>

On 8/1/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 7/31/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> > > would be to use cvs2svn to build the changeset database and then use
> > > cvsps to simply read the changesets out of it and build the git
> > > repository.
> >
> > Once cvs2svn has the db built, it should be easy to write a
> > perl/python script that mimics the output of cvsps.
>
> This is an efficiency problem. My strategy instead is to build the git

Agreed when it comes to the initial import. I thought you were meaning
for "driving" git-cvsimport when doing incrementals.

> People on the Python list have been giving me some pointers on how to
> build the revision files efficiently. That's what I am working on
> right now.

You can definitely steal that from parsecvs -- it should be trivial to
get parsecvs to do the RCS -> GIT part and store on disk the
path/revision -> SHA1. Yes?

cheers,


martin

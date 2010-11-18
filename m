From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Submodules or similar for exercise/exam management
Date: Thu, 18 Nov 2010 17:49:16 -0600
Message-ID: <20101118234916.GB21621@burratino>
References: <201011181109.08345.trast@student.ethz.ch>
 <4CE5988F.7050309@web.de>
 <7vsjyyb6ui.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>, in-gitvger@baka.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 00:50:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJEF0-0000GC-G1
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 00:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759484Ab0KRXuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 18:50:04 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40414 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756649Ab0KRXuD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 18:50:03 -0500
Received: by vws13 with SMTP id 13so2175880vws.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 15:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kShKBJ+DnBmrzcbtObVTeHGRNIpa5O/TTvqep2r2BvU=;
        b=lJVBT9RTV47Ha67goyE0u2ZTK+TS1GIQRCw2s4xp2SrMhpROn1jahto7cU0urlV6IK
         OYJ9fEKeF8qHeVYbO8wkTqvwBxsnVzL0kO22N+Dx44DK4xvY8Dp0BzmM3Mibo+PgZ5TV
         cxB0q2ihz+YbKgaiwWvrlFrrNbpRxyuNZIS4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=k150PFT7ghQLJOWwHmFvjVJKFvletkOOxJPkHPHO7rIrs0MfjWHpU27BYqZjHn4cZY
         cQ597HCWD2TVsthCQ3QHYmmF7r7WWnKaPoLXVWmHLXnHJw63qY+6eq4U4FeHNJ4XlHt4
         NhWeguvC4MtwRSpPDlTTFKLNeeczFEzdl6s74=
Received: by 10.220.182.10 with SMTP id ca10mr276509vcb.125.1290124202042;
        Thu, 18 Nov 2010 15:50:02 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id j22sm248381vcr.31.2010.11.18.15.49.59
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Nov 2010 15:50:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vsjyyb6ui.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161718>

Junio C Hamano wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:

>>> 3) never need to be aware of repo boundaries or manipulate sub-repo
>>
>> I think that this requirement is the hardest for any solution I know
>> of or can imagine, as you hit these boundaries sooner or later either
>> when you want to commit, push and/or when you have to resolve merge
>> conflicts.
>
> Just a quick sanity check.  When this "requirement" makes sense, does the
> whole thing need to be a superproject with bunch of submodules, and why?

In this example: because the submodule represents individual
questions that are used by multiple exams.

Another instance of the same (slightly uncomfortable :)) practice:
suppose a certain chapter is part of multiple works I have
published --- maybe in an article and a larger book.  When working on
the book:

 - I do not want to make changes to that chapter and forget to commit
   them.

 - After making changes to many chapters, I do not want the fuss of
   going from chapter to chapter and commiting them one by one.

 - I certainly do not want to publish a version of the book that
   "includes" versions of the chapters as dead links, so to speak.
   That is, when I publish the current version of the book, I want
   to publish the current version of all chapters, too.

 - When starting work on the book again after long absence, I would
   like to be able to see and have the chance to adopt changes to
   chapters made as part of this book and as part of others.

If I understand correctly.

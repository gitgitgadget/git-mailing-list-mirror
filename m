From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: packs and trees
Date: Wed, 21 Jun 2006 07:41:57 +1200
Message-ID: <46a038f90606201241x3dec242dicde245a24c3ab9ab@mail.gmail.com>
References: <9e4733910606192257y1516e966t848a3b1e29e5667f@mail.gmail.com>
	 <46a038f90606192313l16b16132r1523f5e05ae1566a@mail.gmail.com>
	 <Pine.LNX.4.64.0606201102410.3377@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jon Smirl" <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 20 21:42:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fsm6s-0004x6-9z
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 21:42:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWFTTl7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 15:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWFTTl7
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 15:41:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:54956 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750823AbWFTTl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 15:41:58 -0400
Received: by ug-out-1314.google.com with SMTP id a2so2441535ugf
        for <git@vger.kernel.org>; Tue, 20 Jun 2006 12:41:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T99gSS3l68w2Fatz8PVpOY8IPmeYVZS9PmFBBHmgBn6n53yVu7OhoBXyvORyEZJE8ZOSmtXdB/nMa9KO0A+Sne3+gmZ1ye5HNgx7cmYeSLk9AOMgz1pxzlbWYECyLX14YMLTygtNOdFRMdRSU2tLSpdbVzh5GZHcSitTKvCHjQ0=
Received: by 10.78.51.9 with SMTP id y9mr2932360huy;
        Tue, 20 Jun 2006 12:41:57 -0700 (PDT)
Received: by 10.78.117.11 with HTTP; Tue, 20 Jun 2006 12:41:57 -0700 (PDT)
To: "Nicolas Pitre" <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0606201102410.3377@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22220>

On 6/21/06, Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 20 Jun 2006, Martin Langhoff wrote:
>
> > On 6/20/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> > > The plan is to modify rcs2git from parsecvs to create all of the git
> > > objects for the tree.
> >
> > Sounds like a good plan. Have you seen recent discussions about it
> > being impossible to repack usefully when you don't have trees (and
> > resulting performance problems on ext3).
>
> What do you mean?

I was thinking of the "repacking disconnected objects" thread, but now
I see it did have a solution in listing all the objects and paths. I
take that back.

If you are asking about the ext3 performance problems, I think Linus
discussed that a while ago, why unpacked repos are slow (in addition
to huge), and there were some suggestions of using hashed directory
indexes.

cheers,


martin

From: "Craig L. Ching" <cching@mqsoftware.com>
Subject: Subversion is actually not so simple (was RE: Considering teaching plumbing to users harmful)
Date: Thu, 17 Jul 2008 11:11:37 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F79430238A167@emailmn.mqsoftware.com>
References: <alpine.DEB.1.00.0807161804400.8950@racer><32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com><alpine.DEB.1.00.0807161902400.8986@racer><32541b130807161135h64024151xc60e23d222a3a508@mail.gmail.com><alpine.LNX.1.00.0807161605550.19665@iabervon.org><861w1sn4id.fsf@lola.quinscape.zz> <m3od4wse30.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>, "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jul 17 18:13:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJW6n-0005fv-69
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 18:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756944AbYGQQM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 12:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757386AbYGQQMZ
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 12:12:25 -0400
Received: from mail.de.mqsoftware.com ([66.192.70.108]:3836 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756944AbYGQQMY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jul 2008 12:12:24 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <m3od4wse30.fsf@localhost.localdomain>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Subversion is actually not so simple (was RE: Considering teaching plumbing to users harmful)
Thread-Index: AcjoJUfmPKmqiOjZTW2ypc0n9sa3AAAAFeJQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88872>

 

> -----Original Message-----
> From: git-owner@vger.kernel.org 
> [mailto:git-owner@vger.kernel.org] On Behalf Of Jakub Narebski
> Sent: Thursday, July 17, 2008 10:52 AM
> To: David Kastrup
> Cc: git@vger.kernel.org
> Subject: Re: Considering teaching plumbing to users harmful
> 
> Subversion is simple if you are limited to simple things; but 
> the same is true with Git.  I find for example the whole 'properties'
> mechanism and its use seriously not simple.
> 
Yes, that's exactly right.  Because SVN's underlying repository is
complex, it sometimes falls out in the UI.  If you stick with the way
SVN wants you to do things, you can get along with it fairly well.  But
that's the problem, it's just not flexible.  On the other hand, Git's
concept of the repository is so simple and clean, it's a DAG and you can
actually do a lot more with fewer commands.  But then you can do so much
more as well and work the way *you* want to.

For instance, SVN has a history of having to invent concepts that just
shouldn't need to be invented.  Their latest release includes something
they call "merge tracking", but it falls on the floor in the face of
what they call "reflective merging." [1]  I don't find "merge tracking"
and "reflective merges" concepts that I should *have* to understand when
it comes to working with a VCS, the VCS should just *do* those things.
Those concepts just don't exist in Git.  Frankly, I don't find
Subversion to be easier to use than Git at all and this is coming from a
very long-time CVS user.  I do find, however, that Git has a very large
vocabulary and that does take some time to learn, but I'd argue that
this is due to it's inherent flexibility than it is due to any inherent
flaws.

[1] -- http://blogs.open.collab.net/svn/2008/07/subversion-merg.html

> --
> Jakub Narebski
> Poland
> ShadeHawk on #git
> --

Cheers,
Craig

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 11:20:49 +0200
Message-ID: <200610181120.49749.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <87zmbucs86.wl%cworth@cworth.org> <45359F36.6050609@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Carl Worth <cworth@cworth.org>, Petr Baudis <pasky@suse.cz>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Oct 18 11:20:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga7b5-000723-4X
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 11:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWJRJUT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 05:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWJRJUT
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 05:20:19 -0400
Received: from hu-out-0506.google.com ([72.14.214.238]:16474 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932160AbWJRJUR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 05:20:17 -0400
Received: by hu-out-0506.google.com with SMTP id 28so1424048hub
        for <git@vger.kernel.org>; Wed, 18 Oct 2006 02:20:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=a827+psZbOVECYowYcWirRNJocV9V0tSKLKn6qmnbpG5ZmdC9dNMQ9VgsjYmmaun97IWz7XhhN1dmDqG/kTZHhhkQci2jmp2Qsr6YUZ25yLFLITfiWE7d5BcI4Pm8cA7xELOe1fdlKDd8P1gpujp8165yZUnzFrWfJyC9Rfo4rE=
Received: by 10.67.91.6 with SMTP id t6mr11432620ugl;
        Wed, 18 Oct 2006 02:20:15 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
        by mx.google.com with ESMTP id 5sm695948ugc.2006.10.18.02.20.14;
        Wed, 18 Oct 2006 02:20:14 -0700 (PDT)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
User-Agent: KMail/1.9.3
In-Reply-To: <45359F36.6050609@utoronto.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29211>

Aaron Bentley wrote:
> Carl Worth wrote:
>> On Wed, 18 Oct 2006 03:28:30 +0200, Jakub Narebski wrote:
>>> Isn't it easier to review than "bundle", aka. mega-patch?
>>
>> There are even more important reasons to prefer a series of
>> micro-commits over a mega-patch than just ease of merging.
> 
> A bundle isn't a mega-patch.  It contains all the source revisions.  So
> when you merge or pull it, you get all the original revisions in your
> repository.

But what patch reviewer see is a mega-patch showing the changeset
of a whole "bundle", isn't it?
[...]
>> Now, I do admit that it is often useful to take the overall view of a
>> patch series being submitted. This is often the case when a patch
>> series is in some sub-module of the code for which I don't have as
>> much direct involvement. In cases like that I will often do review
>> only of the diff between the tips of the mainline and the branch of
>> interest, (or if I trust the maintainer enough, perhaps just the
>> diffstat between the two). But I'm still very glad that what lands in
>> the history is the series of independent changes, and not one mega
>> commit.
> 
> So the difference here is that bundles preserve the original commits the
> changes came from, so even though it's presented as an overview, you
> still have a series of independent changes in your history.

I think it is much better to review series of patches commit by commit;
besides it allows to correct some inner patches before applying the whole
series or drop one of patches in series (and it happened from time to time
on git mailing list).

So if git introduces bundles, I think they would take form of series
of "patch" mails + introductory email with series description (currently
it is not saved anywhere), shortlog, diffstat and perhaps more metainfo
like bundle parent (which I think should be email form of branch really),
tags introduced etc.
-- 
Jakub Narebski
Poland

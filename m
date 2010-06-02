From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's the best way to make my company migrate to Git?
Date: Wed, 02 Jun 2010 09:15:24 +0200
Message-ID: <4C06050C.2040505@drmicha.warpmail.net>
References: <AANLkTikwpjtJnR856CHr_O3856JoMrFBgOQGODXNBbeI@mail.gmail.com>	<4BF7B751.7050704@pileofstuff.org>	<4BFB7F7F.5090407@drmicha.warpmail.net>	<4C041656.7000008@pileofstuff.org> <AANLkTinO_Z-1myhT-0TBIjELiEd4H-NnESs-AjTIpEf9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andrew Sayers <andrew-git@pileofstuff.org>,
	Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 09:16:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJiBL-0002RY-8h
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 09:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454Ab0FBHQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 03:16:00 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:56061 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751892Ab0FBHP7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jun 2010 03:15:59 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id BD1CAF8F84;
	Wed,  2 Jun 2010 03:15:48 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 02 Jun 2010 03:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=fiwoBn9J9P1lB9D6EBPo0F0Yda0=; b=ZLMMMEBH3OkYme4EBHbW/ybm4r3P349SAOK3C/1aYAwRzT2dkV8rdDSh3HbPB9AHjSaYz7NRpINE4HqeUfUiIR5k8VVUh/386nnZqIM3T8llaq8Z4VFS/QgELCp+o8MZoZO06Ad+G47s/KAkXv//ySvFFdWQ/7Pxs52OT0QhR9I=
X-Sasl-enc: DxjynmGxrG+GRRwTul6LQeUAUctWpYr4rrOK8ryDGiFw 1275462946
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 341184A21CD;
	Wed,  2 Jun 2010 03:15:46 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100526 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <AANLkTinO_Z-1myhT-0TBIjELiEd4H-NnESs-AjTIpEf9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148224>

Daniele Segato venit, vidit, dixit 01.06.2010 18:00:
> On Mon, May 31, 2010 at 10:04 PM, Andrew Sayers
> <andrew-git@pileofstuff.org> wrote:
>> On 25/05/10 08:42, Michael J Gruber wrote:
>>>
>>> Feel free to contribute to the Git Wiki maybe at
>>>
>>> https://git.wiki.kernel.org/index.php/GitDocumentation
>>>
>>> in the "User contributed Documentation" section.
>>>
>>> Michael
>>>
>>
>> Thanks for the hint - this turned into rather more than just uploading a
>> PDF, and I've now finished a complete write-up here:
>>
>>        https://git.wiki.kernel.org/index.php/SvnMigration
> 
> 
> That's a great job!
> 
> I want to point out some difficulties I encountered switching from
> Subversion to Git-SVN.
> I'd like to discuss them here before, eventually, contributing them to
> that page.

Andrew's main thrust is how to migrate a team, not how to migrate a code
base, and even less about the technical differences between svn and git.
And that makes it especially valuable.

I'd suggest not mixing these things. Andrew's page fills a gap about the
social aspects of the migration, and does so very well. He mentions very
few technical aspects, only those which you need to take into account
for planning out your team migration, i.e. relevant to advocacy, change
of philosophy, avoiding typical pitfalls.

There's already a score of pages about technical differences between git
and svn. So, please, add your technical aspects to those (or improve and
correct them), and/or link to corresponding or new pages from
SvnMigration under "See Also".

If you have additions to the migration aspects feel free to add them to
SvnMigration, of course. I know there's no sharp line but I don't want
to see a can of technical worms opened on that page :)

Cheers,
Michael

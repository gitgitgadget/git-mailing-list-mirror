From: "Willhelm Busch" <willhelm.busch@gmail.com>
Subject: Re: Questions about git-rev-parse
Date: Wed, 28 Feb 2007 21:16:09 -0500
Message-ID: <a51a02b80702281816j1ff9d42i5fc680752c515082@mail.gmail.com>
References: <Pine.LNX.4.64.0702271905200.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 01 03:16:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMaq8-0004ov-Og
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 03:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbXCACQL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 21:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbXCACQL
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 21:16:11 -0500
Received: from an-out-0708.google.com ([209.85.132.251]:33099 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932507AbXCACQK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 21:16:10 -0500
Received: by an-out-0708.google.com with SMTP id b33so296011ana
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 18:16:09 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rHGbt3rwRPrERitzg8tNcz8iQ2+3nTqry6I1QmUCezyO6rMCOSgNh9Aki2yqS0xqa59D0kv+D9eP0vn9Yy11NrWOXuuFe8g24zuXiwOgEafvoOOz4fbTlQ//WHwWW5NTK1aDE5wC1E2lseKCFxyZuWhv3kE9nQ8QKm/0FOJSpxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q6LqQBAnCuam+WRtp2boXYXaYpywec+zhklXr/iAT5yUFM/1DjIC0DGlvVn7nY8T7Y+YF0o7U/VAkVkVigY3ud5umfCrkQYP2aa/nbVjGLH5U5MTX5MER2DtKGpvSKcr/XDmEdlm1fvinJU8DhDEa/dKqZHCELOS6Deoui3u8fY=
Received: by 10.100.166.14 with SMTP id o14mr1136836ane.1172715369487;
        Wed, 28 Feb 2007 18:16:09 -0800 (PST)
Received: by 10.100.10.14 with HTTP; Wed, 28 Feb 2007 18:16:09 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0702271905200.12485@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41032>

On Tue, Feb 27, 2007 at 07:19:54PM -0800, Linus Torvalds wrote:
> On Tue, 27 Feb 2007, Theodore Ts'o wrote:
> >
> > So I was looking at git-rev-parse trying to understand the man page, as
> > I was trying to understand how various commands can accept lists (or
> > ranges) of commits, and the man page raised a number of questions.
> > First of all, the DESCRIPTION section doesn't quite parse as English:
> >
> >        Many  git  porcelainish commands take mixture of flags (i.e. parameters
> >        that  begin  with  a  dash  -)  and  parameters  meant  for  underlying
> >        git-rev-list  command  they use internally and flags and parameters for
> >        other commands they use as the downstream of git-rev-list.
> >
> > But, as best as I can gather that it's a helper function meant to do
> > some basic options parsing for those git porcelain commands that expect
> > to take a set of revision ID's.
>
> Heh. This is totally due to hysterical raisins.

When it comes to dancing time
 At the branch of the grapevine
Out pop many lively souls,
 From their seed pods, shells, and holes.

'Twas one balmy summer's night
 When some documents to write
Linus rested on the ground
 Near the dancers' cheery round.

Heedless of their drunken rages,
 He cranked out a few man pages,
As he started git-rev-parse,
 Came a merry nighttime farce.

When by wine they are made merry
 Certain fruits wax literary,
Writing nonsense as they please --
 Raisins are the worst of these.

They seized Linus as their chance.
 "Let us leave this odious dance!"
With a hysterical hop,
 Down they jumped, to his laptop!

As they made a small edit,
 Typed the raisins: "git commit"!
"Could my shell prompt be possessed?"
 Linus wondered, much distressed.

Linus scratched his Nordic pate.
 "I should not be up this late!
Coffee's addling my sight!
 Better finish for tonight."

In the main I'm laudatory
 Of the git repository.
It has weirdness and to spare,
 But the raisins put it there.

From: "Matt Graham" <mdg149@gmail.com>
Subject: Re: branch description
Date: Tue, 15 Apr 2008 23:46:26 -0400
Message-ID: <1c5969370804152046h8d67630m697ca71b523b04d9@mail.gmail.com>
References: <9b3e2dc20804150951scf8b3c7x26f3a56eab1f9840@mail.gmail.com>
	 <f9d2a5e10804151031o1d09c1f9od0ad78dcf9b746c5@mail.gmail.com>
	 <C55CA6EB-D427-4CF5-923E-DE0071D2F870@silverinsanity.com>
	 <7vej97x78v.fsf@gitster.siamese.dyndns.org>
	 <m3abjushvs.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Brian Gernhardt" <benji@silverinsanity.com>,
	"Russ Dill" <russ.dill@gmail.com>,
	"Stephen Sinclair" <radarsat1@gmail.com>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 06:35:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlycG-0004Sy-OH
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 05:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961AbYDPDq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 23:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754326AbYDPDq1
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 23:46:27 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:33083 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939AbYDPDq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 23:46:27 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2232961wff.4
        for <git@vger.kernel.org>; Tue, 15 Apr 2008 20:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=2GmZw+xlgCZ6qEYkHHc50wv+pF78hXAoMm49UTxtobw=;
        b=SN/O1T4KqZuz1nnvyasFyH1sFsp0rFQB7bfbUA8CTkeVJjjLiYNL/acLOqGPm4wSlCJZqZIRuRl7Gml6xbzvNL0zQZ5B5b6upykDw7TnfimXz7A7OKbbm/Z9sdkQtQTF7qWLIyBItFTiszQj2HVclSKryNy/6qC/W8hTMFmcPFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nHIb5C0ZxeTCwMoW0HTkRT4HLnB16kAPfwSnepJcfPUJzszA8gXroPPlTnrM4GHRcvpgCK6HWvXavwtWF8ydXcRws36ntCGt/iEzxZR84jX7e/Fa3xrEJpBmZwb3rfN4XnauhFoi1V66kk+ufEJJ+GdJAgYBR87xcxLWJj7tsyU=
Received: by 10.142.48.14 with SMTP id v14mr2529689wfv.14.1208317586586;
        Tue, 15 Apr 2008 20:46:26 -0700 (PDT)
Received: by 10.142.179.14 with HTTP; Tue, 15 Apr 2008 20:46:26 -0700 (PDT)
In-Reply-To: <m3abjushvs.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79652>

On Tue, Apr 15, 2008 at 9:33 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>  > Brian Gernhardt <benji@silverinsanity.com> writes:
>  >
>  >> On Apr 15, 2008, at 1:31 PM, Russ Dill wrote:
>  >>
>  >>> The problem is that a branch is just a floating name for a line of
>  >>> development. Its not really a "thing" in the repository like a tag or
>  >>> a commit. You'd need to make some sort of special tag that describes
>  >>> the branch or somesuch.
>  >>
>  >> No special tags needed.  A simple file that I'll call .git/info/
>  >> ref_names could be a set of lines that have "<ref>\t<description>",
>  >> like the following:
>  >>
>  >> refs/heads/master    Collection point for all my work
>  >> refs/heads/ref_names Add descriptions for branches
>  >> refs/heads/segfault  Trying to fix bug #12345
>  [...]
>
> >> Now if you want to propagate these descriptions when you push and
>  >> pull, things get a lot more complicated.
>  >
>  > Not complicated at all.  Put that description in-tree in a known location
>  > (say, "help-branch") in-tree and your propagation problem is solved.
>  >
>  > And have a scriptlet in $HOME/bin/git-help-branch to grep from that file.
>
>  Please, let's don't repeat Mercurial mistake of placing unversioned
>  information (such as branch names in case of Mercurial, or branches
>  descriptions in this case) in-tree, i.e. version it.  Think of what
>  would happen if you reset to the state (or checkout to some branch
>  with the state) which is before some branch was created, or before
>  some branch got description.  Mercurial deals with this using
>  "special" not lika in-tree treatment of such a file... I don't think
>  it is a good idea.
>
>  I think it wouldb be better to put branches descriptions somewhere
>  outside object repository, be it .git/info/ref_names of .git/config.

I agree that outside the object repository would be better.
Propogating branch descriptions doesn't seem all that useful.  I
wouldn't usually expect to want a branch for the same purpose as the
upstream repository and it would seem weird to get a default
description of it coming along with the branch.  Just like I give my
branches my own name, I would expect to have to give them my own
description.

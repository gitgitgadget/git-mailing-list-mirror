From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: command prompt script for current branch
Date: Wed, 6 Feb 2008 23:56:41 +0100
Message-ID: <200802062356.41548.jnareb@gmail.com>
References: <9b3e2dc20802061152q63bc61acuaecf3f33d4df8b19@mail.gmail.com> <m3r6fp4wrt.fsf@localhost.localdomain> <9b3e2dc20802061413v5dbe349axe43a4af263e39878@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Stephen Sinclair" <radarsat1@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 23:57:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMtCv-0008GJ-TV
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 23:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758667AbYBFW45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 17:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758393AbYBFW45
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 17:56:57 -0500
Received: from ik-out-1112.google.com ([66.249.90.176]:22223 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759953AbYBFW4x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 17:56:53 -0500
Received: by ik-out-1112.google.com with SMTP id c28so509907ika.5
        for <git@vger.kernel.org>; Wed, 06 Feb 2008 14:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=fcI6O4vPwUdVEIVRRzmCgWqGpICODJRQJX6aQKhc3G4=;
        b=ItrFRVgwn7zgsLwUx0bG5RdizAjvHvHawLZtJ60n15j7k0CeRPXPHRNYEUqCG9PMKEa9zSBv70V7f1RQQ1MrzDDBRhaxEXFoH2xXENOfKbx0HH0kCxJugZ2v0Z8fl0LE1duq/gXUJi2kBzzMbNmhjDoDojD5zUgCWU/DjQN6WlI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=eVLGZQX07S4hC8QTpprDA66GeBHpX6VXid+2ROFUmgVf4GKtNTV5Y99+1fxghVklWZRdfQu0BPSch+LmG4qupOseTi/H78USYtZtU8ZLXMBHHC9LUHjh8YukmpbzpxBcHx61TTuLV+FTV5c7eF3hoUnmxSQxP0SaYn3rqNHI0Iw=
Received: by 10.78.179.12 with SMTP id b12mr18913917huf.34.1202338611664;
        Wed, 06 Feb 2008 14:56:51 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.239.145])
        by mx.google.com with ESMTPS id z34sm8252588ikz.8.2008.02.06.14.56.49
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Feb 2008 14:56:50 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <9b3e2dc20802061413v5dbe349axe43a4af263e39878@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72871>

On Wed, 6 Feb 2008, Stephen Sinclair wrote:

Please provide attribution (who write what) when quoting, like
below:

> Jakub Narebski wrote:
>> "Stephen Sinclair" <radarsat1@gmail.com> writes:

>>> Attached is a script I quickly wrote up yesterday.  Sometimes I've
>>> found I started working only to realize I was on the wrong branch.
>>> (Now that I'm accustomed to working with git, I make many small
>>> branches, so it happens.)
>>
>> First, it is much better to put such script inline, in the body of
>> your email.  This makes commenting about script body much easier.
>> And if you have to attach it, for example because your mailer mangles
>> whitespace (which is not the case here), make sure that attachement
>> uses "text/plain", and if possible "inline" disposition, to better
>> _view_ the code without need to save it to temporary file.
>>
>> I would take an exeption and comment on your code, even though you
>> make it hard to do so.
> 
> Thank you.  Since there's already a solution for this in contrib,
> (didn't see it, sorry), I'll just take your recommendations on coding
> style for any future stuff I do.

First, the code in contrib doesn't do all your code did. It doesn't
show if workarea is "dirty" (although I'm not sure if this is very
useful), nor does it show number of commits since or to mainline
(origin) version, although with working on (with) feature/topic
branches which does not have corresponding remote tracking branch
it seems not useful.

On the other hand code in _git_ps1 (taken from one of the "git prompt"
posts floating on git mailing list, and available in archives, together
with /usr/share/stgit/contrib/stgbashprompt.sh from StGit, Quilt-like
patch management layer on top of Git) shows also name of repository
and path in repository, and also if the branch is managed by StGit.


Second, I think you have learned something. Both on rules regarding
discussion, netiquette and sending contributions on this mailing list,
and about how to write scripts for/around git.  (At least I hope so).

-- 
Jakub Narebski
Poland

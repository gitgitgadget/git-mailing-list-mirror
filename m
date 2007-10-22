From: "Jakub Narebski" <jnareb@gmail.com>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished summary continued
Date: Tue, 23 Oct 2007 01:35:41 +0200
Message-ID: <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>
	 <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com>
	 <Pine.LNX.4.64.0710210031130.25221@racer.site>
	 <471AFD07.4040606@op5.se>
	 <Pine.LNX.4.64.0710212308540.25221@racer.site>
	 <471C586A.9030900@op5.se>
	 <Pine.LNX.4.64.0710221156540.25221@racer.site>
	 <471C9B13.9080603@op5.se>
	 <Pine.LNX.4.64.0710221445170.25221@racer.site>
	 <471CB443.9070606@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Steffen Prohaska" <prohaska@zib.de>,
	"Federico Mena Quintero" <federico@novell.com>, git@vger.kernel.org
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Oct 23 01:36:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik6ok-0004Zu-KX
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 01:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbXJVXfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 19:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbXJVXfo
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 19:35:44 -0400
Received: from nz-out-0506.google.com ([64.233.162.234]:10261 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850AbXJVXfn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 19:35:43 -0400
Received: by nz-out-0506.google.com with SMTP id s18so591705nze
        for <git@vger.kernel.org>; Mon, 22 Oct 2007 16:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Lix2YXEVrl5qAMiGznlI7HWYVRvK00NtOpDKse0uoy0=;
        b=Z6OGFBWiyatrdO2d78HRiev5Sa3yCF5uIq0VU1+sIUQgZfV3tRQI/asgay1NOymubmeu5+OL5myOV5PXgp082JbqJOsQB+JRVe5nle3ge3kPlvEG932PWmfeVona3CUzvZJfGgdeAs39seDCimr5AixmSvgqMihEDpMz6PNfU6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WzXBEdE7t3h9kB+kgHnmhN+1WQ9dGm1pp4fK5C8pKUh+8H4Vr0nIog7n5J+EirngLG+Xqg2R4xc/9OT7LlVEQxBcwkOzdMfYuqFh6tTQ+TOsblXXxIYyGwRdZTcXlAAofWQe1f0SXHzdNNw6vYf7F/oHmHMfflmcwm3YytlZuH4=
Received: by 10.114.160.1 with SMTP id i1mr6120603wae.1193096141917;
        Mon, 22 Oct 2007 16:35:41 -0700 (PDT)
Received: by 10.114.160.12 with HTTP; Mon, 22 Oct 2007 16:35:41 -0700 (PDT)
In-Reply-To: <471CB443.9070606@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62059>

On 10/22/07, Andreas Ericsson <ae@op5.se> wrote:
> Johannes Schindelin wrote:
>> On Mon, 22 Oct 2007, Andreas Ericsson wrote:
>>
>>> If I were to suggest any improvements, it'd be to change the semantics of
>>> git-pull to always update the local branches set up to be merged with the
>>> remote tracking branches when they, prior to fetching, pointed to the same
>>> commit, such that when
>>>
>>> $ git show-ref master
>>> d4027a816dd0b416dc8c7b37e2c260e6905f11b6 refs/heads/master
>>> d4027a816dd0b416dc8c7b37e2c260e6905f11b6 refs/remotes/origin/master
>>>
>>> refs/heads/master gets set to refs/remotes/origin/master post-fetch.
>>
>> In general, this should fail.  Because you are expected to have local
>> changes in the local branches.
>
>
> BS argument. Git knows when I haven't got any changes on my local
> branches, and it can be fairly safely assumed that when I feel like
> making any, I'd like to make them off as fresh a tip as possible unless
> I explicitly tell git otherwise.
[cut]

It would be I think possible to make git behave as you want, although I'd rather
(at least at first) have behaviour described above turned on by some option
or config variable. I guess that it would be not that hard to make script to do
what you ant (and probably it would be best if you tried your idea that way).

There are the following caveats.
1. For each local branch that is to be updated on pull, this branch
must be marked as tracking some branch of some repository. This has to
be explicitely done; for example by creating those branches using
--track option.
2. Git can do a merge with conflicts _only_ if that branch is checked
out. So for all local branches which you want to get updated using
"git pull --update-all <repo>" (or something like that), the merge
with remote branch should be either fast-forward, trivial merge, or
merge without conflicts. "git pull --update-all <repo>" would return
then list of updated branches and list of branches which cannot be
updated.

So... are you going to try to implement that?
-- 
Jakub Narebski

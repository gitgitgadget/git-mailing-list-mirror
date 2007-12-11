From: "Daniel Berlin" <dberlin@dberlin.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 16:24:17 -0500
Message-ID: <4aca3dc20712111324n51411550r6a35fbf45b4a3b49@mail.gmail.com>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
	 <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org>
	 <4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com>
	 <alpine.LFD.0.9999.0712111122400.25032@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 22:25:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Cas-0004W6-AT
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 22:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754101AbXLKVYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 16:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754049AbXLKVYV
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 16:24:21 -0500
Received: from wr-out-0506.google.com ([64.233.184.229]:20813 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810AbXLKVYU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 16:24:20 -0500
Received: by wr-out-0506.google.com with SMTP id c49so1898526wra
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 13:24:19 -0800 (PST)
Received: by 10.142.237.20 with SMTP id k20mr3958125wfh.1197408257847;
        Tue, 11 Dec 2007 13:24:17 -0800 (PST)
Received: by 10.142.217.1 with HTTP; Tue, 11 Dec 2007 13:24:17 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0712111122400.25032@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67948>

On 12/11/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> It's not entirely surprising that we see multiple issues with the gcc
> repo, simply because it's not the kind of repo that people have ever
> really worked on. So I don't think it's necessarily related at all, except
> in the sense of it being a different load and showing issues.
>

I'm not surprised at all.
We had a number of issues with SVN that needed to be resolved.
I'm basically trying to get issues worked (both on git and mercurial)
out to the point where it is fair for our users to try their branch
and trunk workflows with git and mercurial,  and see which they like
more.
:)

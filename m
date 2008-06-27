From: "Robert Anderson" <rwa000@gmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 10:01:14 -0700
Message-ID: <9af502e50806271001j17a6ea8j4626d23e64a80c7f@mail.gmail.com>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
	 <4864A652.6070607@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jun 27 19:02:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCHKv-0002m0-HA
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 19:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbYF0RBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 13:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752541AbYF0RBR
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 13:01:17 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:30098 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbYF0RBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 13:01:16 -0400
Received: by fk-out-0910.google.com with SMTP id 18so519008fkq.5
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 10:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=1av2/22Hova0QIlPXGMTUtX6U2CV8fmD+pEIBx9G8cg=;
        b=GzAJaoUuQPxPXISqtR+RFaWoAx0CTQZxdiXGsYz2CfFnR0UQaCHVOSIGXBht6X2iA5
         bCI/QFJGInPCEh3QGaMdqhD2Kh3v/NoghbA21wTLGMwF/jSyvDFcrRqwZ3/JwMLrqdOm
         nXFMeASl93/9NBSLKSdudmtxQWtbsK4bAV5qU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=vaQmh2DgPMeWvjTBB4E7rwr8c5X1jwnNXdbpbwy/fszuYvRxd6E5nu8fkjiunB1/1q
         DCSOJGs9ZyBB4sAqF6ZcejMo6K+gZBXHIogdPycJbtU6Ua0RTOBq3XKwSfzHua1twGWI
         Y7qOXHR8TocWSIP5IEc3fYcMs5TqB1NMMAp0g=
Received: by 10.82.184.2 with SMTP id h2mr69668buf.11.1214586074677;
        Fri, 27 Jun 2008 10:01:14 -0700 (PDT)
Received: by 10.82.178.10 with HTTP; Fri, 27 Jun 2008 10:01:14 -0700 (PDT)
In-Reply-To: <4864A652.6070607@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86597>

On Fri, Jun 27, 2008 at 1:35 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Robert Anderson schrieb:
>> Seems to me the concept of the "index" is a half-baked version of what
>> I really want, which is the ability to factor a working tree's changes
>> into its constituent parts in preparation for committing them.  The
>> index provides some very nice facilities to factor out changes in a
>> working tree into a "staging area", but the fundamental flaw of this
>> in my view is that this "staging area" is not instantiated as a tree,
>> so it cannot be compiled and/or tested before committing.
>
> I do this all the time. After I have made $N commits out of my worktree, I
> usually
>
>        $ git rebase -i HEAD~$N
>
> and turn all 'pick's into 'edit's and 'squash's. Then I can compile and
> test each commit, perhaps add some fixups, in isolation.
>
> -- Hannes

Hannes,

I do not have N commits.  I have a modified working tree from which I
would like to create N commits.  I would like to compile and test an
instantiation of each of those to-be-committed states before
committing them.

Thanks,
Bob

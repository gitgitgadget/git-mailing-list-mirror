From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: git fetch: where are the downloaded objects stored?
Date: Mon, 3 Mar 2008 16:40:11 +0100
Message-ID: <4d8e3fd30803030740i18ca8db1y681b4f10797f8c83@mail.gmail.com>
References: <4d8e3fd30803030440s7239c83cj8bf69401dd76bad@mail.gmail.com>
	 <vpqskz82bm3.fsf@bauges.imag.fr>
	 <4d8e3fd30803030633nf6266d5qab0df4ba4c539e0b@mail.gmail.com>
	 <vpq63w325px.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Matthieu Moy" <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Mar 03 16:41:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWCmf-00077K-OF
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 16:40:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368AbYCCPkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 10:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754641AbYCCPkT
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 10:40:19 -0500
Received: from el-out-1112.google.com ([209.85.162.177]:64268 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754102AbYCCPkR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 10:40:17 -0500
Received: by el-out-1112.google.com with SMTP id v27so106521ele.17
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 07:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=9s2Z0Hh6sH1Iwuo/HImrQ3ffNtSbCKi1p6iTGGcnDRk=;
        b=OwxGSHGN5YrnBYUauMGjWXaf2d/DkwJNKIWhzhuvulgYXPDKil3kcdgGK8MCFk5IjDtqhy41usUSjRNlT54cRXxedgT/xTlikRcLvG4aJJtKIFNtXxyehBjM3vieRDuhNVNa4ouLrY++uXINu7HOP/pGtvH4X06X3reoLvb5Z9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GyVV6JmY+gRhXRLuTA/hn8f615T5tKccNKXcepsEWVc2rsDVh19V/Nf1ZnjeSTjnMouAZfL1m+QTOYhoefd405f/OBkb5uuqXs3lvR1Yzwn1T6jUSFSXYJ1YHjTs9iJzXgCcAMGJopSRO7mleQM+2DluEocCwODTu8AazWUIdS0=
Received: by 10.114.176.1 with SMTP id y1mr102020wae.86.1204558811252;
        Mon, 03 Mar 2008 07:40:11 -0800 (PST)
Received: by 10.114.151.7 with HTTP; Mon, 3 Mar 2008 07:40:11 -0800 (PST)
In-Reply-To: <vpq63w325px.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75936>

On Mon, Mar 3, 2008 at 4:21 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:
>
> > "A merge is always between the current HEAD and one or more remote
> > branch heads"
>
> I think this is just wrong. Would this be correct?

Sounds better than the original document,
however I'm still having some problems in visualizing what happens
when I type "git fetch" followed by "git merge".

> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index 0c9ad7f..e46dea1 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -68,7 +68,7 @@ HOW MERGE WORKS
>  ---------------
>
>  A merge is always between the current `HEAD` and one or more
> -remote branch heads, and the index file must exactly match the
> +branch heads (remote or local), and the index file must exactly match the

When I run the command git fetch the objects are downloaded from the remote
branch and locally stored in the objects database.
Both the working tree and index are not touched by this operation.
Is this correct?

How can I look to what I just downloaded?
Should I simply do a git diff?

Backing to the documentation, your proposal is:
 A merge is always between the current `HEAD` and one or more
 branch heads (remote or local), and the index file must exactly match the

In case of a git fetch + git merge the merge is between the current
`HEAD` and the
downloaded objects. Is correct to define it `branch heads`?

Maybe (read it: for sure) I'm a bit confused by the git terminology
but I really feel that
other newbies are not easily understanding this process.

Thanks.

ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/

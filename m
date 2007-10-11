From: "Patrick Doyle" <wpdster@gmail.com>
Subject: Re: Split a subversion repo into several git repos
Date: Thu, 11 Oct 2007 09:24:59 -0400
Message-ID: <e2a1d0aa0710110624x2b50cfafo9bfdc176ba9063ce@mail.gmail.com>
References: <op.tz09zaizjwclfx@ichi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eivind LM" <eivliste@online.no>
X-From: git-owner@vger.kernel.org Thu Oct 11 15:25:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ify2Q-0006O6-1C
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 15:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325AbXJKNZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 09:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753701AbXJKNZE
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 09:25:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:11732 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbXJKNZC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 09:25:02 -0400
Received: by nf-out-0910.google.com with SMTP id g13so466114nfb
        for <git@vger.kernel.org>; Thu, 11 Oct 2007 06:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=RyVjwVti0QjAubjK7u66tnVfbZ+AssBrrOF8cd7/pQU=;
        b=Z1I8pRd4AlL6eStRdV0TP44nwk7gDEvyRspzoCB4dpuCuf6G3IFLgg+n2NQHRIO1nOE7kUuAMxSbsyAbeQvaGZUeDetwfpRf/kfLwauqjQ0mBxcFVntvgrZYVmPhHKtKteAaYCYvjAOwj/4lTZsuhySr041UoEAzGUcXHu8kc1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S98Q6f6sgRe/+B3G2pFHNA1ahT0MpNtCgYB/KLQdoTetQLCd4U2uVb/yyayJBM8xDO7gOrUod+qUcRfK7Wkj8CVbUfXNu1EoqqWVBfkwrOKcIItfm1YkMRSpd4QG2aOvU5setM0PioPgaBAK386yCzKMxf0hTiiW+Af+fS0ad8Y=
Received: by 10.78.140.17 with SMTP id n17mr1419723hud.1192109099377;
        Thu, 11 Oct 2007 06:24:59 -0700 (PDT)
Received: by 10.78.193.15 with HTTP; Thu, 11 Oct 2007 06:24:59 -0700 (PDT)
In-Reply-To: <op.tz09zaizjwclfx@ichi>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60596>

If you look through the Subversion FAQ or the book (I forget where
I've seen it -- but I know I've seen it), you can export/filter out a
tree from a subversion repository and load it into a new repository.
Then you can import from that new repository.

This presumes you have direct access to the subversion repository and
can run commands like svnadmin --dump.

--wpd


On 10/11/07, Eivind LM <eivliste@online.no> wrote:
> Hi,
> I would like to convert a subversion repository to Git. The subversion
> repository used to track development of several projects (only slightly
> related), and I would like to divide the repository into several smaller
> git repositories.
>
> For example, I want to convert one subversion repository which contains
> the folders:
> trunk/projectA
> trunk/projectB
>
> into two git repositories:
> projectA.git
> projectB.git
>
> As far as I have understood, the way to do this is to
> 1) Convert the entire subversion repository to git with git-svn.
> 2) Make two copies of the whole new git-repository (projectA.git and
> projectB.git).
> 3) Use git-rm to remove projectB from projectA.git, and projectA from
> projectB.git.
>
> This works fine, but both git-repositories now carries the history for
> both projects. If possible, I would like to "clean" the history in the
> repositories, so that I don't see history information for projectA when I
> am browsing logs in projectB.git. Has anyone been in the same situation?
> Do you have suggestions on how it can be solved?
>
> Any help will be greatly appreciated.
>
> Thanks,
> Eivind
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

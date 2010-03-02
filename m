From: Chris Packham <judge.packham@gmail.com>
Subject: Re: split up a repository
Date: Mon, 1 Mar 2010 16:36:07 -0800
Message-ID: <a038bef51003011636n6dda8296k655b9d367cee9e91@mail.gmail.com>
References: <20100302011226.76fda85d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Kovacs, Levente" <leventelist@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 02 01:36:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmG5w-0001yx-3u
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 01:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672Ab0CBAgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 19:36:11 -0500
Received: from mail-pz0-f179.google.com ([209.85.222.179]:62120 "EHLO
	mail-pz0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab0CBAgK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 19:36:10 -0500
Received: by pzk9 with SMTP id 9so2383817pzk.25
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 16:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=tCpmDmGPAHClJs+AfPPz7G8OaVrskeariEk4Uxa/dN0=;
        b=tegJXEgnW5GWMHy+IU1mRUlDnzLrRsuejcPLj3pCzQVOkDx96e71uPfsdvV8oaVP9f
         H2pVwacV60afRmXiUxCcE4SIe7c9zc1sEX2sOlXMUWl5GDdN5Ebvk3gNHvrhtr8GKWL+
         KUATWMLYfqJEQTtkC8l1bKH0o57LEMFQhMl24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=EhHp53qChsp1rVdC41+wEZiyG7fJJL6nL6OIXqN1EfIR1YQhF4IsR8bfYTM3SjgRIl
         2YciqdqBQAGLX88KQwRnFULRCyGHsQbGxbxmh1YQnSphX5552OCLVxWudso5RtQDz9oe
         i1ZnmKFqakyG3wxAz0asJ16OVM5Gtc/7MoF8o=
Received: by 10.114.162.40 with SMTP id k40mr3012842wae.99.1267490167473; Mon, 
	01 Mar 2010 16:36:07 -0800 (PST)
In-Reply-To: <20100302011226.76fda85d@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141370>

Hi,

On Mon, Mar 1, 2010 at 4:12 PM, Kovacs, Levente <leventelist@gmail.com> wrote:
> Hi all,
>
>
> Ok, I *WAS* an SVN user, so forgive my ignorance. I have successfully
> migrated from SVN to git. However, I had only one repository under my
> SVN server, which is not a good approach with git.
>
> http://logonex.eu/git/?p=svn.git;a=summary
>
> Now I have one git repository, which I'd like to split up to several others. Does it possible with git? If it is, how?
>
> How can I split up a single repo to several others? It would be nice to
> keep the history.
>
> Thank you for your help in advance.
>
> Levente
> --

'git filter-branch' should do what you need. Have a read of this [1]
recent discussion and the docs for filter-branch [2].

[1] http://thread.gmane.org/gmane.comp.version-control.git/138382
[2] http://www.kernel.org/pub/software/scm/git/docs/v1.7.0.1/git-filter-branch.html

From: "David Ho" <davidkwho@gmail.com>
Subject: Re: Moving a file back to an earlier revision.
Date: Fri, 31 Mar 2006 16:32:16 -0500
Message-ID: <4dd15d180603311332p60fa1867nc303bd92d515b4e0@mail.gmail.com>
References: <4dd15d180603311313t7781f2ebk616276e9134f6472@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Mar 31 23:32:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPREB-0007gt-VI
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 23:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWCaVcR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Mar 2006 16:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWCaVcR
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Mar 2006 16:32:17 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:46158 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751409AbWCaVcQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Mar 2006 16:32:16 -0500
Received: by zproxy.gmail.com with SMTP id k1so976326nzf
        for <git@vger.kernel.org>; Fri, 31 Mar 2006 13:32:16 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rZGQourJ6Jbad7BuHEdIgWfZRiCRMq/qhV3mKAPij6v7xEM0tjfcVVeMe9xf/9R6QvTDI2pua3fyHwkNCqLgAKCFShAj+KfE6J0iSHQKPZ459JuecD79oXjOuSuKz2vFmLNA+yV5Ha19U4vqhqZm7vW+o31Jpc0Vz0dKh18KjJo=
Received: by 10.65.183.7 with SMTP id k7mr460421qbp;
        Fri, 31 Mar 2006 13:32:16 -0800 (PST)
Received: by 10.65.22.11 with HTTP; Fri, 31 Mar 2006 13:32:16 -0800 (PST)
To: git@vger.kernel.org
In-Reply-To: <4dd15d180603311313t7781f2ebk616276e9134f6472@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18235>

Sorry I might already have found it.

File revisions

+----+----+
1    2    3

git diff commit(3)..commit(1) filename | git-apply

David

On 3/31/06, David Ho <davidkwho@gmail.com> wrote:
> Hi,
>
> Another user question.  Other may actually have similar needs.
>
> I am working on a board port on a separate branch.  The branch has
> accumulated several revision of changes to a driver I worked on.  Now,
> someone has come along with a better fix so I want to help test his
> patch.  To do that I have to revert my changes to that driver (several
> revisions back) before I can apply his patch.
>
> What would be a convenient way to do that with git?
>
> TIA, David
>

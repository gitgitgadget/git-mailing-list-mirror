From: "Stephen Sinclair" <radarsat1@gmail.com>
Subject: Re: Visual SourceSafe -> Git?
Date: Tue, 27 May 2008 08:40:47 -0500
Message-ID: <9b3e2dc20805270640t160e7865of9b112fc0f297c4f@mail.gmail.com>
References: <63c5d3820805270620t1fefdf95q6407bd053a2daa88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Chris Hoffman" <chris.c.hoffman@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 15:42:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0zQp-0003fz-LN
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 15:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757550AbYE0Nks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 09:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757518AbYE0Nks
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 09:40:48 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:64643 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756798AbYE0Nkr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 09:40:47 -0400
Received: by rv-out-0506.google.com with SMTP id l9so2946633rvb.1
        for <git@vger.kernel.org>; Tue, 27 May 2008 06:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=kmcMigvU+RrMYkU8CPpwBgnYBr2qyD2E68pwAezftEE=;
        b=gxg2Xh8u4KPXo4/disU7+MA7GJ851qhIxAtX4txCPxEnYT+HYbKrAmcp4VOE3XpOdpX2BGv5sgRl4G2VqDjO9oLNBzfH7RKkfZe2PwkxunaidzZZ/3+tEnRphykX4evFvu1Oa+/zgn9mEbp/Ozm+fouIqF+P+0/RQ//8DdgBlKk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z5RH6M5U5dojcl9T9LAcCzDBtvoRLx++2WOhKCXg40lYe9o1X3W4Ct0t6SB8BjeYU1G8IIybP9Po8i06cp/JtdPqu+DtcfXK8Yo4NKvBe0XJdOBNwW1mif/nnO+Gxs0ZdhfJKeJf/8ZkV4vO4p/qffcNxsVB2eiTh4O4uk18YrA=
Received: by 10.140.174.18 with SMTP id w18mr544795rve.227.1211895647414;
        Tue, 27 May 2008 06:40:47 -0700 (PDT)
Received: by 10.141.66.3 with HTTP; Tue, 27 May 2008 06:40:47 -0700 (PDT)
In-Reply-To: <63c5d3820805270620t1fefdf95q6407bd053a2daa88@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83015>

Hi Chris,

I've done this using vss2svn:
http://www.pumacode.org/projects/vss2svn/wiki/RunningTheMigration
Then imported the svn using git-svn.

It works great, at least for my simple use case.
Of course, the actually VSS history is pretty useless since no one at
my company knows how to use version control (i.e., no comments) but at
least it's there if I need it. :)
I have no idea if this handles branching and such.

Steve


On Tue, May 27, 2008 at 8:20 AM, Chris Hoffman
<chris.c.hoffman@gmail.com> wrote:
> Hello,
>
> Is there a tutorial/script out there that would allow one to convert
> an old-and-busted VSS repo to Git?  I was thinking about going the
> subversion route, but I still have nightmares of the days when I was
> having to do complex merges.
>
> Thanks!
>
> -Chris
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

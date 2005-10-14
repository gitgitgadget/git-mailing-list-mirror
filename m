From: David Ho <davidkwho@gmail.com>
Subject: Re: git-whatchanged does not show merge result?
Date: Fri, 14 Oct 2005 13:31:23 -0400
Message-ID: <4dd15d180510141031n531b9e0enc8e7d668b1e61b83@mail.gmail.com>
References: <4dd15d180510140929x2c69f61ag19a1409cfd993e7b@mail.gmail.com>
	 <4dd15d180510140933j7a730c49hb9cdaa98ea0a5b07@mail.gmail.com>
	 <Pine.LNX.4.64.0510141007290.23590@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 14 19:34:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQTP2-0002m6-Hp
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 19:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbVJNRbZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Oct 2005 13:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVJNRbZ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Oct 2005 13:31:25 -0400
Received: from qproxy.gmail.com ([72.14.204.206]:17551 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750811AbVJNRbZ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2005 13:31:25 -0400
Received: by qproxy.gmail.com with SMTP id z1so376838qbc
        for <git@vger.kernel.org>; Fri, 14 Oct 2005 10:31:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WbvOFEGo6/IzstRjzcTGMALbmdFGbQWUeLMW2GWmBMGV1w1KBkQG7baMnVSRpaUjLt3Nf/wgDhOxf1DHh1aM0X958mFGtjUKmi/1NefQHDwG90NPmuHmUUMQWjcL5ePfTfeI1s2D4TtVoEgeBBcflY9DiB6prqkuk6Iq9Txa/js=
Received: by 10.64.181.15 with SMTP id d15mr965460qbf;
        Fri, 14 Oct 2005 10:31:23 -0700 (PDT)
Received: by 10.65.35.5 with HTTP; Fri, 14 Oct 2005 10:31:23 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510141007290.23590@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10117>

I was a little worried when I did git-whatchanged on a file and there
was a hole in the history where the merge is.  This reassured me that
all changes to the file is accessible (I'm sure they are all stored
safely in the repo =).

Thanks, David

On 10/14/05, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Fri, 14 Oct 2005, David Ho wrote:
> >
> > Maybe someone can clear up a confusion I have with git-whatchanged.
> > I created a new repo with just one file hello, split out a new branch "mybranch.
> > When I merged back the changes from mybranch, git-whatchanged -p did
> > not should the diff of the merge.
>
> You can use the "-m" flag to show merges. HOWEVER, it's not very useful
> in general, although it _is_ useful on a file-by-file basis.
>
> What "-m" does is that it will show diffs against each parent, which is
> _sometimes_ what you want. Try it.
>
>                 Linus
>

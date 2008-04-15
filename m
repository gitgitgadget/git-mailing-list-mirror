From: "Stephen Sinclair" <radarsat1@gmail.com>
Subject: Re: branch description
Date: Tue, 15 Apr 2008 16:53:47 -0400
Message-ID: <9b3e2dc20804151353p2622ab19i2a04f5da9a6417ca@mail.gmail.com>
References: <9b3e2dc20804150951scf8b3c7x26f3a56eab1f9840@mail.gmail.com>
	 <f9d2a5e10804151031o1d09c1f9od0ad78dcf9b746c5@mail.gmail.com>
	 <C55CA6EB-D427-4CF5-923E-DE0071D2F870@silverinsanity.com>
	 <7vej97x78v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Brian Gernhardt" <benji@silverinsanity.com>,
	"Russ Dill" <russ.dill@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 22:56:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlsAk-0002Uo-9l
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 22:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755168AbYDOUxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 16:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753672AbYDOUxu
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 16:53:50 -0400
Received: from rv-out-0708.google.com ([209.85.198.249]:17732 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752897AbYDOUxt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 16:53:49 -0400
Received: by rv-out-0506.google.com with SMTP id k29so964557rvb.1
        for <git@vger.kernel.org>; Tue, 15 Apr 2008 13:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=1Dp9Iv+ZlIhD5UDDcKBYfshurMdvFSv4c3AWu+WFsMw=;
        b=dw1QW48awGB+7UtAqSRld+9EiQ/sA6VEXiNB/DQNMshqJUtDGFjvXSx6KFKTd8jdvT0jU2ZlSqxr6pZLyxHXmsIHFNDShoXVtGd7boX3+i+Ww+glfGK4+z77+U/cXhOp16Fv4XqP1rTNOsTNIBbf7KNh1b70urqUzBAU1FbTVVs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=whIxDqRIMw3y47/4xfzE+7TrEkBr8Dh2jN0RWdulJFR0XADlssAWqDqZhtqfeg9YfLhoShJFmlumDzNBI8v892kIoyNYmJTPGMjmNYZPzCgyMG9XSSH54bM0ZR+1ohNfse7fMtFYi++yJlu5fM2UeSikJTnSpfuh1ciDqyiyaZ0=
Received: by 10.140.248.17 with SMTP id v17mr4615234rvh.9.1208292827047;
        Tue, 15 Apr 2008 13:53:47 -0700 (PDT)
Received: by 10.141.66.3 with HTTP; Tue, 15 Apr 2008 13:53:47 -0700 (PDT)
In-Reply-To: <7vej97x78v.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79627>

On Tue, Apr 15, 2008 at 3:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>  Not complicated at all.  Put that description in-tree in a known location
>  (say, "help-branch") in-tree and your propagation problem is solved.
>
>  And have a scriptlet in $HOME/bin/git-help-branch to grep from that file.

Hm, I wasn't sure if an in-tree solution would be appropriate.
It's possible, but I didn't really want this branch description to be
something I have to deal with when merging..
Ideally though this information _should_ be propagated through a
clone, so something in-tree might make sense.

When I posted I thought perhaps there was already a way to do this
that I hadn't encountered.
Perhaps there could be an in-tree file .gitbranch that is simply a
name:description pair, "git-branch --info" (or whatever) could be made
to know how to parse that file if it exists.

However I was hoping that the branch description could be made when
creating the branch, instead of having to associate it with an actual
commit.

I don't know, I'll give it some thought and try to come up with a more
concrete proposal.


Steve

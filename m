From: "Vegard Nossum" <vegard.nossum@gmail.com>
Subject: Re: git-merge --no-commit commits
Date: Sun, 2 Dec 2007 18:18:22 +0100
Message-ID: <19f34abd0712020918w1640389kb0ca006b2051a678@mail.gmail.com>
References: <19f34abd0712020857m757c57cfr358a81e47f38fac8@mail.gmail.com>
	 <m3bq99vx7t.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 18:18:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IysSv-0003Cy-B0
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 18:18:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753056AbXLBRSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 12:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753788AbXLBRSX
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 12:18:23 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:61326 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957AbXLBRSX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 12:18:23 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2408372rvb
        for <git@vger.kernel.org>; Sun, 02 Dec 2007 09:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=CuEvhhNy1sGnb8FL2a9GkyseBQumDTS/O/16ZEMg+as=;
        b=SUz3KuCdjjfBOkgQAVnMjLxg6huMWVaw722XxvG2B8bYw+1B5LtEyBS++nzHt5dUxZJEMtQCNd/ssj/+/8kayEMLgwoCOPf8ukcCOdEox9nfnX/fIfd1GrOTt1uTTVjklr2IRIF1Q9wSookztCzAZN4o08a2B3cXDXtImdSieQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T9HUTfUGHr3ltdkWcmR8PDf4llOAPGxNuJXVnbRJBqWgWjzefDiVAuCANy1rZPkF+IeHF/SSlTpX75Y7hR5wnL20yXadTeJdEWsho399ysRBohFpYcHqq7gilvdm0Y95iIwTuN6V4xDO6IKqsqz8E78Z3JPsx9px51OCW+uj0kQ=
Received: by 10.141.198.8 with SMTP id a8mr235916rvq.1196615902447;
        Sun, 02 Dec 2007 09:18:22 -0800 (PST)
Received: by 10.141.170.18 with HTTP; Sun, 2 Dec 2007 09:18:22 -0800 (PST)
In-Reply-To: <m3bq99vx7t.fsf@roke.D-201>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66798>

On Dec 2, 2007 6:10 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> "Vegard Nossum" <vegard.nossum@gmail.com> writes:
>
> > I am using git 1.5.3.4 and just did the following (v1 and v2 are
> > branches; v1 is a parent of v2):
> >
> > git checkout v1
> > git merge --no-commit v2
> >
> > It simply fast-forwarded AND committed even though I explicitly told
> > it not to. What gives?
>
> The --no-commit option doesn't prevent fast-forward because
> fast-forward doesn't really _create_ a commit (and -no-commit is
> really about commit creation). It just advanced ref (branch head).
>
> You probably wanted to use
>
>   $ git merge --no-commit --no-ff v2
>

Yes. Thanks. Isn't that counter-intuitive, though? The manpage says
that it lets you review the changes first. I assumed this would
include fast-forwarding as well. There is no --no-ff in my git-merge
manpage. Maybe I need a newer version?

> HTH
> --
> Jakub Narebski
> ShadeHawk on #git
> Poland
>

Vegard

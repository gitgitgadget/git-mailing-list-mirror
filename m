From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: Recording merges after repo conversion
Date: Tue, 30 Oct 2007 22:46:00 +0100
Message-ID: <8c5c35580710301446y119f8199u8dce4b500316376a@mail.gmail.com>
References: <Pine.LNX.4.64.0710090807060.26773@ds9.cixit.se>
	 <13D1D3DD-9652-4097-8364-DEF4F26540D3@lrde.epita.fr>
	 <Pine.LNX.4.62.0710301433150.652@perkele.intern.softwolves.pp.se>
	 <8c5c35580710300729t4a7b375dud01253d9b4ef7196@mail.gmail.com>
	 <Pine.LNX.4.62.0710302204590.6976@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Benoit SIGOURE" <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: "Peter Karlsson" <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Oct 30 22:46:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imyuf-000348-8p
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 22:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882AbXJ3VqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 17:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753875AbXJ3VqE
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 17:46:04 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:20236 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716AbXJ3VqB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 17:46:01 -0400
Received: by rv-out-0910.google.com with SMTP id k20so2000994rvb
        for <git@vger.kernel.org>; Tue, 30 Oct 2007 14:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=hiQ8qsEUMh3NbH4eIqxL2MdDsc4LKx0o/yKDQlZ6gwo=;
        b=Ev7SrVbvFGotJaW8QaRtlOPUqZBkowjeHN4TbH4iL1SwEMMM5P33djysYhb4f8fLw1yWy7GciRVq1w7J+mmRSyD+Cipm7QiEUF3PZGRhdkmwWUU2wEutR8Uw2FfmkmLJCV7+9f7AVYSE1ZuYx75PKgDta7AQIzFiYdGYOM2J5iY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c8B6bwQz3wjq4sUxcOfDzTH1GXvk7gmXaej+dsQYCoJNYD8a+3jzu9VCBEJ67lq2+SAKCsYDaRp2OGXddqvIwK09ojExt6qYRN5BWdzd2Ki6au3MZdXxBn/9C7q4WjxFmHQAQF2tcAOBmUC7zWtEsEt2HavfdLdpPKITTH25n5g=
Received: by 10.114.197.1 with SMTP id u1mr8729336waf.1193780760982;
        Tue, 30 Oct 2007 14:46:00 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Tue, 30 Oct 2007 14:46:00 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0710302204590.6976@perkele.intern.softwolves.pp.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62761>

On Oct 30, 2007 10:06 PM, Peter Karlsson <peter@softwolves.pp.se> wrote:
> Lars Hjemli:
>
> > No, the grafts file is purely local.
>
> Hmm, any chance that will change in a future version?

Not likely

>
> > To achieve your goal, you'd have to 'git filter-branch' before
> > pushing/cloning. But beware: this _will_ rewrite your current branch(es).
>
> Ouch. I'll have to think about whether I want to do that, then...

Well, it isn't dangerous, but if someone has already cloned your repo
_and_ commited local changes they'll need to rebase their work onto
the new branch(es). Basically, you'll want to inform these people that
you're going to rewrite the branches.

-- 
larsh

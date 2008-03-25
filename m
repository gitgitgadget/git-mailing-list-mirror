From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 0/6] Two bugfixes
Date: Tue, 25 Mar 2008 15:27:03 +0000
Message-ID: <b0943d9e0803250827i4474fd8dx80b18b0b33542ec8@mail.gmail.com>
References: <20080320002604.13102.53757.stgit@yoghurt>
	 <b0943d9e0803200819k7300fd1fn8a21896c7ad2a1@mail.gmail.com>
	 <20080324181225.GC23337@diana.vm.bytemark.co.uk>
	 <b0943d9e0803250346h7405c37egc9ba170a6dcc06bf@mail.gmail.com>
	 <20080325110559.GA10333@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Erik Sandberg" <mandolaerik@gmail.com>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 16:29:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeB3y-0002I0-QF
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 16:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755388AbYCYP1G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2008 11:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755227AbYCYP1G
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 11:27:06 -0400
Received: from rn-out-0910.google.com ([64.233.170.189]:43777 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755350AbYCYP1F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Mar 2008 11:27:05 -0400
Received: by rn-out-0910.google.com with SMTP id v46so1874707rnb.15
        for <git@vger.kernel.org>; Tue, 25 Mar 2008 08:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=FiK+cO33Euc92RemvBKG+/8LeyVHoKaqyjeWwTA/EHQ=;
        b=ST5bYdT6lhyf3QU5B2YGXDLv4CI3PP9uLWq5DqhFe1S4jAjGUkCB3M3ylGbFRTaYpM7SMRpkno9SM6JMmk/tuddc1SodbnKN9ciKKtyYfjHhFXLnMKZwNjw8p3xSGxCtqouX6gxLQQE7fQlJNAs7K/8h8UJ+7odKvHpwVLgLYn4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gfZZcDgqkAxxPzXc3Z68hNYP8ZeI4/fYO2fch4VwVIjLCkZCmQBWFKDtK392rAEBCNKLPOot+dls76b8rLRdDqM+ZmLRDX2mjCEjIpLNJQNKmrADZQvc6HfIfjckD8MFG2QuBJO5cGoMCzRx33vsz9nfH0LcIY5vAt2HUq9Cwik=
Received: by 10.140.174.18 with SMTP id w18mr3408727rve.227.1206458823798;
        Tue, 25 Mar 2008 08:27:03 -0700 (PDT)
Received: by 10.141.175.11 with HTTP; Tue, 25 Mar 2008 08:27:03 -0700 (PDT)
In-Reply-To: <20080325110559.GA10333@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78191>

On 25/03/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2008-03-25 10:46:00 +0000, Catalin Marinas wrote:
>  > I personally prefer the current "refresh" way but maybe because I'=
m
>  > used to it. It would be useful to get other users' opinion on this
>  > UI change. Might not be a bad change since git does this already,
>  > quilt needs an explicit "add" (anyone knows about guilt?).
>
>
> I think my preference would be to to what git does: let just "stg
>  refresh" commit what's in the index, and have "stg refresh -a" or
>  something to automatically update the index first. (This should be
>  easy to do, btw -- refresh already has an --index flag.)
>
>  In general, I think it's a bad idea to do things differently from gi=
t
>  without a good reason.

We can give this a try on the master branch and see how it goes.

--=20
Catalin

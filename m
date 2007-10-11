From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 09/13] Clear up the semantics of Series.new_patch
Date: Thu, 11 Oct 2007 21:42:20 +0100
Message-ID: <b0943d9e0710111342j659a8e0byc2f022e59f6ea305@mail.gmail.com>
References: <20070914222819.7001.55921.stgit@morpheus.local>
	 <20070914223154.7001.12254.stgit@morpheus.local>
	 <b0943d9e0710080616r36142946m3e24d2f6893287c9@mail.gmail.com>
	 <20071008132524.GA11253@diana.vm.bytemark.co.uk>
	 <b0943d9e0710091401s280b3a12md9e700fb3ae007bf@mail.gmail.com>
	 <87prznxvmq.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	git@vger.kernel.org
To: "=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Thu Oct 11 22:42:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig4rX-0004Ak-9K
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 22:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755034AbXJKUmV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Oct 2007 16:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755122AbXJKUmV
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 16:42:21 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:31255 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755034AbXJKUmU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Oct 2007 16:42:20 -0400
Received: by rv-out-0910.google.com with SMTP id k20so614384rvb
        for <git@vger.kernel.org>; Thu, 11 Oct 2007 13:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YUitPHDqt0RC+4WHCgulghbfK1/Aydv2PogN5SwC4d4=;
        b=tZa6+G1Ac4vdWwvkmau2/dAhnvSb1fZTXgQ4wwE6PggttOwLWANqz9TRQdeQTVM3CHLs3UyQda6wkKaQZCcoeV6SMcvVtmd0T/03CpBkocCJSwkXhNdBFndy8ajW1ifJ6dgse7B/FbBs36Q2mZ4KSXsl5wb+Ym9kx/cQcy5+/38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N092hNLjIWKPCdoSX+provPb4v3418HRg1iS72nSLrVAAXawDKqdsb34nGJEnTpkoSfXzgN4LjIvF1S71Ruh6dl39bNTOB7CXk9nBAot7rVxZpcNLlVoBK2YKPZHZnscDXBL8zEywkLRO2OQqrfp4QwvmLIgUjh4HAevnRs5D10=
Received: by 10.140.177.15 with SMTP id z15mr1189059rve.1192135340244;
        Thu, 11 Oct 2007 13:42:20 -0700 (PDT)
Received: by 10.140.187.15 with HTTP; Thu, 11 Oct 2007 13:42:20 -0700 (PDT)
In-Reply-To: <87prznxvmq.fsf@lysator.liu.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60633>

On 10/10/2007, David K=E5gedal <davidk@lysator.liu.se> wrote:
> "Catalin Marinas" <catalin.marinas@gmail.com> writes:
> > On 08/10/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> >> Couldn't "stg pick --reverse" create a new commit and use that? Th=
at
> >> is, given that we want to revert commit C, create a new commit C* =
with
> >
> > Series.new_patch already creates a commit, why should we move the
> > functionality to 'pick'? The only call to new_patch with commit=3DF=
alse
> > seems to be from 'uncommit' (and it makes sense indeed).
>
> It might be true that the assertion could be amended so that if
> commit=3DTrue, then it is allowed to have top/bottom that doesn't
> correspond to a commit and its parent.

I'll fix this and add a test for pick --reverse.

--=20
Catalin

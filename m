From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Tue, 18 Sep 2007 14:38:52 +0200
Message-ID: <8c5c35580709180538o15619c14uf3125bea2360f88b@mail.gmail.com>
References: <8c5c35580709170817s467fa7dv375952f872bba0e3@mail.gmail.com>
	 <11900461843997-git-send-email-hjemli@gmail.com>
	 <20070918005013.GA6368@muzzle>
	 <8c5c35580709172312w55613a1bw8cc58b200c526fab@mail.gmail.com>
	 <7v4phsxy55.fsf@gitster.siamese.dyndns.org>
	 <46EF7EA1.6020402@vilain.net> <46EF9687.6070304@vilain.net>
	 <8c5c35580709180419i4500a2d4s8a997d45dd31944e@mail.gmail.com>
	 <Pine.LNX.4.64.0709181319050.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 18 14:39:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXcM1-00006m-B9
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 14:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027AbXIRMiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 08:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754264AbXIRMiz
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 08:38:55 -0400
Received: from qb-out-0506.google.com ([72.14.204.227]:65467 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753659AbXIRMiy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 08:38:54 -0400
Received: by qb-out-0506.google.com with SMTP id e11so1978453qbe
        for <git@vger.kernel.org>; Tue, 18 Sep 2007 05:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=yHgJSjSHgFhvZ2ZyZH0qVOphyJnuDPBjhtHpfu0M1g8=;
        b=ktNneTy6MxB3PDUBHBigvw6bTPxQZ7KyM0fL6PMPeOXSDVl446mM3FjVrvz3j9+z/kU7M4lHa6mIxAC2T//NdVbOZld00mxqSqA0isEnOOkklvhIBqQs9xfLc9tS6mIaRj9PQstTGNOATVoEEofWrYw3l8gMeG+DNqZcuOD51ok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iO4nee/EC33FZaJtpmXwGJW0dZYszTf40xF2RaUz5i5DZmvSLO2qB91abpUhQO8TGmw037RNaI2UfzM9fbQOcHZaFHpW4IeckXwe9zrKdPrFdQcoxFq+5kOLIHJO5WLDpRAPNNNoYRC44IbcV6Wx2kHoCyRd11TEEQZS10S4wx8=
Received: by 10.114.109.1 with SMTP id h1mr1761260wac.1190119132934;
        Tue, 18 Sep 2007 05:38:52 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Tue, 18 Sep 2007 05:38:52 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0709181319050.28586@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58597>

[...stripped the Cc, as we're slightly changing topic...]

On 9/18/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Tue, 18 Sep 2007, Lars Hjemli wrote:
> > Sidenote: this might be slightly controversial, but I've sometimes
> > missed a --no-ff option to 'git merge' when working on plain git
> > repositories; IMHO preserving the 'logical' merge history when the merge
> > of a topic branch results in a fast-forward can be interesting.
>
> Linus explained a lot of times why this is wrong.  It encourages
> upstream-downstream thinking.  We should really turn this into a FAQ.

Well, the cases where I've wanted to do this is when I've developed
some new feature in cgit as a topic branch. I've then merged the topic
branch into my master branch which had been idle since the creation of
the topic branch (cgit doesn't get as many patches as git...). So I
get a fast-forward and my precious topic-branch is no longer visible
(at least for anyone cloning my repo). Not very important, but I'd
like to preserve the fact that this was a topic branch. How would this
encourage 'upstream-downstream thinking'?

-- 
larsh

From: "Robert Anderson" <rwa000@gmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 10:34:25 -0700
Message-ID: <9af502e50806271034o7be832b2v1e84738befbf5c2b@mail.gmail.com>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
	 <20080627071014.GA12344@atjola.homenet>
	 <9af502e50806270954q613087efub0eb05c25f2eefb9@mail.gmail.com>
	 <20080627172701.GB15359@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 27 19:35:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCHr4-0006lF-8o
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 19:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718AbYF0Rea convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jun 2008 13:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752576AbYF0Rea
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 13:34:30 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:63559 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbYF0Re3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jun 2008 13:34:29 -0400
Received: by fk-out-0910.google.com with SMTP id 18so530915fkq.5
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 10:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=91n3bYPa1Z3aAXDuX9W9Am4Ehy86wjHpSZ2o1bO2ZrI=;
        b=fZe7JZLP/VCs8pVoEtbe4MisNCz1024+E8T/sELzgpXVl3t1OYhH2z7DQT2xXyKGVt
         E6mGFHoshnN6H4frDyiehUeT0M37QQP/vRg9z/uwM3JPdqJ21Dg1efZrcEXfrL3wcCHG
         JTABFUs6RQVDgZvMFoj4qa/XA93xHo/fpi9YM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=a1pbN2ZZcIGr/5Gv/4q3RleaS3+xE8yOIJJKCSSCS8DP+QQwGMgmKY58+iSFGF4/5F
         okojWCU3m5RvCO+EUE5knCo7PaDg9ZCoXmB0QLu7yh6NGZDTjfvuKvN518YYikqCuGDg
         Q8rR1A96fBSP9bfALD+889po7P2BBJDO5BZ04=
Received: by 10.82.149.8 with SMTP id w8mr69654bud.59.1214588065873;
        Fri, 27 Jun 2008 10:34:25 -0700 (PDT)
Received: by 10.82.178.10 with HTTP; Fri, 27 Jun 2008 10:34:25 -0700 (PDT)
In-Reply-To: <20080627172701.GB15359@atjola.homenet>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86608>

On Fri, Jun 27, 2008 at 10:27 AM, Bj=F6rn Steinbrink <B.Steinbrink@gmx.=
de> wrote:
>> Now I have my guess at the first commit as my tree state, correct?
>> What happens when I decide I need a couple of hunks from another fil=
e
>> which I missed in my first guess, and is now in the stashed state?
>> How do I get those out of the stash and into the working tree?  If
>> there is no convenient way to do that, then this method is not
>> sufficient to cover the use case I am talking about.
>
> git stash pop
> eventually fix conflicts if you changed the working tree in the meant=
ime
> go back to the "git add -p" step
>
> Bj=F6rn

But that pops the entire stash, right?  Inconvenient at best.

A good UI here would allow you to move pieces bidirectionally to/from
the stash at will until the desired, verifiable factorization of
changes has been achieved.

Thanks,
Bob

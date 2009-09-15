From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Commited to wrong branch
Date: Tue, 15 Sep 2009 23:53:03 +0200
Message-ID: <46a038f90909151453u5ead2eb5nebb46930a8e7277@mail.gmail.com>
References: <26ae428a0909150331q391ed39ak622902d175b46d84@mail.gmail.com>
	 <46a038f90909150355h20b39c71w4af7e2be2920fdbb@mail.gmail.com>
	 <26ae428a0909150405v3087016fxee5ac98057868677@mail.gmail.com>
	 <46a038f90909150416h60ea7d74xd2337fe50f603dcb@mail.gmail.com>
	 <26ae428a0909150510n56b1d4eg6565a6cca8c9b46c@mail.gmail.com>
	 <46a038f90909150546i508d3781id1dcd8e6c64942cf@mail.gmail.com>
	 <26ae428a0909150558i508e5878q8a1ee7cb7311fc57@mail.gmail.com>
	 <20090915130640.GC31846@atjola.homenet>
	 <46a038f90909150654t73cab47ckfd02f8a2f4353722@mail.gmail.com>
	 <20090915203948.GA14652@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Howard Miller <howard@e-learndesign.co.uk>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 15 23:53:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnfxg-0003cP-4e
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 23:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758714AbZIOVxE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2009 17:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758707AbZIOVxD
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 17:53:03 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:43526 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758517AbZIOVxB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2009 17:53:01 -0400
Received: by ewy2 with SMTP id 2so907599ewy.17
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 14:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ATyefMMSRAQDRjLk/PqovuAcIAMbWAJ+PIm88BRzkq4=;
        b=JZvh6wKxRc7gX6faNLibb4oEoC/cHAijTnbChkJ/pDTfhLj8IdEsIXmuuo20aqbcvL
         /+nn7d3gT/AdIJUEK3Dpa9uTKpjoE3NJ3SgocU9OJia+Jhswh4TbCsPjGTx1/6r7VTb7
         7UdZ7oJg/+O9EGsVltfnV2lAehLrLxyZR9Uw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dFGCj3/72msWY1pkURYlqNMf6fMpw9/4PiON3eEiF7QQd8THxAessyvhsswcdfBcHY
         y05vnLgymHZth/r513g9oQs7Rx1aLpXUdcIj04nvshH7RragSUkJvySp1O50C8e8ohXH
         mTHXPUwkpUEmHxsXWa+uJcuaLrSBeyoPelu2s=
Received: by 10.211.129.8 with SMTP id g8mr9010050ebn.71.1253051583387; Tue, 
	15 Sep 2009 14:53:03 -0700 (PDT)
In-Reply-To: <20090915203948.GA14652@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128590>

2009/9/15 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> Sooner or later you'll hit a merge conflict anyway, and conflict mark=
ers
> aren't that hard to understand, and IMHO are easier to handle than .r=
ej
> files, as you get to edit everything in-place.

When git's diff3 gets confused trying to use ancestry, the conflict
markers bring completely unrelated things that belong to the history
of the file and not to the patch at hand.

It's not about the conflict markers but somewhat nonsensical proposed
"sides" to the resolution.

> Well, you likely shouldn't be using git-apply, which is plumbing, and
> can't easily make use of the "index" information in git patches to do=
 a
> three-way merge instead of a "stupid" patch application. Instead use
> git-am --3way to make git perform a three-way merge, leading to
> conflicts instead of plain patch rejection.

Um, you got your internals wrong. git-apply is what git-am uses.

cheers,



m
--=20
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff

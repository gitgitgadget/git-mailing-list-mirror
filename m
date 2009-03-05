From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: More git bisect modes
Date: Thu, 5 Mar 2009 21:59:06 +0100
Message-ID: <200903052159.06537.chriscool@tuxfamily.org>
References: <43d8ce650903050149u4ca98444w28efceb9084efa68@mail.gmail.com> <20090305190542.6117@nanako3.lavabit.com> <43d8ce650903050217m2885692dkcef08ab2a5f60082@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 22:01:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfKhC-0003gq-Sj
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 22:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755229AbZCEVAI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2009 16:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbZCEVAH
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 16:00:07 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:40291 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755229AbZCEVAC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2009 16:00:02 -0500
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id F2308940078;
	Thu,  5 Mar 2009 21:59:53 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with ESMTP id EBCA9940149;
	Thu,  5 Mar 2009 21:59:50 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <43d8ce650903050217m2885692dkcef08ab2a5f60082@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112343>

Le jeudi 5 mars 2009, John Tapsell a =C3=A9crit :
> 2009/3/5 Nanako Shiraishi <nanako3@lavabit.com>:
> > Quoting John Tapsell <johnflux@gmail.com>:
> >> * An exponential back-off. =C2=A0Typically I know that HEAD is bro=
ken, and
> >> I don't know when it used to work.
> >
> > I thought 'git bisect' already worked with only bad commit(s) witho=
ut
> > any good commit for a long time?
>
> I believe this makes it start from the very first commit.  This
> probably much further back than most people would actually want to
> start from.
> (Also there seems to be a bug here, in that  'git bisect run' require=
s
> you to have both a good and a bad commit.  Also the man page doesn't
> document this)

Yeah you are right. Do you want to try to fix this bug ?

Thanks in advance,
Christian.

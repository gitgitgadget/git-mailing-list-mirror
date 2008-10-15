From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: builtin conversion between tabs and spaces
Date: Wed, 15 Oct 2008 08:25:40 +0200
Message-ID: <20081015062539.GB3775@blimp.localdomain>
References: <d4bc1a2a0810141839r547a770j3a8e56312afa6a53@mail.gmail.com> <d4bc1a2a0810141842q1e50c85au7d813f2e5e37a84c@mail.gmail.com> <d4bc1a2a0810141844x76223e76xf04e07ece834fc61@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Stefan Karpinski <stefan.karpinski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 08:27:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kpzql-0004Ic-Ti
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 08:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbYJOG0B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Oct 2008 02:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbYJOG0A
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 02:26:00 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:27388 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbYJOGZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 02:25:58 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx9CE89oqE=
Received: from tigra.home (Fa961.f.strato-dslnet.de [195.4.169.97])
	by post.webmailer.de (mrclete mo32) (RZmta 17.11)
	with ESMTP id V00157k9F5UUEr ; Wed, 15 Oct 2008 08:25:55 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp.localdomain (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id D786E277D0;
	Wed, 15 Oct 2008 08:25:54 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 91C9136D23; Wed, 15 Oct 2008 08:25:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <d4bc1a2a0810141844x76223e76xf04e07ece834fc61@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98236>

Stefan Karpinski, Wed, Oct 15, 2008 03:44:10 +0200:
> I find myself really wanting to enforce standards in the use of space=
s
> versus tabs. I deal with some unruly programmers who refuse to set
> their editors to use soft tabs, but I *hate* tabs in the repo. And of
> course others feel equally strongly about keeping only tabs in the
> repo (e.g. the git repo).
>=20
> This led me to wonder if it wouldn't make sense to have this
> conversion ability built into git. The following patch implements thi=
s
> functionality. It still needs work=E2=80=94it's not meant to be final=
, just to
> give an idea=E2=80=94but I just wanted to see if people on the git li=
st
> thought this sort of thing would be worthwhile at all.

Is your conversion two-way? IOW, is it possible to convert the
converted file and get the original? (Because all the existing
conversions are reversible)

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Automating svn<->git gateway
Date: Wed, 13 Oct 2010 01:25:48 +0200
Message-ID: <201010130125.49725.jnareb@gmail.com>
References: <20101011193007.GA30870@efreet.light.src> <m3eibv6vah.fsf@localhost.localdomain> <20101012203159.GC30870@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Oct 13 01:25:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5oDP-0005jC-03
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 01:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039Ab0JLXY5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Oct 2010 19:24:57 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54835 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760Ab0JLXY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 19:24:57 -0400
Received: by bwz15 with SMTP id 15so2814167bwz.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 16:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=62IwQiLKSQGSPWoX4+SJPMyNRwBw/tTA3pAmd43UalA=;
        b=fGZqDCIe1y0Ac0t5+JNPXaotxBTB9Xxp5evnGG5W3ag9Sdpz6x1zOCKFiX8DUK39Q+
         OKX2ROZTk5swQloeWrzdrjwJHdLlykKxXw/l8RULuGkEbEGptTwJMs7zGwoA78OeQT8e
         f3zg1CRSfWGm9e9hTvgFgWvO4flSQcSuujeEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=rVItqjDz3l1H8EHxHapXVJYosRZrdw1Dh0G1MjTumU4utx/4QAZz+uHiLysYftrmqZ
         MhEcrD3mPpTfnOjmtgmH/7jjGqtQniYVdGzOV43X6IJdPLN7t8Y2l2eYPZhyoW7wWXTO
         gKtYChGGt4poejfdPP2E0bqC432tg3fD4Tm/Q=
Received: by 10.204.137.193 with SMTP id x1mr6972552bkt.165.1286925894085;
        Tue, 12 Oct 2010 16:24:54 -0700 (PDT)
Received: from [192.168.1.13] (abve214.neoplus.adsl.tpnet.pl [83.8.202.214])
        by mx.google.com with ESMTPS id 4sm4761556bki.13.2010.10.12.16.24.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 16:24:52 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20101012203159.GC30870@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158898>

On wtorek 12. pa=BCdziernika 2010 22:31, Jan Hudec napisa=B3:
> On Tue, Oct 12, 2010 at 12:54:54 -0700, Jakub Narebski wrote:
> > Jan Hudec <bulb@ucw.cz> writes:
> >=20
> > > I want to set up a gateway between subversion and git, which woul=
d keep the
> > > master synchonized with subversion trunk, both ways, and allow wo=
rking with
> > > any additional branches independent of subversion. For users it s=
hould behave
> > > as any other shared git repository accessed by push and pull. And=
 it needs to
> > > be automatic.
> > >=20
> > > Did anybody try to set up something like this?
> >=20
> > It is a pity that "Native SVN support in git" project at Google Sum=
mer of
> > Code 2010 (https://git.wiki.kernel.org/index.php/SoC2010Projects) t=
urned
> > out to be too much for one summer; though people are working on it.=
  It
> > would be perfect for this situation.
>=20
> I am not actually sure it would. What I want is that for people who a=
lready
> switch to git may immediately stop caring about subversion. From thei=
r point
> of view, it shouldn't be there.
>=20
> So while I'm sure the native SVN support will solve the quirks and bu=
gs of
> git-svn, it will not do away with need for the gateway repository tha=
t will
> somehow synchronize itself with subversion.

Well, I think that native SVN support would allow to treat subversion
repository as one of repositories in the network of repositories.  Thos=
e
repositories could be set in that pushing to central git repository pus=
hes
also to subversion repository, and like central git repository fetches
from leaf repositories, it would fetch from subversion repository.

--=20
Jakub Narebski
Poland

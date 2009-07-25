From: Daniel Pittman <daniel@rimspace.net>
Subject: Re: [PATCH] git init: optionally allow a directory argument
Date: Sat, 25 Jul 2009 13:13:09 +1000
Organization: How about yours?  http://rimspace.net/resume/
Message-ID: <87r5w5h2uy.fsf@rimspace.net>
References: <20090725065928.6117@nanako3.lavabit.com>
	<7vab2t64cg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 25 05:18:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUXm8-00042B-Ht
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 05:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbZGYDSK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jul 2009 23:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751996AbZGYDSJ
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 23:18:09 -0400
Received: from main.gmane.org ([80.91.229.2]:44208 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015AbZGYDSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 23:18:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MUXls-0006wh-Sz
	for git@vger.kernel.org; Sat, 25 Jul 2009 03:18:04 +0000
Received: from ppp59-167-189-244.static.internode.on.net ([59.167.189.244])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 25 Jul 2009 03:18:04 +0000
Received: from daniel by ppp59-167-189-244.static.internode.on.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 25 Jul 2009 03:18:04 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ppp59-167-189-244.static.internode.on.net
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.96 (gnu/linux)
Cancel-Lock: sha1:aD90macbTTupHF0cIhoB7ctt6iM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123991>

Junio C Hamano <gitster@pobox.com> writes:
> Nanako Shiraishi <nanako3@lavabit.com> writes:
>
>> When starting a new repository, I see my students often say
>>     % git init newrepo
>> and curse git.  They could say
>>     % mkdir newrepo; cd newrepo; git init
>> but allowing it as an obvious short-cut may be nicer.
>>
>> Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
>
> Hmm, I didn't realize this is so common a wish among new people.  The=
 patch
> seems clean.  Anybody has comments, both on code and the use case?

It still surprises me that git doesn't do this, since it is at odds wit=
h
almost every other version control system I have on hand or experience =
with,
other than CVS; Subversion, svk, Bazaar and Mercurial all take a traili=
ng
target argument.

CVS and monotone take an option to specify where; only darcs is like gi=
t and
uses the current directory as the target.

So, from where I sit it makes sense to have 'git init foo' create a 'fo=
o'
directory and repository below the current location.

Regards,
        Daniel

=2E..and, yeah, I still get caught every now and then when I create a n=
ew
repository by hand.
--=20
=E2=9C=A3 Daniel Pittman            =E2=9C=89 daniel@rimspace.net      =
      =E2=98=8E +61 401 155 707
               =E2=99=BD made with 100 percent post-consumer electrons

From: Christian Neukirchen <chneukirchen@gmail.com>
Subject: Re: Question about rerere
Date: Thu, 06 Nov 2014 17:41:26 +0100
Message-ID: <87oaske0y1.fsf@gmail.com>
References: <F9D7CE90-BED2-4694-B5DB-AE848C9F3F34@phare.normalesup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 06 18:10:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmQZa-00079m-I6
	for gcvg-git-2@plane.gmane.org; Thu, 06 Nov 2014 18:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbaKFRKK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Nov 2014 12:10:10 -0500
Received: from plane.gmane.org ([80.91.229.3]:53094 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407AbaKFRKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2014 12:10:09 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1XmQZQ-0006zs-QA
	for git@vger.kernel.org; Thu, 06 Nov 2014 18:10:04 +0100
Received: from host55-2.natpool.mwn.de ([138.246.2.55])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 06 Nov 2014 18:10:04 +0100
Received: from chneukirchen by host55-2.natpool.mwn.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 06 Nov 2014 18:10:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: host55-2.natpool.mwn.de
In-Reply-To: <F9D7CE90-BED2-4694-B5DB-AE848C9F3F34@phare.normalesup.org>
	(Tristan Roussel's message of "Thu, 6 Nov 2014 12:30:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tristan Roussel <troussel@phare.normalesup.org> writes:

> Hello,
>
> I=E2=80=99ve just learnt about rerere and it=E2=80=99s going to make =
my life so much
> easier, I have a question though.
>
> I enabled rerere very lately and I wanted to know if there was a way
> to feed rerere with old merge conflict resolutions (and if not, would
> it be considered a good feature request)? I=E2=80=99d like to do a re=
base of
> my work because I unintentionally merged a branch I didn=E2=80=99t wa=
nt and
> the merge is a bit far in the git history and I don=E2=80=99t want to
> re-resolve merge conflicts I had after that.

Have a look at contrib/rerere-train.sh.

(Which I learned from
http://git-blame.blogspot.de/2012/04/rebuilding-git-integration-environ=
ment.html)

Ciao,
--=20
Christian Neukirchen  <chneukirchen@gmail.com>  http://chneukirchen.org

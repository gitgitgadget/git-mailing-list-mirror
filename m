From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 3/6] completion: add common options for blame
Date: Mon, 3 Jun 2013 20:07:01 +0200
Message-ID: <20130603180701.GJ2192@goldbirke>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
 <1370181822-23450-4-git-send-email-artagnon@gmail.com>
 <87mwr7zhv5.fsf@linux-k42r.v.cablecom.net>
 <CALkWK0kR2fCQcO9XurzjOGF19vaC67p5kMpkJL=Vbu1Ovku18w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 20:07:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjZ9x-000171-QF
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 20:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758938Ab3FCSHG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Jun 2013 14:07:06 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:56512 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883Ab3FCSHE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 14:07:04 -0400
Received: from localhost6.localdomain6 (f051128111.adsl.alicedsl.de [78.51.128.111])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0M3O8y-1URlG20ag4-00qnty; Mon, 03 Jun 2013 20:07:02 +0200
Content-Disposition: inline
In-Reply-To: <CALkWK0kR2fCQcO9XurzjOGF19vaC67p5kMpkJL=Vbu1Ovku18w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:I6aAvUkXbyXjcnHTip+HqumLb43pj0eD7+GceoA5sMk
 dkUViLr7m/ay2/B+uRdVIh/KCY1jVKOizyUjIPNUOpTj14f0bh
 8EfSbZwCQjjxgkJZ0oyd24Bou4OJcdKIw3tTwfUD1QYLA0NR0O
 P5mVcbmmACuVL3TmIqbgxbkIG38s+8xhtpNENlmcFIa4qwEWUe
 USkgRXwwj7yJAJ//tm1ThNnzEtkbigcWO0SUAIAcuPF/OELAYN
 jnxZAvyCjJkoku1UASxUfjYBOFpGHTtH8rTcxURwkgT+2QQdVr
 zmtzQ78LOdxjF7AbigDCXwtoT+yhd82y1DNUNjKYTE2K1KQm/G
 WLIjX3mdNvdnUxwDVvd8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226257>

On Mon, Jun 03, 2013 at 03:02:00PM +0530, Ramkumar Ramachandra wrote:
> Thomas Rast wrote:
> > Is this the first time we introduce completion (I guess you could c=
all
> > it "help") for short options?  I only did a quick search for /-. -/=
 but
> > it certainly seems that way.
>=20
> Yeah.  We generally prefer the long-form equivalents while doing
> completions, but these blame options do not have equivalent
> long-forms.

But providing short options for completion is pointless.  Those who
know git blame's short options will just type them right away, because
it requires less key presses than using completion, and those who
don't know these options will only see -C, -M, etc. and won't have any
clues what it stands for.


Best,
G=E1bor

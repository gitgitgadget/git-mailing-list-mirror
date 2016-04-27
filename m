From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] merge: warn --no-commit merge when no new commit is
 created
Date: Wed, 27 Apr 2016 17:37:04 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604271732570.2896@virtualbox>
References: <874mb0kkkk.fsf@gmail.com> <alpine.DEB.2.20.1604180825170.2967@virtualbox> <CAH5451kW3t1Y7oW=uHv85jzHwsnQcDK2jdLisauNF-x1LRwqLA@mail.gmail.com> <87a8krpehl.fsf@gmail.com> <CAH5451mDYhavx_OLfXe6cC2WguCsFWEBBBBOCPyX3E6ZJw27+w@mail.gmail.com>
 <xmqqy48a6fht.fsf@gitster.mtv.corp.google.com> <xmqqtwiy6end.fsf@gitster.mtv.corp.google.com> <xmqqd1pcdpb8.fsf_-_@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1604270846430.2896@virtualbox> <xmqqinz3axvc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Christoph Paulik <cpaulik@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 17:37:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avRWy-0008S2-Fq
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 17:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593AbcD0Ph1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 11:37:27 -0400
Received: from mout.gmx.net ([212.227.15.15]:63919 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753405AbcD0PhX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 11:37:23 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lfjxq-1bSray03Vi-00pKLN; Wed, 27 Apr 2016 17:37:06
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqinz3axvc.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:pD8k9y/PTJFMBptoZnUmeUwx/2iCALd2Eyre+Alru+qJ5kymxPN
 UNr70Ah3VqbDRZSCymxGtZq9wCKfJiYO2bFxyV0+1Xx3g8BvST/InH/1vsDpbYkS7Z3m1VV
 0Ur8C1EKRRvYRnT6pIGg/7T6Br3UDgv40qausui6SbqVFkbAt7SzU8ncbJk8KTRBsADhrZA
 gMaUo4h1EX+HyvLwp26Tg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3i47n+xnEz4=:oyxDWmMQjVstrbLIfnV1ck
 mhoBNO5QeVLof4pcwbbTaHO4yM3YCZ8Xb803CWWdLfXbNYheDgyDOAFCPWyGLrr3rRechCKaa
 tqxo9ASxfGpfGRneiXnbnKm+r1xYGc3Vncsz1Bftt3uiayIGHkCoCGow8s9ApWQ7/gtvEQQ5B
 Qrqc9W0UntnzwizgoaTBBE+N70y4eACmUjQ9xw1vZYwL4/mtFrvP0V56JkN+Te3Rqni4QrqLf
 UUqy04ZJx8Zzw/pt4jkICcQt6+Z7R6dvo98Fk4zunwKNQku/oXgOQRlGZvjSCHy2Vc5glnz2l
 OlLlrYhRTmK4TYAxLFwjjTSYFHjrzdE5sE1FlP78Iv4OIPXjU+s9IJc7WvFD3JEl3edhcvrFu
 ycGSwpxbBjhgTxeBWClXofMIlYXO9/JNiS/fHDPJRanIBqq1xJACDmK/xuP0dV1dfdgOauZ0m
 e3sVp9CxRfee6pP6zHVvKP3mONI6nlp9bFLU+nARaqGxIVC1Zp5GtLubDK+AXybNOH0l01Ys8
 djCOyupiCWj8CfKJ0apDvKXA4UAFZ/2GNqMHaEiLp+FJyOtg1gQhro0ubf3WF9RKsmtH/fleI
 F/s8JJkY9EoYn5J32TJC//rg1TbIeBd70EIJe3QZmrlNKQ8uBKRDnr+oR9c9NSRi1MLQxTTTr
 T6ZJ+6tBRQP2uBvh/UKFCRdVi5yq83wrVkQV4MQTAwwwPqdIluzef/vLTWv0X2Fj3KGkWtgjH
 FPK+ZXQXbha50RDBo9Vit0hk8kCYx5DBv65SnBRL4bvGWyiXOXD4JQkM3dioZQyaBTTqNRox 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292734>

Hi Junio,

On Wed, 27 Apr 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I am not sure about this double negation "no_commit_impossible" (I only
> > understood what you meant because I had read the commit message first,
> > something I won't do when stumbling over this code later).
> >
> > Maybe something like `disallow_no_commit`?
> 
> That would be the best name once we start dying in there.  It might
> be still better, even while we merely warn but let it pass, than the
> double negative.  Or it may not.  I dunno.

Actually, I should admit that I was really puzzled by the name at first. I
thought that some commits were impossible, but the function said that no
commit was impossible. So I thought: but what if a commit references
itself as parent, would that not be impossible? But actually, once SHA-1
collision attacks become feasible, I guess it would not be impossible.
Making for an excellent attack vector, say, on repository hosting sites
(which would now be stuck in infinite loops due to a violation of the
temporal prime directive).

So yeah, this was my thought process when I read no_commit_impossible.

;-)

Ciao,
Dscho

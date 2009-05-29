From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [RFC][StGit PATCH] Add support for merge-friendly branches
Date: Fri, 29 May 2009 13:59:20 +0200
Message-ID: <20090529115920.GA14429@diana.vm.bytemark.co.uk>
References: <20090528111212.21925.45527.stgit@pc1117.cambridge.arm.com> <20090528124817.GA22262@diana.vm.bytemark.co.uk> <b0943d9e0905280738n51476ab7vd0498ea7a236c4a7@mail.gmail.com> <20090529083739.GB9760@diana.vm.bytemark.co.uk> <b0943d9e0905290216m3c2bb639kc951510c72212ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 29 13:59:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA0kE-0000JW-Em
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 13:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757896AbZE2L7V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 May 2009 07:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757657AbZE2L7U
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 07:59:20 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:50905 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815AbZE2L7U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 07:59:20 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1MA0k4-0003ng-00; Fri, 29 May 2009 12:59:20 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0905290216m3c2bb639kc951510c72212ff@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120272>

On 2009-05-29 10:16:52 +0100, Catalin Marinas wrote:

> 2009/5/29 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > The situation I described looks like this:
> >
> > =A0 =A0B--o--o--o--o--o--P--T
> >
> > Time goes from left to right. B is the stack base, P the head of
> > the public branch, T the stack top. merge_base(P, T) is P, and not
> > B.
>
> I don't check merge_base(P, T) but merge_base(P, B) to avoid the
> issues you described. So that's always B.

Ah, so that's where I got myself confused. Thanks.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

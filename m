From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] Use Python's "print" as a function, not as a keyword
Date: Tue, 27 Dec 2011 11:41:31 -0500
Message-ID: <20111227164131.GB29842@padd.com>
References: <20111221021930.GA31364@thinkpad>
 <CACBZZX7PVyCFfHTJN_QZfyt5wAcr4UAiJSmo54PSi=8pgv3sYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Morr <sebastian@morr.cc>, git@vger.kernel.org,
	srabbelier@gmail.com
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 27 17:41:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rfa5q-00048R-VC
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 17:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194Ab1L0Qle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 11:41:34 -0500
Received: from honk.padd.com ([74.3.171.149]:56980 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754047Ab1L0Qld (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 11:41:33 -0500
Received: from tic.padd.com (unknown [69.177.230.108])
	by honk.padd.com (Postfix) with ESMTPSA id B839E31BF;
	Tue, 27 Dec 2011 08:41:32 -0800 (PST)
Received: by tic.padd.com (Postfix, from userid 1000)
	id CFB5F102221; Tue, 27 Dec 2011 11:41:31 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CACBZZX7PVyCFfHTJN_QZfyt5wAcr4UAiJSmo54PSi=8pgv3sYA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187722>

avarab@gmail.com wrote on Wed, 21 Dec 2011 03:48 +0100:
> On Wed, Dec 21, 2011 at 03:19, Sebastian Morr <sebastian@morr.cc> wrote:
> 
> > But, as nobody seems to have cared before: Is Git designed to be
> > compatible only with versions prior 3.0?
> 
> I'm running Debian unstable and it has Python 2.7. Most people are
> still using Python 2.x as their default system Python since 3.x breaks
> backwards compatibility for common constructs like print.
>
> Does this only break Python 2.6, or all 2.x versions of Python?
> 
> What's our currently supported Python version for the Python code in
> Git? It's 5.8.0 for Perl, do we have any particular aim for a
> supported Python version?

I test contrib/fast-import/git-p4 on python 2.5 and 2.7.  I'm
hesitant to convert print() now, without committing to testing on
post-3.0 too.  The work to support 3.x doesn't buy us much.

		-- Pete

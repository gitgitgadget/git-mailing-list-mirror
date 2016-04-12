From: Philip Li <philip.li@intel.com>
Subject: Re: 0 bot for Git
Date: Tue, 12 Apr 2016 23:15:10 +0800
Message-ID: <20160412151509.GA14522@intel.com>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com>
 <CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
 <vpq60vnl28b.fsf@anie.imag.fr>
 <CAGZ79kaLQWVdehMu4nas6UBpCxnAB_-p=xPGH=aueMZXkGK_2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, lkp@intel.com,
	Greg KH <gregkh@linuxfoundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 17:13:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq00Q-0005x5-Kz
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 17:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbcDLPN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 11:13:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:1641 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933499AbcDLPNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 11:13:25 -0400
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP; 12 Apr 2016 08:11:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,474,1455004800"; 
   d="scan'208";a="83760014"
Received: from rli9-hp-compaq-8200-elite-sff-pc.sh.intel.com (HELO intel.com) ([10.239.159.88])
  by fmsmga004.fm.intel.com with ESMTP; 12 Apr 2016 08:11:42 -0700
Content-Disposition: inline
In-Reply-To: <CAGZ79kaLQWVdehMu4nas6UBpCxnAB_-p=xPGH=aueMZXkGK_2Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291266>

On Tue, Apr 12, 2016 at 07:52:02AM -0700, Stefan Beller wrote:
> On Tue, Apr 12, 2016 at 12:23 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
> > Stefan Beller <sbeller@google.com> writes:
> >
> >> Hi Greg,
> >>
> >> Thanks for your talk at the Git Merge 2016!
> >> The Git community uses the same workflow as the kernel. So we may be
> >> interested in the 0 bot which could compile and test each patch on the list.
> >
> > In the case of Git, we already have Travis-CI that can do rather
> > thorough testing automatically (run the complete testsuite on a clean
> > machine for several configurations). You get the benefit from it only if
> > you use GitHub pull-requests today.
> 
> But who uses that? (Not a lot of old-timers here, that's for sure)
> 
> > It would be interesting to have a
> > bot watch the list, apply patches and push to a travis-enabled fork of
> > git.git on GitHub to get the same benefit when posting emails directly
> > to the list.
> 
> That is better (and probably more work) than what I had in mind.
> IIUC the 0 bot can grab a patch from a mailing list and apply it to a
> base (either the real base as encoded in the patch or a best guess)
> and then run "make".
> 
> At least that's how I understand the kernel setup. So my naive thought
> is that the 0 bot maintainer "only" needs to add another mailing list
> to the watch list of the 0 bot?

yes, this is feasible in 0 bot, though it requires some refactoring to current
mailing list logic which focuses on linux kernel like using guess work to find
out which maintainer tree to apply a patch on by following a set of rules. 
After the current proposal to add extra info to git-format-patch is accepted,
this can be more smooth.

> 
> Stefan
> 
> >
> > --
> > Matthieu Moy
> > http://www-verimag.imag.fr/~moy/
> 

From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 3/5] Run the perf test suite for profile feedback too
Date: Mon, 7 Jul 2014 15:15:07 -0700
Message-ID: <20140707221507.GV19781@tassilo.jf.intel.com>
References: <1404517432-25185-1-git-send-email-andi@firstfloor.org>
 <1404517432-25185-4-git-send-email-andi@firstfloor.org>
 <xmqq1ttwdgjy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Kleen <andi@firstfloor.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 00:15:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4HBt-00087z-0N
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 00:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbaGGWPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 18:15:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:18449 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751205AbaGGWPK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 18:15:10 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 07 Jul 2014 15:15:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,621,1400050800"; 
   d="scan'208";a="558531310"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.157])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jul 2014 15:15:08 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id 85DA0302332; Mon,  7 Jul 2014 15:15:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqq1ttwdgjy.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252991>

On Mon, Jul 07, 2014 at 02:06:57PM -0700, Junio C Hamano wrote:
> Andi Kleen <andi@firstfloor.org> writes:
> 
> > From: Andi Kleen <ak@linux.intel.com>
> >
> > Open: If the perf test suite is representative enough it may
> > be reasonable to only run that and skip the much longer full
> > test suite. Thoughts?
> 
> I do not think it right now is representative, nor it was meant to
> become so.  The operations are those that people cared about and
> tuned, and hopefully it would cover stuff actual end users care
> about in the real life, though.

I ended up answering the question by creating two separate 
makefile targets in the next patch.

profile to run the full test suite and profile-fast to run
only the performance test. profile-fast as the name implies
is a lot faster to build, and fast enough that it's not 
annoying.

I'll remove the "Open"

-Andi

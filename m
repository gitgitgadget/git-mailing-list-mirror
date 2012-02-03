From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH, RFC] Fix build problems related to profile-directed
 optimization
Date: Fri, 3 Feb 2012 10:39:21 -0800
Message-ID: <20120203183921.GA29944@tassilo.jf.intel.com>
References: <1328209417-8206-1-git-send-email-tytso@mit.edu>
 <7vvcnpuhpo.fsf@alter.siamese.dyndns.org>
 <20120202201226.GA1032@thunk.org>
 <7vvcnou40u.fsf@alter.siamese.dyndns.org>
 <20120203020743.GE1032@thunk.org>
 <7vr4ycsbga.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ted Ts'o <tytso@mit.edu>, git@vger.kernel.org,
	Clemens Buchacher <drizzd@aon.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 19:39:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtO30-0003AB-PX
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 19:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757448Ab2BCSjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 13:39:42 -0500
Received: from mga02.intel.com ([134.134.136.20]:49326 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757008Ab2BCSjl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 13:39:41 -0500
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP; 03 Feb 2012 10:39:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; 
   d="scan'208";a="103640559"
Received: from tassilo.jf.intel.com ([10.7.201.151])
  by orsmga001.jf.intel.com with ESMTP; 03 Feb 2012 10:39:40 -0800
Received: by tassilo.jf.intel.com (Postfix, from userid 501)
	id 0EA08242780; Fri,  3 Feb 2012 10:39:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vr4ycsbga.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189791>


Thanks everyone for improving this.

I should add that any improvements will depend on your compiler version.
I would also expect better numbers when combined with LTO in gcc 4.7,
but haven't tried so far.

BTW it would be really nice to figure out a subset of the test suite
that runs faster and gives similar speedup like the full one.

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only

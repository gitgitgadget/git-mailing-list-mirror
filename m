From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 5/5] Add a little script to compare two make perf runs
Date: Sun, 6 Jul 2014 09:15:27 -0700
Message-ID: <20140706161527.GU19781@tassilo.jf.intel.com>
References: <1404517432-25185-1-git-send-email-andi@firstfloor.org>
 <1404517432-25185-6-git-send-email-andi@firstfloor.org>
 <CAKPyHN3rz+TUkcpAS3151XZo+zK2Un=LOrQ_A=TVo4QQ_EUsDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Kleen <andi@firstfloor.org>,
	Git Mailing List <git@vger.kernel.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 18:15:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3p6D-0003sQ-Gc
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jul 2014 18:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbaGFQP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2014 12:15:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:58580 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492AbaGFQP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2014 12:15:28 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 06 Jul 2014 09:09:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,612,1400050800"; 
   d="scan'208";a="569044486"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.157])
  by orsmga002.jf.intel.com with ESMTP; 06 Jul 2014 09:15:27 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id 91710302336; Sun,  6 Jul 2014 09:15:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKPyHN3rz+TUkcpAS3151XZo+zK2Un=LOrQ_A=TVo4QQ_EUsDg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252938>

> a justification why the geometric mean is used here would increase my
> confident significantly.

It's just a standard way to summarize sets of benchmarks. For example SPEC 
uses the same approach.

Anyways the script is not essential to the rest of the profile feedback
feature.  Just ignore it if it's controversal.

-Andi

From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: remove all traces of some files
Date: Wed, 27 Apr 2011 22:37:50 +0200
Message-ID: <4DB87E9E.8060700@kdbg.org>
References: <BANLkTim_PriowuBH71M2DxxkJ=Y5oAA2uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Frederich <eric.frederich@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 22:37:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFBUj-0000IT-Cm
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 22:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759212Ab1D0Uhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 16:37:52 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:4114 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756847Ab1D0Uhv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 16:37:51 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 6DA4513004B;
	Wed, 27 Apr 2011 22:37:50 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 4C03F19F35B;
	Wed, 27 Apr 2011 22:37:50 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.14) Gecko/20110221 SUSE/3.1.8 Thunderbird/3.1.8
In-Reply-To: <BANLkTim_PriowuBH71M2DxxkJ=Y5oAA2uA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172270>

Am 27.04.2011 21:58, schrieb Eric Frederich:
> I have been adding build files (.dll and .so files) to my git
> repository periodically when I have been doing builds of my project.
> I know I shouldn't be doing this and want to set up some other kind of
> separate archive or something for built files.
> 
> Although there are other devs on the project, I am the only one using
> Git.  Everyone else uses AccuRev.
> Personally, I maintain my own Git repo (with an AccuRev git branch).
> 
> I would like to remove all traces of those .dll and .so files if I
> could in my git repository.
> I realize this would mess with hashes and would ultimately result in a
> completely new tree.
> I am fine with that since, as I said, I am the only user of this Git repo.
> 
> So, can this be done?  Can I rebuild the tree preserving commit
> messages, timestamps, etc but ignoring certain files?

Get familiar with git-filter-branch --index-filter.

-- Hannes

From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: make git ignore the timestamp embedded in PDFs
Date: Tue, 14 May 2013 21:26:32 +0200
Message-ID: <51928FE8.2050804@kdbg.org>
References: <87y5bhn1iw.fsf@med.uni-goettingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Leha <andreas.leha@med.uni-goettingen.de>
X-From: git-owner@vger.kernel.org Tue May 14 21:48:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcLDM-00013Z-2c
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 21:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758247Ab3ENTsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 15:48:43 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:38102 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757872Ab3ENTsn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 15:48:43 -0400
X-Greylist: delayed 1325 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 May 2013 15:48:42 EDT
Received: from bsmtp.bon.at (unknown [10.232.130.106])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 340DCCE2F6
	for <git@vger.kernel.org>; Tue, 14 May 2013 21:26:53 +0200 (CEST)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id A9ED910016;
	Tue, 14 May 2013 21:26:34 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 55D6319F5CF;
	Tue, 14 May 2013 21:26:33 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <87y5bhn1iw.fsf@med.uni-goettingen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224327>

Am 14.05.2013 15:17, schrieb Andreas Leha:
> Hi all,
> 
> how can I make git ignore the time stamp(s) in a PDF.  Two PDFs that
> differ only in these time stamps should be considered identical.
> ...
> What I tried is a filter:
> ,----[ ~/.gitconfig ]
> | [filter "pdfresetdate"]
> |         clean = pdfresetdate
> `----
> 
> This 'works' as far as the committed pdf indeed has the date reset to my
> default value.
> 
> However, when I re-checkout the files, they are marked modified by git.

I'm using cleaned files every now and then, but not on Linux. I have
never observed this behavior recently.

If you 'git add' the file, does it keep its modified state? Does 'git
diff' tell a difference?

-- Hannes

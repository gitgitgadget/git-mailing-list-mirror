From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Ignore end-of-line style when computing similarity score
 for rename detection
Date: Thu, 28 Jun 2007 11:17:09 -0700
Message-ID: <4683FB25.3080204@midwinter.com>
References: <20070628060416.GA13162@midwinter.com> <Pine.LNX.4.64.0706281340090.4438@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 28 20:17:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3yYO-0007a6-S8
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 20:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430AbXF1SRO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 14:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755623AbXF1SRO
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 14:17:14 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:35678
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1754946AbXF1SRN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 14:17:13 -0400
Received: (qmail 31282 invoked from network); 28 Jun 2007 18:17:12 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=JBPrbi+auUZstLY45oxqUeXKN9gOmYWrycjzZeMclFiYmsyf8HaOP3wEbXHxowuh  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 28 Jun 2007 18:17:12 -0000
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
In-Reply-To: <Pine.LNX.4.64.0706281340090.4438@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51122>

Johannes Schindelin wrote:
> Somehow I think that this should be triggered by "--ignore-space-at-eol", 
> _and_ be accompanied by a test case.
>   

Should --ignore-space-at-eol be an option to git-merge? Merges are where 
this functionality matters; for simple diffs, --ignore-space-at-eol 
actually already covers it. If we allow that option, should we also 
allow other git-diff options like --ignore-all-space and 
--ignore-space-change? What are the semantics of an autoresolved merge 
with those options in effect -- are they only used for rename detection, 
or do we, e.g., not flag conflicts with only whitespace changes? And if 
we don't, which version do we accept automatically?

-Steve

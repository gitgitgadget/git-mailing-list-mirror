From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFCv3 2/4] Add Python support library for CVS remote helper
Date: Thu, 13 Aug 2009 02:00:30 +0200
Message-ID: <4A83579E.70302@alum.mit.edu>
References: <1250036031-32272-1-git-send-email-johan@herland.net> <1250036031-32272-3-git-send-email-johan@herland.net> <20090812021017.GB62301@gmail.com> <200908121108.28714.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	barkalow@iabervon.org, gitster@pobox.com,
	Johannes.Schindelin@gmx.de
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Aug 13 02:01:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbNkv-0003Ir-O0
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 02:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbZHMAAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 20:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbZHMAAq
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 20:00:46 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:52718 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbZHMAAp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 20:00:45 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.129] (p4FC1FAB6.dip.t-dialin.net [79.193.250.182])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id n7D00VhA022215
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 13 Aug 2009 02:00:32 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.22) Gecko/20090608 Thunderbird/2.0.0.22 Mnenhy/0.7.6.666
In-Reply-To: <200908121108.28714.johan@herland.net>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125758>

Johan Herland wrote:
> On Wednesday 12 August 2009, David Aguilar wrote:
>> On Wed, Aug 12, 2009 at 02:13:49AM +0200, Johan Herland wrote:
>>> +	def __init__ (self, date, author, message):
>>> +		self.revs    = {}      # dict: path -> CvsRev object
>>> +		self.date    = date    # CvsDate object
>>> +		self.author  = author
>>> +		self.message = message # Lines of commit message
>> pep8 and other parts of the git codebase recommend against
>> lining up the equals signs like that.  Ya, sorry for the nits
>> being that they're purely stylistic.
> 
> I can't find a good rationale for this rule in PEP8 (other than Guido's 
> personal style), and I personally find the above much more readable 
> (otherwise I wouldn't go through the trouble of lining them all up...). Can 
> I claim exception (1) (readability)?

I think you are missing the point.  It may be true that the rules in
PEP8 were *originally* written according to the unjustified whims of the
BDFL, but now that they are established the reason for following them is
not that Guido likes them but rather to be consistent with the bulk of
other Python code on the planet.

With respect to the rule to use 4-space indents, there are serious
practical problems with using tabs *in addition to* the consistency
argument.

Michael
